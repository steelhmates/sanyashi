import React from 'react';
import Layout from '@theme/Layout';
import Redoc from '@theme/Redoc';
import { ActionFooter } from "@site/src/components/ActionFooter";
import { Section } from "@site/src/components/Section";
function ApiDoc({ layoutProps, specProps }) {
    const defaultTitle = specProps.spec?.info?.title || 'API Docs';
    const defaultDescription = specProps.spec?.info?.description || 'Open API Reference Docs for the API';
    return (<Layout title={defaultTitle} description={defaultDescription} {...layoutProps}>
      <Redoc {...specProps}/>
      <Section>
        <ActionFooter />
      </Section>
    </Layout>);
}
export default ApiDoc;
