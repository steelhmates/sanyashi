// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require('prism-react-renderer/themes/github');
const darkCodeTheme = require('prism-react-renderer/themes/dracula');

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'Gitea Documentation',
  tagline: 'Git with a cup of tea',
  url: 'https://docs.gitea.com',
  baseUrl: '/',
  onBrokenLinks: 'warn',
  onBrokenMarkdownLinks: 'warn',
  favicon: 'img/favicon.png',

  i18n: {
    defaultLocale: 'en',
    locales: ['en'/*, 'fr-fr', 'zh-cn', 'zh-tw'*/], // temporarily disable other locales
  },

  presets: [
    [
      '@docusaurus/preset-classic',
      //'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          routeBasePath: '/', // Serve the docs at the site's root
          editUrl: ({locale, versionDocsDirPath, docPath}) => {
            return `https://github.com/go-gitea/gitea/tree/main/docs/content/doc/${docPath}`
          },
          versions: {
            current: {
              label: '1.20-dev', // path is kept as next for dev (so users can always find "nightly" docs)
            },
            1.19 : {
              label: '1.19.0-RC0'
            }
          },
        },
        blog: false,
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      }),
    ],
  ],
  themes: [
    [
      "@easyops-cn/docusaurus-search-local",
      {
        hashed: false,
        language: ["en"],
        highlightSearchTermsOnTargetPage: true,
        explicitSearchResultPath: true,
        indexBlog: false,
        docsRouteBasePath: "/"
      }
    ]
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      colorMode: {
        defaultMode: 'light',
        disableSwitch: true,
        respectPrefersColorScheme: true,
      },
      announcementBar: {
        id: 'announcementBar-1', // Increment on change
        content: `The updated documentation site is a work in progress. If you find any issues, please <a target="_blank" rel="noopener noreferrer" href="https://github.com/go-gitea/gitea/issues">let us know</a>. Translated documentation is also a work in progress.`,
      },
      navbar: {
        title: 'Gitea',
        logo: {
          alt: 'Gitea Logo',
          src: 'img/gitea.svg',
        },
        items: [
          {
            to: '/',
            position: 'left',
            label: 'Docs',
          },
          {
            href: 'https://github.com/go-gitea/gitea',
            label: 'Code',
            position: 'left',
          },
          {
            type: 'search',
            position: 'right',
          },
          {
            type: 'docsVersionDropdown',
            position: 'right',
            dropdownActiveClassDisabled: true,
          },
          {
            to: 'help/seek-help',
            position: 'right',
            label: 'Support',
            activeBaseRegex: 'help/seek-help',
          }
        ],
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'Docs',
            items: [
              {
                label: 'Tutorial',
                to: '/',
              },
            ],
          },
          {
            title: 'Community',
            items: [
              {
                label: 'Stack Overflow',
                href: 'https://stackoverflow.com/questions/tagged/gitea',
              },
              {
                label: 'Discord',
                href: 'https://discord.gg/gitea',
              },
              {
                label: 'Twitter',
                href: 'https://twitter.com/giteaio',
              },
            ],
          },
          {
            title: 'More',
            items: [
              {
                label: 'Code',
                href: 'https://github.com/go-gitea/gitea',
              },
            ],
          },
        ],
      },
      prism: {
        theme: lightCodeTheme,
        darkTheme: darkCodeTheme,
      },
    }),
};

module.exports = config;
