import React from 'react'
import Translate from '@docusaurus/Translate';

export default function Outdated(props) {
  return (
    <div className='outdated-text'>
      <Translate id="outdated.message">
        The content of current version is not up to date, please check latest English version, or
      </Translate>
      <a href={props.editUrl}>
        <Translate id="outdated.help">
          Help us to translate
        </Translate>
      </a>
    </div>
  )
}
