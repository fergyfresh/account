@ProjectForm = React.createClass

  getInitialState: ->
    name: ''
    content: ''
    user_id: @props.users[0].id

  valid: ->
    @state.name && @state.content && @state.user_id

  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value

  handleSubmit: (e) ->
    e.preventDefault()
    $.post '/projects/', { project: @state }, (data) =>
      @props.handleNewRecord data
      @setState @getInitialState()
    , 'JSON'

  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Contract Number'
          name: 'contract'
          value: @state.contract
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Project Name'
          name: 'name'
          value: @state.name
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Description'
          name: 'content'
          value: @state.content
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.select {
          name: 'user_id'
          value: @state.user_id
          onChange: @handleChange
          className: 'form-control'
        }, Object.keys(@props.users).map(((optlabel) ->
          React.DOM.option {
            key: optlabel
            value: @props.users[optlabel].id },
            @props.users[optlabel].email
          ), this)
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Create project'
