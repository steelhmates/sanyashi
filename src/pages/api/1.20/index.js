import React from 'react';
import ClientOnly from '@site/src/components/ClientOnly';

export default function Api20() {
  return (
    <ClientOnly swaggerPath="/swagger-20.json"/>
  );
}
