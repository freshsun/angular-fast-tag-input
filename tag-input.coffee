angular.module('tag-input', [])
.directive('tagInput', ['$templateCache','$parse', ($templateCache, $parse) ->
  return {
    restrict:'EA'
    template: $templateCache.get('components/tag-input/tag-input.html')
    transclude: 'element'
    replace: true
    priority: 10 #needed for ng-model work
    scope:{}
    controller: ($scope,$attrs)->
      tags = $scope.tags = []
      $scope.addTag = (tagText)->
        $scope.$apply(->
          tags.push(tagText)
          serializedTags = tags.join(' ')
          $parse($attrs.ngModel).assign $scope.$parent, serializedTags
        )

    link: (scope,element,attr,ctrl,transcludeFn)->
      input_box = element.find('.input-box')
      input_box.on('keypress', (event)->
        if event.which == 32
          scope.addTag(event.target.value)
          input_box.val('')

          event.preventDefault()
          event.stopPropagation()
      )

      transcludeFn(scope.$parent,(clone,scope)->).insertAfter(element)
      #transcludeFn().insertAfter(element)

  }
])
.directive('itag',['$templateCache', ($templateCache) ->
  return {
    restrict:'EA'
    template: $templateCache.get('components/tag-input/tag.html')
    transclude:true
    replace:true
  }
])
