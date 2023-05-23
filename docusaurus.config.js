// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require('prism-react-renderer/themes/github');
const darkCodeTheme = require('prism-react-renderer/themes/dracula');

// order usage directory by type first
function sortItemsByCategory(items) {
  // type with "category" (directory) first
  const sortedItems = items.sort(function(a, b) {
    return a.type.localeCompare(b.type);
  })
  return sortedItems;
}

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
    locales: ['en'/*, 'zh-cn', 'fr-fr', 'zh-tw'*/], // temporarily disable other locales
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
              label: '1.19.3'
            }
          },
          async sidebarItemsGenerator({defaultSidebarItemsGenerator, ...args}) {
            const {item} = args;
            // Use the provided data to generate a custom sidebar slice
            const sidebarItems = await defaultSidebarItemsGenerator(args);
            if (item.dirName !== 'usage') {
              return sidebarItems;
            } else {
              return sortItemsByCategory(sidebarItems);
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
        id: 'announcementBar-3', // Increment on change
        content: `This documentation site is fairly new. If you find any issues, please <a target="_blank" rel="noopener noreferrer" href="https://gitea.com/gitea/gitea-docusaurus/issues">let us know</a>. We are currently working on translating the documentation into other languages.`,
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
            type: 'localeDropdown',
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
