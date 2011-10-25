use Pod::Tree;
use Pod::Tree::PerlMap;
use Pod::Tree::PerlPod;

  $perl_map = new Pod::Tree::PerlMap;
$opts{hr}=3;
$opts{title}="Mogreet SDK";
  $perl_pod = new Pod::Tree::PerlPod "pod", "doc html", $perl_map, %opts;

  $perl_pod->scan;
  $perl_pod->index;
  $perl_pod->translate;
  
  $top = $perl_pod->get_top_entry;