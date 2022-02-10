use strict;
use warnings;

use Log::Log4perl qw(:easy);
use XML::LibXML;
use JSON qw( );
use ROK4::COMMON::ProxyGDAL;

Log::Log4perl->easy_init({
    level => $INFO,
    layout => '%5p : %m (%M) %n'
});

my $parser  = XML::LibXML->new();
my @tms_xmls = `find . -name "*.tms"`;

# Pour le calcul des scale denominator à partir des resolutions
my $METER_PER_DEG = 111319.492;
my $PIXEL_SIZE = 0.00028;

for my $tms_xml (@tms_xmls) {
    chomp($tms_xml);
    my $id = File::Basename::basename($tms_xml, ".tms");
    INFO($id);

    my $tms_object = {
        id => $id,
        tileMatrices => []
    };

    # read xml pyramid
    my $xmltree =  eval { $parser->parse_file($tms_xml); };

    if (! defined ($xmltree) || $@) {
        ERROR (sprintf "Can not read the XML file TMS : %s !", $@);
        next;
    }

    my $root = $xmltree->getDocumentElement;

    $tms_object->{crs} = uc($root->findnodes('crs'));
    my $sr = ROK4::COMMON::ProxyGDAL::spatialReferenceFromSRS($tms_object->{crs});

    if (ROK4::COMMON::ProxyGDAL::isGeographic($sr)) {
        $tms_object->{orderedAxes} = ["Lon", "Lat" ];
    } else {
        $tms_object->{orderedAxes} = ["X", "Y" ];
    }

    my @TMs = $root->getElementsByTagName('tileMatrix');
  
    # load tileMatrix
    foreach my $tm (@TMs) {
        # we identify level max (with the best resolution, the smallest) and level min (with the 
        # worst resolution, the biggest)

        my $res = $tm->findvalue('resolution');
        my $scale;
        if (ROK4::COMMON::ProxyGDAL::isGeographic($sr)) {
            $scale = $res * $METER_PER_DEG / $PIXEL_SIZE;
        } else {
            $scale = $res / $PIXEL_SIZE;
        }

        push(
            @{$tms_object->{tileMatrices}}, 
            {
                id => $tm->findvalue('id'),
                scaleDenominator => 0 + $scale,
                cellSize => 0 + $res,
                pointOfOrigin => [0 + $tm->findvalue('topLeftCornerX'), 0 + $tm->findvalue('topLeftCornerY')],
                tileWidth => 0 + $tm->findvalue('tileWidth'),
                tileHeight => 0 + $tm->findvalue('tileHeight'),
                matrixWidth => 0 + $tm->findvalue('matrixWidth'),
                matrixHeight => 0 + $tm->findvalue('matrixHeight')
            }
        );
    }

    open(STREAM, ">$id.json") or do {
        ERROR("Impossible d'écrire en JSON dans $id.json");
        next;
    };

    print STREAM JSON::to_json($tms_object, {pretty => 1});

    close(STREAM);
    
}

exit(1);