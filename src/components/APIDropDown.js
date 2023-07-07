import React from 'react';
import DropdownNavbarItem from '@theme/NavbarItem/DropdownNavbarItem';
import {useLocation} from '@docusaurus/router';

export default function APIDropDown(props) {
  const {pathname} = useLocation();
  let newLabel = props.label;
  // isAPI indicates if the current page is a api page
  let isAPI = false;
  for (const item of props.items) {
    // paths like /zh-cn/api/{version}/ are also api pages
    if (pathname === item.to || pathname === `/zh-cn${item.to}`) {
      if (!props.mobile) newLabel = item.label;
      isAPI = true;
      break;
    }
  }
  const newProps = {...props, label: newLabel};
  // Hide api dropdown on non api pages
  return (
    <DropdownNavbarItem {...newProps} className={`api-dropdown${isAPI? '': ' gt-hidden'}`}></DropdownNavbarItem>
  );
}
