
this.BigCalendar = React.createClass({
  render(){
    return (
      <BigCalendar
        events={this.props.data}
        defaultDate={new Date()}
      />
    )
  }
})
