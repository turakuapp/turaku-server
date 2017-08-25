import React from 'react'
import ReactDOM from 'react-dom'

class SignUpForm extends React.Component {
  submit (event) {
    event.preventDefault()
  }

  render () {
    return (
      <form onSubmit={this.submit}>
        <div className="form-group">
          <label htmlFor="sign-up-form__email">Email address</label>
          <input type="email" className="form-control" id="sign-up-form__email" aria-describedby="emailHelp"
                 placeholder="Enter email"/>
        </div>

        <div className="form-group">
          <label htmlFor="sign-up-form__password">Password</label>
          <input type="password" className="form-control" id="sign-up-form__password" placeholder="Password"/>
        </div>

        <div className="form-group">
          <label htmlFor="sign-up-form__password-confirmation">Confirm Password</label>
          <input type="password" className="form-control" id="sign-up-form__password-confirmation"
                 placeholder="Password"/>
        </div>

        <button type="submit" className="btn btn-primary">Submit</button>
      </form>
    )
  }
}

document.addEventListener('turbolinks:load', () => {
  ReactDOM.render(
    <SignUpForm/>,
    document.getElementById('sign_up_form__root'),
  )
})
