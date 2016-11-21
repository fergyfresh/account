@ProjectManage = React.createClass

  getInitialState: ->
    pm: @props.pm

  render: ->
    React.DOM.div
      className: 'org-chart'
      @props.pm.email
      
