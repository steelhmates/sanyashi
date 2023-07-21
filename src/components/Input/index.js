import clsx from "clsx";
import React from "react";

import styles from "./styles.module.css";

const Input = (props) => {
  const classes = clsx(props.className, styles.input)

  return (
    <input
      {...props}
      className={classes}
    />
  )
}

Input.defaultProps = {
  type: "text",
}

export default Input
