@ProjectManage = React.createClass

  getInitialState: ->
    pm: @props.pm

  render: ->
    React.DOM.div
      className: 'org-chart'
      @props.pm.email
      React.DOM.ul {
        className: 'form-control'
      }, Object.keys(@props.supervisors).map(((supervisor) ->
        React.DOM.option {
          key: supervisor
          value: @props.supervisors[supervisor].id },
          @props.supervisors[supervisor].email
        ), this)
