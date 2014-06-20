adminapp = angular.module "AdminTextAngular", ['textAngular']

adminapp.config ['$provide',
  ($provide) ->
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
    # $provide.decorator 'taTools', ['$delegate', (taTools) ->
    #   taTools.bold.iconclass = 'icon-bold';
    #   taTools.italics.iconclass = 'icon-italic';
    #   taTools.underline.iconclass = 'icon-underline';
    #   taTools.ul.iconclass = 'icon-list-ul';
    #   taTools.ol.iconclass = 'icon-list-ol';
    #   taTools.undo.iconclass = 'icon-undo';
    #   taTools.redo.iconclass = 'icon-repeat';
    #   taTools.justifyLeft.iconclass = 'icon-align-left';
    #   taTools.justifyRight.iconclass = 'icon-align-right';
    #   taTools.justifyCenter.iconclass = 'icon-align-center';
    #   taTools.clear.iconclass = 'icon-ban-circle';
    #   taTools.insertLink.iconclass = 'icon-link';
    #   # taTools.unlink.iconclass = 'icon-link red';
    #   taTools.insertImage.iconclass = 'icon-picture';
    #   delete taTools.quote.iconclass;
    #   taTools.quote.buttontext = 'quote';

    #   taTools.h2.buttontext = 'Заголовок'
    #   taTools.h3.buttontext = 'Подзаголовок'
    #   # taTools.bold.iconclass = 'glyphicon glyphicon-bold'
    #   # taTools.italics.iconclass = 'glyphicon glyphicon-italic'
    #   # delete taTools.underline.iconclass
    #   # taTools.underline.buttontext = '<u>Подчеркнутый</u>'
    #   # taTools.ul.iconclass = 'glyphicon glyphicon-list'
    #   # taTools.ol.iconclass = 'glyphicon glyphicon-list-alt'
    #   # taTools.undo.iconclass = 'glyphicon glyphicon-backward'
    #   # taTools.redo.iconclass = 'glyphicon glyphicon-forward'
    #   # # taTools.justifyLeft.iconclass = 'glyphicon glyphicon-align-left'
    #   # taTools.justifyRight.iconclass = 'glyphicon glyphicon-align-right'
    #   # taTools.justifyCenter.iconclass = 'glyphicon glyphicon-align-center'
    #   # taTools.clear.iconclass = 'glyphicon glyphicon-ban-circle'
    #   # taTools.insertLink.iconclass = 'glyphicon glyphicon-link'
    #   # taTools.unlink.iconclass = 'icon-link red'
    #   # taTools.insertImage.iconclass = 'glyphicon glyphicon-picture'
    #   # taTools.insertVideo.iconclass = 'glyphicon glyphicon-facetime-video'
    #   # delete taTools.quote.iconclass
    #   # taTools.quote.buttontext = 'quote'
    #   return taTools
    # ]
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

      textarea = element.find('textarea')[0]
      input_name = textarea.name
      textarea.remove()

      hidden = element.find('input:hidden')
      hidden.attr('name', input_name)
  }
