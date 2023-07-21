import React, { useState } from "react"
import Input from "../Input"
import Button from "../Button"
import style from "./style.module.css"
import clsx from "clsx"

const Spinner = () => <span className={style.loader} />

const Subscribe = ({placeholder, submitButtonText, className, classNameInputs}) => {
  const [loading, setLoading] = useState(false)

  return (
    <form method="post" action="https://list.gitea.com/subscription/form" className={clsx(style.root, className)} onSubmit={() => {setLoading(true)}}>
      <div className={clsx(style.inputs, classNameInputs)}>
        <Input type="hidden" name="nonce" />
        <input className={style.checkbox} id="2aae7" type="checkbox" name="l" value="2aae7a49-b6b9-4aa3-b35a-32c9aeace57b" checked readOnly />
        <Input
          className={style.input}
          name="email"
          type="email"
          title="Email address should be valid"
          placeholder={placeholder}
          required
          autoComplete="off"
        />

        <Button
          variant={"tertiary"}
          type="submit"
          className={style.subscribeSubmit}
        >
          {loading ? <Spinner /> : submitButtonText}
        </Button>
      </div>
    </form>
  )
}

export default Subscribe
