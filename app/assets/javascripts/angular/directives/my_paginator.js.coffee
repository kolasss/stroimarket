app.directive 'myPaginator', ->
  return {
    restrict: 'E'
    scope:
      currentPage: '='
      numberOfPages: '='
    replace: true
    template: '
      <div class="pagination_wrapper" ng-hide="numberOfPages < 2">
        <ul class="my_pager">
          <li ng-class="{ disabled : currentPage == 0 }">
            <a ng-click="setCurrent(currentPage - 1)">&#8592; Предыдущая</a>
          </li>
          <li ng-class="{ disabled : currentPage >= numberOfPages - 1 }">
            <a ng-click="setCurrent(currentPage + 1)">Следующая &#8594;</a>
          </li>
        </ul>
        <ul class="my_pagination">
          <li ng-repeat="i in getNumber() track by $index" ng-class="{ active : currentPage == $index }">
            <a ng-click="setCurrent($index)">{{$index+1}}</a>
          </li>
        </ul>
      </div>
    '
    link: (scope, element, attrs) ->
      scope.getNumber = ->
        return new Array(scope.numberOfPages)

      scope.$watch 'numberOfPages', (newVal, oldVal) ->
        scope.currentPage = 0

      scope.setCurrent = (number) ->
        return if number < 0 or number > scope.numberOfPages - 1
        scope.currentPage = number

  }
