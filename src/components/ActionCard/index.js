import clsx from "clsx";
import React from "react";
import style from "./styles.module.css";

// skin?: "default" | "primary"
export const ActionCard = ({ skin = "default", icon, title, description, svgBackgroundColor, children, className }) => {
  const styles = { background: svgBackgroundColor};
  return  (
    <div
      className={clsx(style.root, className, {
        [style.skinPrimary]: skin === "primary",
      })}
    >
      <div className={style.icon} style={styles}>{icon}</div>
      <h3 className={style.title}>{title}</h3>
      <p className={style.description}>{description}</p>
      <div className={style.content}>{children}</div>
    </div>
  )
}

export default ActionCard
