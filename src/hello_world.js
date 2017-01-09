(function(Opal) {
  var self = Opal.top, $scope = Opal, nil = Opal.nil, $breaker = Opal.breaker, $slice = Opal.slice, $klass = Opal.klass, $hash2 = Opal.hash2;

  Opal.add_stubs(['$createElement', '$div']);
  return (function($base, $super) {
    function $App(){};
    var self = $App = $klass($base, $super, 'App', $App);

    var def = self.$$proto, $scope = self.$$scope, TMP_1, TMP_3;

    Opal.defn(self, '$div', TMP_1 = function $$div(props) {
      var self = this, $iter = TMP_1.$$p, block = $iter || nil;

      if (props == null) {
        props = $hash2([], {});
      }
      TMP_1.$$p = null;
      return $scope.get('React').$createElement("div", props, block);
    }, TMP_1.$$arity = -1);

    return (Opal.defn(self, '$render', TMP_3 = function $$render() {
      var $a, $b, TMP_2, self = this;

      return ($a = ($b = self).$div, $a.$$p = (TMP_2 = function(){var self = TMP_2.$$s || this;

      return "Hello World"}, TMP_2.$$s = self, TMP_2.$$arity = 0, TMP_2), $a).call($b, $hash2(["className"], {"className": "bar"}));
    }, TMP_3.$$arity = 0), nil) && 'render';
  })($scope.base, (((($scope.get('React')).$$scope.get('Component'))).$$scope.get('Base')))
})(Opal);