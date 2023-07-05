import React from 'react';
import ClientOnly from '@site/src/components/ClientOnly';

export default function ApiLatest() {
  return (
    <ClientOnly swaggerPath="/swagger-latest.json"/>
  );
}
