{
  config,
  pkgs,
  ...
}: {
  programs.thunderbird = {
    enable = true;
    settings = {
      "mailnews.default_news_sort_order" = 2;
      "mailnews.default_sort_order" = 2;
    };
    profiles.p1ng0ut = {
      isDefault = true;
    };
  };
}
