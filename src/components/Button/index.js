import clsx from "clsx";
import React from "react";

import styles from "./styles.module.css";

const Button = (props) => {
  const { icon, variant, size, uppercase, className, to, href, children } = props;
  const classes = clsx(className, styles.button, {
    [styles["button--icon"]]: icon != null,
    [styles["button--primary"]]: variant === "primary",
    [styles["button--secondary"]]: variant === "secondary",
    [styles["button--small"]]: size === "small",
    [styles["button--tertiary"]]: variant === "tertiary",
    [styles["button--plain"]]: variant === "plain",
    [styles["button--uppercase"]]: uppercase === "true",
    [styles["button--xsmall"]]: size === "xsmall",
    [styles["button--xxsmall"]]: size === "xxsmall",
  })
  if (href != null) {
    const { disabled, onClick, newtab} = props;
    return (
      <a
        className={classes}
        {...(disabled ?? false ? {} : {
          href,
          onClick,
        })}
        {...(newtab === "true" ? {
          rel: "noopener noreferrer",
          target: "_blank",
        } : {})}
      >
        {icon}
        {children}
      </a>
    )
  }

  if (to != null) {
    return (
      <a className={classes} href={to} onClick={onClick}>
        {icon}
        {children}
      </a>
    )
  }

  return (
    <button
      {...props}
      className={classes}
    >
      {icon}
      {children}
    </button>
  )
}

Button.defaultProps = {
  newtab: "true",
  size: "normal",
  uppercase: "true",
  variant: "primary",
}

export default Button
