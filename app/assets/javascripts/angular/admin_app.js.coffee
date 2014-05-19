adminapp = angular.module "AdminTextAngular", ['textAngular']

# angular.module("AdminTextAngular").controller 'FormCtrl',
#   ['$scope',
#   ($scope) ->

#     $scope.htmlContent2 = 'ololo'

# ]

adminapp.config ($provide) ->
  $provide.decorator 'taOptions', ['$delegate', (taOptions) ->
    taOptions.toolbar = [
      ['h2', 'h3', 'p', 'pre', 'quote'],
      ['bold', 'italics', 'underline', 'ul', 'ol'],
      ['justifyLeft','justifyCenter','justifyRight'],
      ['html', 'insertImage', 'insertLink', 'insertVideo'],
      ['undo','redo', 'clear']
    ]
    return taOptions
  ]
  $provide.decorator 'taTools', ['$delegate', (taTools) ->
    taTools.h2.buttontext = 'Заголовок'
    taTools.h3.buttontext = 'Подзаголовок'
    taTools.bold.iconclass = 'glyphicon glyphicon-bold'
    taTools.italics.iconclass = 'glyphicon glyphicon-italic'
    # taTools.underline.iconclass = 'glyphicon glyphicon-underline'
    delete taTools.underline.iconclass
    taTools.underline.buttontext = '<u>Подчеркнутый</u>'
    taTools.ul.iconclass = 'glyphicon glyphicon-list'
    taTools.ol.iconclass = 'glyphicon glyphicon-list-alt'
    taTools.undo.iconclass = 'glyphicon glyphicon-backward'
    taTools.redo.iconclass = 'glyphicon glyphicon-forward'
    taTools.justifyLeft.iconclass = 'glyphicon glyphicon-align-left'
    taTools.justifyRight.iconclass = 'glyphicon glyphicon-align-right'
    taTools.justifyCenter.iconclass = 'glyphicon glyphicon-align-center'
    taTools.clear.iconclass = 'glyphicon glyphicon-ban-circle'
    taTools.insertLink.iconclass = 'glyphicon glyphicon-link'
    # taTools.unlink.iconclass = 'icon-link red'
    taTools.insertImage.iconclass = 'glyphicon glyphicon-picture'
    taTools.insertVideo.iconclass = 'glyphicon glyphicon-facetime-video'
    delete taTools.quote.iconclass
    taTools.quote.buttontext = 'quote'
    return taTools
  ]

adminapp.directive 'replaceWithTextAngular', ->
  return {
    restrict: 'A'
    transclude: true
    scope:
      textValue: '@'
    template: '
      <div ng-transclude></div>
      <div
        text-angular
        ng-model="htmlContent">
      </div>
    '
    link: (scope, element, attrs) ->
      scope.htmlContent = scope.textValue

      textarea = element.find('textarea')
      input_name = textarea.attr('name')
      textarea.remove()

      hidden = element.find('input:hidden')
      hidden.attr('name', input_name)
  }
