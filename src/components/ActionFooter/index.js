import footerCss from "./footer.module.css";
import ActionCard from "../ActionCard";
import FossIcon from "./foss.svg";
import SubscribeIcon from "./subscribeIcon.svg";
import Subscribe from "../Subscribe";
import React from "react";
import SvgImage from "../SvgImage";

export const ActionFooter = () => (
  <div className={footerCss.cards}>
    <ActionCard
      icon={
        <SvgImage
          image={<FossIcon />}
          title="An icon showing wave propagation"
        />
      }
      svgBackgroundColor="#ffffff"
      title="Join our community"
      description="Gitea is open source. Star our GitHub repo, and join our community on Discord!"
    >
      <a
        className={footerCss.card__link}
        href={'https://github.com/go-gitea/gitea'}
        rel="noopener noreferrer"
        target="_blank"
      >
        Go to GitHub&nbsp;&nbsp;&gt;
      </a>
      <a className={footerCss.card__link} href={'https://discord.com/invite/gitea'}>
        Join Discord&nbsp;&nbsp;&gt;
      </a>
    </ActionCard>

    <ActionCard
      title="Subscribe to our newsletter"
      description="Stay up to date with all things Gitea"
      svgBackgroundColor="#1E1F27"
      icon={
        <SvgImage
          image={<SubscribeIcon />}
          title="An icon showing a paper plane"
        />
      }
      skin="primary"
    >
      <Subscribe
        placeholder="Email address"
        submitButtonText = "Subscribe"
      />
    </ActionCard>
  </div>
)
