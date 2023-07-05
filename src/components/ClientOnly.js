import React from 'react';
import ApiDoc from '@theme/ApiDoc';
// For csr api pages
export default function ClientOnly(props) {
  return (
    <ApiDoc
      specProps={{
        url: props.swaggerPath,
      }}
    />
  );
}
