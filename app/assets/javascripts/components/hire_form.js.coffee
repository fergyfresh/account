@HireForm = React.createClass

  getInitialState: ->
    project_id: @props.project_id
    supervisor_id: @props.supervisor_id 
    employee_id: ''

  valid: ->
    @state.project_id && @state.supervisor_id && @state.employee_id

  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value

  handleSubmit: (e) ->
    e.preventDefault()
    $.post '/relationships/', @state, (data) =>
      @props.handleNewRecord data
      @setState @getInitialState()
    , 'JSON'

  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.select
          name: 'employee_id'
          value: @state.employee_id
          onChange: @handleChange
          className: 'form-control'
          React.DOM.option
            value: ''
            'Select new hire'
          for user in @props.users 
            React.DOM.option
              key: user.id
              value: user.id
              user.email
      React.DOM.button
        type: 'submit'
        className: 'btn btn-success'
        disabled: !@valid()
        'Hire'
