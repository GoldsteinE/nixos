let
  deps = rec {
    unflake_github_cachix_git-hooks-nix = builtins.fetchTree {
      type = "github";
      owner = "cachix";
      repo = "git-hooks.nix";
      rev = "09e45f2598e1a8499c3594fe11ec2943f34fe509";
      lastModified = 1765464257;
      narHash = "sha256-dixPWKiHzh80PtD0aLuxYNQ0xP+843dfXG/yM3OzaYQ=";
    };
    unflake_github_cachix_pre-commit-hooks-nix = builtins.fetchTree {
      type = "github";
      owner = "cachix";
      repo = "pre-commit-hooks.nix";
      rev = "09e45f2598e1a8499c3594fe11ec2943f34fe509";
      lastModified = 1765464257;
      narHash = "sha256-dixPWKiHzh80PtD0aLuxYNQ0xP+843dfXG/yM3OzaYQ=";
    };
    unflake_github_edolstra_flake-compat = builtins.fetchTree {
      type = "github";
      owner = "edolstra";
      repo = "flake-compat";
      rev = "65f23138d8d09a92e30f1e5c87611b23ef451bf3";
      lastModified = 1765121682;
      narHash = "sha256-4VBOP18BFeiPkyhy9o4ssBNQEvfvv1kXkasAYd0+rrA=";
    };
    unflake_github_goldsteine_anti-emoji-bot = builtins.fetchTree {
      type = "github";
      owner = "goldsteine";
      repo = "anti-emoji-bot";
      rev = "1f01366b4942ed6ad7e9787415b7fc1a4aa80bb7";
      lastModified = 1750013552;
      narHash = "sha256-zk/0ZIR5QAap4aSxDZ6fuo4rXueX/4fgTzJqXS5oObQ=";
    };
    unflake_github_goldsteine_classified = builtins.fetchTree {
      type = "github";
      owner = "goldsteine";
      repo = "classified";
      rev = "3bb7e22be468efc5a3c1b232d92a41a5a8c33ac0";
      lastModified = 1764756337;
      narHash = "sha256-XX4dxkM0ucoqgavjn78XLrXCrdv+RD4ZZvwZVfvr5ds=";
    };
    unflake_github_goldsteine_flake-templates = builtins.fetchTree {
      type = "github";
      owner = "goldsteine";
      repo = "flake-templates";
      rev = "8d0cc01127c48c01286acb4f72ae72f3ce39e772";
      lastModified = 1659519983;
      narHash = "sha256-j0VDGhNkXEjfv85A6LvHtIoEymzP3CW9IEPpV8wMBUE=";
    };
    unflake_github_goldsteine_inftheory-slides = builtins.fetchTree {
      type = "github";
      owner = "goldsteine";
      repo = "inftheory-slides";
      rev = "72fb619a1a6096c796c192940132fc4cb74972ce";
      lastModified = 1764028492;
      narHash = "sha256-fsl0zqy205HQZoump4eNOQy6ftNvWVVX1dM0nr/ujHU=";
    };
    unflake_github_goldsteine_passnag = builtins.fetchTree {
      type = "github";
      owner = "goldsteine";
      repo = "passnag";
      rev = "71c6750b0e584d6654f73543db84e7d62f1ee320";
      lastModified = 1739563906;
      narHash = "sha256-WgBxYLqlcbj5sGtNkvU/6x0eE6uFdqSIlMFad592MaQ=";
    };
    unflake_github_goldsteine_perlsub = builtins.fetchTree {
      type = "github";
      owner = "goldsteine";
      repo = "perlsub";
      rev = "a39370ad9bda517b689796d83c32801e547bcf8e";
      lastModified = 1738336184;
      narHash = "sha256-HBQ4tOPZe5RtVP4905T58NZiGgzrRPExZkCkpT1vidk=";
    };
    unflake_github_goldsteine_r9ktg = builtins.fetchTree {
      type = "github";
      owner = "goldsteine";
      repo = "r9ktg";
      rev = "7806b1e08b0bc2659331f46ac4963be07d36c940";
      lastModified = 1663411480;
      narHash = "sha256-OajHpmpFa1mD47WsN2UtGjr1RYDXGmRhd3ll/XIJTcU=";
    };
    unflake_github_hercules-ci_flake-parts = builtins.fetchTree {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
      rev = "5635c32d666a59ec9a55cab87e898889869f7b71";
      lastModified = 1765495779;
      narHash = "sha256-MhA7wmo/7uogLxiewwRRmIax70g6q1U/YemqTGoFHlM=";
    };
    unflake_github_hercules-ci_gitignore-nix = builtins.fetchTree {
      type = "github";
      owner = "hercules-ci";
      repo = "gitignore.nix";
      rev = "cb5e3fdca1de58ccbc3ef53de65bd372b48f567c";
      lastModified = 1762808025;
      narHash = "sha256-XmjITeZNMTQXGhhww6ed/Wacy2KzD6svioyCX7pkUu4=";
    };
    unflake_github_infinidoge_nix-minecraft = builtins.fetchTree {
      type = "github";
      owner = "infinidoge";
      repo = "nix-minecraft";
      rev = "a3bdc14045dc7e5fb7a94ab11064766f472279eb";
      lastModified = 1765332486;
      narHash = "sha256-nVTejyI8w3ePrX4tW3lBLLg3DheqhRuxtiRefT+ynrk=";
    };
    unflake_github_ipetkov_crane = builtins.fetchTree {
      type = "github";
      owner = "ipetkov";
      repo = "crane";
      rev = "69f538cdce5955fcd47abfed4395dc6d5194c1c5";
      lastModified = 1765145449;
      narHash = "sha256-aBVHGWWRzSpfL++LubA0CwOOQ64WNLegrYHwsVuVN7A=";
    };
    unflake_github_lf-_flakey-profile = builtins.fetchTree {
      type = "github";
      owner = "lf-";
      repo = "flakey-profile";
      rev = "243c903fd8eadc0f63d205665a92d4df91d42d9d";
      lastModified = 1712898590;
      narHash = "sha256-FhGIEU93VHAChKEXx905TSiPZKga69bWl1VB37FK//I=";
    };
    unflake_github_matze_mtheme = builtins.fetchTree {
      type = "github";
      owner = "matze";
      repo = "mtheme";
      rev = "2fa6084b9d34fec9d2d5470eb9a17d0bf712b6c8";
      lastModified = 1533142502;
      narHash = "sha256-1HptXntlCUtXwhKuenuVjsj4K3oK5eOsNPZ9+nwSczg=";
    };
    unflake_github_nix-community_lanzaboote_ref_v0-4-2 = builtins.fetchTree {
      type = "github";
      owner = "nix-community";
      repo = "lanzaboote";
      rev = "a65905a09e2c43ff63be8c0e86a93712361f871e";
      lastModified = 1737639419;
      narHash = "sha256-AEEDktApTEZ5PZXNDkry2YV2k6t0dTgLPEmAZbnigXU=";
    };
    unflake_github_nix-community_fenix = builtins.fetchTree {
      type = "github";
      owner = "nix-community";
      repo = "fenix";
      rev = "6399553b7a300c77e7f07342904eb696a5b6bf9d";
      lastModified = 1765435813;
      narHash = "sha256-C6tT7K1Lx6VsYw1BY5S3OavtapUvEnDQtmQB5DSgbCc=";
    };
    unflake_github_nix-community_flake-compat = builtins.fetchTree {
      type = "github";
      owner = "nix-community";
      repo = "flake-compat";
      rev = "4a56054d8ffc173222d09dad23adf4ba946c8884";
      lastModified = 1761640442;
      narHash = "sha256-AtrEP6Jmdvrqiv4x2xa5mrtaIp3OEe8uBYCDZDS+hu8=";
    };
    unflake_github_nix-community_home-manager = builtins.fetchTree {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      rev = "39cb677ed9e908e90478aa9fe5f3383dfc1a63f3";
      lastModified = 1765480374;
      narHash = "sha256-HlbvQAqLx7WqZFFQZ8nu5UUJAVlXiV/kqKbyueA8srw=";
    };
    unflake_github_nix-community_lib-aggregate = builtins.fetchTree {
      type = "github";
      owner = "nix-community";
      repo = "lib-aggregate";
      rev = "e562ca084a8b3490337d446f1e0d6afadb509d1e";
      lastModified = 1765111385;
      narHash = "sha256-Gn8IIq9FGLvQSDK2bXKzsqqkgKExTExLkYfH7n8Nnpk=";
    };
    unflake_github_nix-community_naersk = builtins.fetchTree {
      type = "github";
      owner = "nix-community";
      repo = "naersk";
      rev = "d4155d6ebb70fbe2314959842f744aa7cabbbf6a";
      lastModified = 1763384566;
      narHash = "sha256-r+wgI+WvNaSdxQmqaM58lVNvJYJ16zoq+tKN20cLst4=";
    };
    unflake_github_nix-community_nixpkgs-wayland = builtins.fetchTree {
      type = "github";
      owner = "nix-community";
      repo = "nixpkgs-wayland";
      rev = "f75bb29f5464375a5ee852b682ec3417512ce32b";
      lastModified = 1765545632;
      narHash = "sha256-m4IdtiDpcAtMyQtRKaV2Zq+k98RzI/I3AP+MekjL750=";
    };
    unflake_github_nix-community_nixpkgs-lib = builtins.fetchTree {
      type = "github";
      owner = "nix-community";
      repo = "nixpkgs.lib";
      rev = "e0cad9791b0c168931ae562977703b72d9360836";
      lastModified = 1765070080;
      narHash = "sha256-5D1Mcm2dQ1aPzQ0sbXluHVUHququ8A7PKJd7M3eI9+E=";
    };
    unflake_github_nix-systems_default = builtins.fetchTree {
      type = "github";
      owner = "nix-systems";
      repo = "default";
      rev = "da67096a3b9bf56a91d16901293e51ba5b49a27e";
      lastModified = 1681028828;
      narHash = "sha256-Vy1rq5AaRuLzOxct8nz4T6wlgyUR7zLU309k9mBC768=";
    };
    unflake_github_nixos_nixpkgs_ref_nixos-unstable = builtins.fetchTree {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      rev = "addf7cf5f383a3101ecfba091b98d0a1263dc9b8";
      lastModified = 1765186076;
      narHash = "sha256-hM20uyap1a0M9d344I692r+ik4gTMyj60cQWO+hAYP8=";
    };
    unflake_github_nixos_nixos-hardware = builtins.fetchTree {
      type = "github";
      owner = "nixos";
      repo = "nixos-hardware";
      rev = "9154f4569b6cdfd3c595851a6ba51bfaa472d9f3";
      lastModified = 1764440730;
      narHash = "sha256-ZlJTNLUKQRANlLDomuRWLBCH5792x+6XUJ4YdFRjtO4=";
    };
    unflake_github_nmattia_naersk = builtins.fetchTree {
      type = "github";
      owner = "nmattia";
      repo = "naersk";
      rev = "d4155d6ebb70fbe2314959842f744aa7cabbbf6a";
      lastModified = 1763384566;
      narHash = "sha256-r+wgI+WvNaSdxQmqaM58lVNvJYJ16zoq+tKN20cLst4=";
    };
    unflake_github_numtide_flake-utils = builtins.fetchTree {
      type = "github";
      owner = "numtide";
      repo = "flake-utils";
      rev = "11707dc2f618dd54ca8739b309ec4fc024de578b";
      lastModified = 1731533236;
      narHash = "sha256-l0KFg5HjrsfsO/JpG+r7fRrqm12kzFHyUHqHCVpMMbI=";
    };
    unflake_github_oxalica_rust-overlay = builtins.fetchTree {
      type = "github";
      owner = "oxalica";
      repo = "rust-overlay";
      rev = "a9471b23bf656d69ceb2d5ddccdc5082d51fc0e3";
      lastModified = 1765507345;
      narHash = "sha256-fq34mBLvAgv93EuZjGp7cVV633pxnph9AVuB/Ql5y5Q=";
    };
    unflake_github_pro-vim_tg-vimhelpbot = builtins.fetchTree {
      type = "github";
      owner = "pro-vim";
      repo = "tg-vimhelpbot";
      rev = "d2aa688d19b6a6c2d30bdab445b4c344edcb752d";
      lastModified = 1750015990;
      narHash = "sha256-s9Vw6CYp0Lx4b21WTHEuxZPJ/ujZME2cv9CPDTlREhM=";
    };
    unflake_github_rust-lang_rust-analyzer_ref_nightly = builtins.fetchTree {
      type = "github";
      owner = "rust-lang";
      repo = "rust-analyzer";
      rev = "f5a83fb3b502cedf54854c0e0baf1858461c3b7a";
      lastModified = 1765491588;
      narHash = "sha256-Tol6S90/6p3QhPn7tWS8dWngnnZV/hek129iOKkq4HY=";
    };
    unflake_github_rustsec_advisory-db = builtins.fetchTree {
      type = "github";
      owner = "rustsec";
      repo = "advisory-db";
      rev = "d0bdb37b2b1dc8a81f47e2042d59227b1f06473f";
      lastModified = 1765465865;
      narHash = "sha256-jAyDD6FKEWZafIKN4KjzdQywcS/gR9sHz4zzjxefXcA=";
    };
    unflake_gitlab_simple-nixos-mailserver_blobs = builtins.fetchTree {
      type = "gitlab";
      owner = "simple-nixos-mailserver";
      repo = "blobs";
      rev = "2cccdf1ca48316f2cfd1c9a0017e8de5a7156265";
      lastModified = 1604995301;
      narHash = "sha256-wcLzgLec6SGJA8fx1OEN1yV/Py5b+U5iyYpksUY/yLw=";
    };
    unflake_gitlab_simple-nixos-mailserver_nixos-mailserver = builtins.fetchTree {
      type = "gitlab";
      owner = "simple-nixos-mailserver";
      repo = "nixos-mailserver";
      rev = "1ccd57f177539ed8c207b893c3f9798d88f87d2e";
      lastModified = 1764763336;
      narHash = "sha256-007DlZGjQ3ziQ5UMjt3GdjBAbgAtHgMwOxMY2v7/b7c=";
    };
    unflake_github_supreeeme_xwayland-satellite = builtins.fetchTree {
      type = "github";
      owner = "supreeeme";
      repo = "xwayland-satellite";
      rev = "f0ad674b7009a6afd80cea59d4fbf975dd68ee95";
      lastModified = 1765343581;
      narHash = "sha256-HtTPbV6z6AJPg2d0bHaJKFrnNha+SEbHvbJafKAQ614=";
    };
    unflake_github_vim_vim = builtins.fetchTree {
      type = "github";
      owner = "vim";
      repo = "vim";
      rev = "3d06113c8c9628a478b0cf6c85248ff6ec5fac3a";
      lastModified = 1765525927;
      narHash = "sha256-8/xtpRQU/IKu98HSHBNdKzOsv7wDcUi2Z8k+WW5k7Fs=";
    };
    unflake_sourcehut_-goldstein_ln-s = builtins.fetchTree {
      type = "sourcehut";
      owner = "~goldstein";
      repo = "ln-s";
      rev = "a9bdcb3bcaaa0fdbdff9d04d4f48662e9610bfcf";
      lastModified = 1715468515;
      narHash = "sha256-Pq+hOJBc0JdpusBViSi6yGdip5OIpdkZigWpDJQwQiI=";
    };
    unflake_tarball_https---git-lix-systems-lix-project-lix-archive-main-tar-gz = builtins.fetchTree {
      type = "tarball";
      url = "https://git.lix.systems/api/v1/repos/lix-project/lix/archive/a6f0e59c2c21811e02d4e65b0a7c9b779d7869b3.tar.gz?rev=a6f0e59c2c21811e02d4e65b0a7c9b779d7869b3";
      lastModified = 1765472986;
      narHash = "sha256-2vsvYj0GNsNaAMg8VDKvEm81sJU5+2A7qNnT4GI5+jQ=";
    };
    unflake_tarball_https---git-lix-systems-lix-project-nixos-module-archive-main-tar-gz = builtins.fetchTree {
      type = "tarball";
      url = "https://git.lix.systems/api/v1/repos/lix-project/nixos-module/archive/6c95c0b6f73f831226453fc6905c216ab634c30f.tar.gz?rev=6c95c0b6f73f831226453fc6905c216ab634c30f";
      lastModified = 1764519849;
      narHash = "sha256-XnNABKfIYKSimQVvKc9FnlC2H0LurOhd9MS6l0Z67lE=";
    };
    unflake_github_edolstra_flake-compat_flake_false = unflake_github_edolstra_flake-compat;
    unflake_github_matze_mtheme_flake_false = unflake_github_matze_mtheme;
    unflake_github_rust-lang_rust-analyzer_ref_nightly_flake_false = unflake_github_rust-lang_rust-analyzer_ref_nightly;
    unflake_github_rustsec_advisory-db_flake_false = unflake_github_rustsec_advisory-db;
    unflake_gitlab_simple-nixos-mailserver_blobs_flake_false = unflake_gitlab_simple-nixos-mailserver_blobs;
    unflake_github_vim_vim_flake_false = unflake_github_vim_vim;
    unflake_tarball_https---git-lix-systems-lix-project-lix-archive-main-tar-gz_flake_false = unflake_tarball_https---git-lix-systems-lix-project-lix-archive-main-tar-gz;
  };
  universe = rec {
    unflake_github_cachix_git-hooks-nix = ((import "${deps.unflake_github_cachix_git-hooks-nix.outPath}/flake.nix").outputs {
      self = unflake_github_cachix_git-hooks-nix;
      flake-compat = unflake_github_edolstra_flake-compat_flake_false;
      gitignore = unflake_github_hercules-ci_gitignore-nix;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    }) // deps.unflake_github_cachix_git-hooks-nix // {
      _flake = true;
      outPath = "${deps.unflake_github_cachix_git-hooks-nix.outPath}";
      sourceInfo = deps.unflake_github_cachix_git-hooks-nix;
    };
    unflake_github_cachix_pre-commit-hooks-nix = ((import "${deps.unflake_github_cachix_pre-commit-hooks-nix.outPath}/flake.nix").outputs {
      self = unflake_github_cachix_pre-commit-hooks-nix;
      flake-compat = unflake_github_edolstra_flake-compat_flake_false;
      gitignore = unflake_github_hercules-ci_gitignore-nix;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    }) // deps.unflake_github_cachix_pre-commit-hooks-nix // {
      _flake = true;
      outPath = "${deps.unflake_github_cachix_pre-commit-hooks-nix.outPath}";
      sourceInfo = deps.unflake_github_cachix_pre-commit-hooks-nix;
    };
    unflake_github_edolstra_flake-compat_flake_false = deps.unflake_github_edolstra_flake-compat_flake_false;
    unflake_github_goldsteine_anti-emoji-bot = ((import "${deps.unflake_github_goldsteine_anti-emoji-bot.outPath}/flake.nix").outputs {
      self = unflake_github_goldsteine_anti-emoji-bot;
      flake-utils = unflake_github_numtide_flake-utils;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    }) // deps.unflake_github_goldsteine_anti-emoji-bot // {
      _flake = true;
      outPath = "${deps.unflake_github_goldsteine_anti-emoji-bot.outPath}";
      sourceInfo = deps.unflake_github_goldsteine_anti-emoji-bot;
    };
    unflake_github_goldsteine_classified = ((import "${deps.unflake_github_goldsteine_classified.outPath}/flake.nix").outputs {
      self = unflake_github_goldsteine_classified;
      flake-utils = unflake_github_numtide_flake-utils;
      naersk = unflake_github_nix-community_naersk;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    }) // deps.unflake_github_goldsteine_classified // {
      _flake = true;
      outPath = "${deps.unflake_github_goldsteine_classified.outPath}";
      sourceInfo = deps.unflake_github_goldsteine_classified;
    };
    unflake_github_goldsteine_flake-templates = ((import "${deps.unflake_github_goldsteine_flake-templates.outPath}/flake.nix").outputs {
      self = unflake_github_goldsteine_flake-templates;
    }) // deps.unflake_github_goldsteine_flake-templates // {
      _flake = true;
      outPath = "${deps.unflake_github_goldsteine_flake-templates.outPath}";
      sourceInfo = deps.unflake_github_goldsteine_flake-templates;
    };
    unflake_github_goldsteine_inftheory-slides = ((import "${deps.unflake_github_goldsteine_inftheory-slides.outPath}/flake.nix").outputs {
      self = unflake_github_goldsteine_inftheory-slides;
      flake-utils = unflake_github_numtide_flake-utils;
      metropolis = unflake_github_matze_mtheme_flake_false;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    }) // deps.unflake_github_goldsteine_inftheory-slides // {
      _flake = true;
      outPath = "${deps.unflake_github_goldsteine_inftheory-slides.outPath}";
      sourceInfo = deps.unflake_github_goldsteine_inftheory-slides;
    };
    unflake_github_goldsteine_passnag = ((import "${deps.unflake_github_goldsteine_passnag.outPath}/flake.nix").outputs {
      self = unflake_github_goldsteine_passnag;
      flake-utils = unflake_github_numtide_flake-utils;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    }) // deps.unflake_github_goldsteine_passnag // {
      _flake = true;
      outPath = "${deps.unflake_github_goldsteine_passnag.outPath}";
      sourceInfo = deps.unflake_github_goldsteine_passnag;
    };
    unflake_github_goldsteine_perlsub = ((import "${deps.unflake_github_goldsteine_perlsub.outPath}/flake.nix").outputs {
      self = unflake_github_goldsteine_perlsub;
      flake-utils = unflake_github_numtide_flake-utils;
      naersk = unflake_github_nix-community_naersk;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
      rust-overlay = unflake_github_oxalica_rust-overlay;
    }) // deps.unflake_github_goldsteine_perlsub // {
      _flake = true;
      outPath = "${deps.unflake_github_goldsteine_perlsub.outPath}";
      sourceInfo = deps.unflake_github_goldsteine_perlsub;
    };
    unflake_github_goldsteine_r9ktg = ((import "${deps.unflake_github_goldsteine_r9ktg.outPath}/flake.nix").outputs {
      self = unflake_github_goldsteine_r9ktg;
      flake-utils = unflake_github_numtide_flake-utils;
      naersk = unflake_github_nix-community_naersk;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    }) // deps.unflake_github_goldsteine_r9ktg // {
      _flake = true;
      outPath = "${deps.unflake_github_goldsteine_r9ktg.outPath}";
      sourceInfo = deps.unflake_github_goldsteine_r9ktg;
    };
    unflake_github_hercules-ci_flake-parts = ((import "${deps.unflake_github_hercules-ci_flake-parts.outPath}/flake.nix").outputs {
      self = unflake_github_hercules-ci_flake-parts;
      nixpkgs-lib = unflake_github_nix-community_nixpkgs-lib;
    }) // deps.unflake_github_hercules-ci_flake-parts // {
      _flake = true;
      outPath = "${deps.unflake_github_hercules-ci_flake-parts.outPath}";
      sourceInfo = deps.unflake_github_hercules-ci_flake-parts;
    };
    unflake_github_hercules-ci_gitignore-nix = ((import "${deps.unflake_github_hercules-ci_gitignore-nix.outPath}/flake.nix").outputs {
      self = unflake_github_hercules-ci_gitignore-nix;
    }) // deps.unflake_github_hercules-ci_gitignore-nix // {
      _flake = true;
      outPath = "${deps.unflake_github_hercules-ci_gitignore-nix.outPath}";
      sourceInfo = deps.unflake_github_hercules-ci_gitignore-nix;
    };
    unflake_github_infinidoge_nix-minecraft = ((import "${deps.unflake_github_infinidoge_nix-minecraft.outPath}/flake.nix").outputs {
      self = unflake_github_infinidoge_nix-minecraft;
      flake-compat = unflake_github_edolstra_flake-compat_flake_false;
      flake-utils = unflake_github_numtide_flake-utils;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    }) // deps.unflake_github_infinidoge_nix-minecraft // {
      _flake = true;
      outPath = "${deps.unflake_github_infinidoge_nix-minecraft.outPath}";
      sourceInfo = deps.unflake_github_infinidoge_nix-minecraft;
    };
    unflake_github_ipetkov_crane = ((import "${deps.unflake_github_ipetkov_crane.outPath}/flake.nix").outputs {
      self = unflake_github_ipetkov_crane;
    }) // deps.unflake_github_ipetkov_crane // {
      _flake = true;
      outPath = "${deps.unflake_github_ipetkov_crane.outPath}";
      sourceInfo = deps.unflake_github_ipetkov_crane;
    };
    unflake_github_lf-_flakey-profile = ((import "${deps.unflake_github_lf-_flakey-profile.outPath}/flake.nix").outputs {
      self = unflake_github_lf-_flakey-profile;
    }) // deps.unflake_github_lf-_flakey-profile // {
      _flake = true;
      outPath = "${deps.unflake_github_lf-_flakey-profile.outPath}";
      sourceInfo = deps.unflake_github_lf-_flakey-profile;
    };
    unflake_github_matze_mtheme_flake_false = deps.unflake_github_matze_mtheme_flake_false;
    unflake_github_nix-community_lanzaboote_ref_v0-4-2 = ((import "${deps.unflake_github_nix-community_lanzaboote_ref_v0-4-2.outPath}/flake.nix").outputs {
      self = unflake_github_nix-community_lanzaboote_ref_v0-4-2;
      crane = unflake_github_ipetkov_crane;
      flake-compat = unflake_github_edolstra_flake-compat_flake_false;
      flake-parts = unflake_github_hercules-ci_flake-parts;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
      pre-commit-hooks-nix = unflake_github_cachix_pre-commit-hooks-nix;
      rust-overlay = unflake_github_oxalica_rust-overlay;
    }) // deps.unflake_github_nix-community_lanzaboote_ref_v0-4-2 // {
      _flake = true;
      outPath = "${deps.unflake_github_nix-community_lanzaboote_ref_v0-4-2.outPath}";
      sourceInfo = deps.unflake_github_nix-community_lanzaboote_ref_v0-4-2;
    };
    unflake_github_nix-community_fenix = ((import "${deps.unflake_github_nix-community_fenix.outPath}/flake.nix").outputs {
      self = unflake_github_nix-community_fenix;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
      rust-analyzer-src = unflake_github_rust-lang_rust-analyzer_ref_nightly_flake_false;
    }) // deps.unflake_github_nix-community_fenix // {
      _flake = true;
      outPath = "${deps.unflake_github_nix-community_fenix.outPath}";
      sourceInfo = deps.unflake_github_nix-community_fenix;
    };
    unflake_github_nix-community_flake-compat = ((import "${deps.unflake_github_nix-community_flake-compat.outPath}/flake.nix").outputs {
      self = unflake_github_nix-community_flake-compat;
    }) // deps.unflake_github_nix-community_flake-compat // {
      _flake = true;
      outPath = "${deps.unflake_github_nix-community_flake-compat.outPath}";
      sourceInfo = deps.unflake_github_nix-community_flake-compat;
    };
    unflake_github_nix-community_home-manager = ((import "${deps.unflake_github_nix-community_home-manager.outPath}/flake.nix").outputs {
      self = unflake_github_nix-community_home-manager;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    }) // deps.unflake_github_nix-community_home-manager // {
      _flake = true;
      outPath = "${deps.unflake_github_nix-community_home-manager.outPath}";
      sourceInfo = deps.unflake_github_nix-community_home-manager;
    };
    unflake_github_nix-community_lib-aggregate = ((import "${deps.unflake_github_nix-community_lib-aggregate.outPath}/flake.nix").outputs {
      self = unflake_github_nix-community_lib-aggregate;
      flake-utils = unflake_github_numtide_flake-utils;
      nixpkgs-lib = unflake_github_nix-community_nixpkgs-lib;
    }) // deps.unflake_github_nix-community_lib-aggregate // {
      _flake = true;
      outPath = "${deps.unflake_github_nix-community_lib-aggregate.outPath}";
      sourceInfo = deps.unflake_github_nix-community_lib-aggregate;
    };
    unflake_github_nix-community_naersk = ((import "${deps.unflake_github_nix-community_naersk.outPath}/flake.nix").outputs {
      self = unflake_github_nix-community_naersk;
      fenix = unflake_github_nix-community_fenix;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    }) // deps.unflake_github_nix-community_naersk // {
      _flake = true;
      outPath = "${deps.unflake_github_nix-community_naersk.outPath}";
      sourceInfo = deps.unflake_github_nix-community_naersk;
    };
    unflake_github_nix-community_nixpkgs-wayland = ((import "${deps.unflake_github_nix-community_nixpkgs-wayland.outPath}/flake.nix").outputs {
      self = unflake_github_nix-community_nixpkgs-wayland;
      flake-compat = unflake_github_nix-community_flake-compat;
      lib-aggregate = unflake_github_nix-community_lib-aggregate;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    }) // deps.unflake_github_nix-community_nixpkgs-wayland // {
      _flake = true;
      outPath = "${deps.unflake_github_nix-community_nixpkgs-wayland.outPath}";
      sourceInfo = deps.unflake_github_nix-community_nixpkgs-wayland;
    };
    unflake_github_nix-community_nixpkgs-lib = ((import "${deps.unflake_github_nix-community_nixpkgs-lib.outPath}/flake.nix").outputs {
      self = unflake_github_nix-community_nixpkgs-lib;
    }) // deps.unflake_github_nix-community_nixpkgs-lib // {
      _flake = true;
      outPath = "${deps.unflake_github_nix-community_nixpkgs-lib.outPath}";
      sourceInfo = deps.unflake_github_nix-community_nixpkgs-lib;
    };
    unflake_github_nix-systems_default = ((import "${deps.unflake_github_nix-systems_default.outPath}/flake.nix").outputs {
      self = unflake_github_nix-systems_default;
    }) // deps.unflake_github_nix-systems_default // {
      _flake = true;
      outPath = "${deps.unflake_github_nix-systems_default.outPath}";
      sourceInfo = deps.unflake_github_nix-systems_default;
    };
    unflake_github_nixos_nixpkgs_ref_nixos-unstable = ((import "${deps.unflake_github_nixos_nixpkgs_ref_nixos-unstable.outPath}/flake.nix").outputs {
      self = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    }) // deps.unflake_github_nixos_nixpkgs_ref_nixos-unstable // {
      _flake = true;
      outPath = "${deps.unflake_github_nixos_nixpkgs_ref_nixos-unstable.outPath}";
      sourceInfo = deps.unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    };
    unflake_github_nixos_nixos-hardware = ((import "${deps.unflake_github_nixos_nixos-hardware.outPath}/flake.nix").outputs {
      self = unflake_github_nixos_nixos-hardware;
    }) // deps.unflake_github_nixos_nixos-hardware // {
      _flake = true;
      outPath = "${deps.unflake_github_nixos_nixos-hardware.outPath}";
      sourceInfo = deps.unflake_github_nixos_nixos-hardware;
    };
    unflake_github_nmattia_naersk = ((import "${deps.unflake_github_nmattia_naersk.outPath}/flake.nix").outputs {
      self = unflake_github_nmattia_naersk;
      fenix = unflake_github_nix-community_fenix;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    }) // deps.unflake_github_nmattia_naersk // {
      _flake = true;
      outPath = "${deps.unflake_github_nmattia_naersk.outPath}";
      sourceInfo = deps.unflake_github_nmattia_naersk;
    };
    unflake_github_numtide_flake-utils = ((import "${deps.unflake_github_numtide_flake-utils.outPath}/flake.nix").outputs {
      self = unflake_github_numtide_flake-utils;
      systems = unflake_github_nix-systems_default;
    }) // deps.unflake_github_numtide_flake-utils // {
      _flake = true;
      outPath = "${deps.unflake_github_numtide_flake-utils.outPath}";
      sourceInfo = deps.unflake_github_numtide_flake-utils;
    };
    unflake_github_oxalica_rust-overlay = ((import "${deps.unflake_github_oxalica_rust-overlay.outPath}/flake.nix").outputs {
      self = unflake_github_oxalica_rust-overlay;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    }) // deps.unflake_github_oxalica_rust-overlay // {
      _flake = true;
      outPath = "${deps.unflake_github_oxalica_rust-overlay.outPath}";
      sourceInfo = deps.unflake_github_oxalica_rust-overlay;
    };
    unflake_github_pro-vim_tg-vimhelpbot = ((import "${deps.unflake_github_pro-vim_tg-vimhelpbot.outPath}/flake.nix").outputs {
      self = unflake_github_pro-vim_tg-vimhelpbot;
      advisory-db = unflake_github_rustsec_advisory-db_flake_false;
      crane = unflake_github_ipetkov_crane;
      fenix = unflake_github_nix-community_fenix;
      flake-utils = unflake_github_numtide_flake-utils;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
      vim = unflake_github_vim_vim_flake_false;
    }) // deps.unflake_github_pro-vim_tg-vimhelpbot // {
      _flake = true;
      outPath = "${deps.unflake_github_pro-vim_tg-vimhelpbot.outPath}";
      sourceInfo = deps.unflake_github_pro-vim_tg-vimhelpbot;
    };
    unflake_github_rust-lang_rust-analyzer_ref_nightly_flake_false = deps.unflake_github_rust-lang_rust-analyzer_ref_nightly_flake_false;
    unflake_github_rustsec_advisory-db_flake_false = deps.unflake_github_rustsec_advisory-db_flake_false;
    unflake_gitlab_simple-nixos-mailserver_blobs_flake_false = deps.unflake_gitlab_simple-nixos-mailserver_blobs_flake_false;
    unflake_gitlab_simple-nixos-mailserver_nixos-mailserver = ((import "${deps.unflake_gitlab_simple-nixos-mailserver_nixos-mailserver.outPath}/flake.nix").outputs {
      self = unflake_gitlab_simple-nixos-mailserver_nixos-mailserver;
      blobs = unflake_gitlab_simple-nixos-mailserver_blobs_flake_false;
      flake-compat = unflake_github_edolstra_flake-compat_flake_false;
      git-hooks = unflake_github_cachix_git-hooks-nix;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    }) // deps.unflake_gitlab_simple-nixos-mailserver_nixos-mailserver // {
      _flake = true;
      outPath = "${deps.unflake_gitlab_simple-nixos-mailserver_nixos-mailserver.outPath}";
      sourceInfo = deps.unflake_gitlab_simple-nixos-mailserver_nixos-mailserver;
    };
    unflake_github_supreeeme_xwayland-satellite = ((import "${deps.unflake_github_supreeeme_xwayland-satellite.outPath}/flake.nix").outputs {
      self = unflake_github_supreeeme_xwayland-satellite;
      flake-utils = unflake_github_numtide_flake-utils;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
      rust-overlay = unflake_github_oxalica_rust-overlay;
    }) // deps.unflake_github_supreeeme_xwayland-satellite // {
      _flake = true;
      outPath = "${deps.unflake_github_supreeeme_xwayland-satellite.outPath}";
      sourceInfo = deps.unflake_github_supreeeme_xwayland-satellite;
    };
    unflake_github_vim_vim_flake_false = deps.unflake_github_vim_vim_flake_false;
    unflake_sourcehut_-goldstein_ln-s = ((import "${deps.unflake_sourcehut_-goldstein_ln-s.outPath}/flake.nix").outputs {
      self = unflake_sourcehut_-goldstein_ln-s;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    }) // deps.unflake_sourcehut_-goldstein_ln-s // {
      _flake = true;
      outPath = "${deps.unflake_sourcehut_-goldstein_ln-s.outPath}";
      sourceInfo = deps.unflake_sourcehut_-goldstein_ln-s;
    };
    unflake_tarball_https---git-lix-systems-lix-project-lix-archive-main-tar-gz_flake_false = deps.unflake_tarball_https---git-lix-systems-lix-project-lix-archive-main-tar-gz_flake_false;
    unflake_tarball_https---git-lix-systems-lix-project-nixos-module-archive-main-tar-gz = ((import "${deps.unflake_tarball_https---git-lix-systems-lix-project-nixos-module-archive-main-tar-gz.outPath}/flake.nix").outputs {
      self = unflake_tarball_https---git-lix-systems-lix-project-nixos-module-archive-main-tar-gz;
      flake-utils = unflake_github_numtide_flake-utils;
      flakey-profile = unflake_github_lf-_flakey-profile;
      lix = unflake_tarball_https---git-lix-systems-lix-project-lix-archive-main-tar-gz_flake_false;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    }) // deps.unflake_tarball_https---git-lix-systems-lix-project-nixos-module-archive-main-tar-gz // {
      _flake = true;
      outPath = "${deps.unflake_tarball_https---git-lix-systems-lix-project-nixos-module-archive-main-tar-gz.outPath}";
      sourceInfo = deps.unflake_tarball_https---git-lix-systems-lix-project-nixos-module-archive-main-tar-gz;
    };
  };
  inputs = {
    anti-emoji = universe.unflake_github_goldsteine_anti-emoji-bot;
    classified = universe.unflake_github_goldsteine_classified;
    fenix = universe.unflake_github_nix-community_fenix;
    home-manager = universe.unflake_github_nix-community_home-manager;
    inftheory-slides = universe.unflake_github_goldsteine_inftheory-slides;
    lanzaboote = universe.unflake_github_nix-community_lanzaboote_ref_v0-4-2;
    lix-module = universe.unflake_tarball_https---git-lix-systems-lix-project-nixos-module-archive-main-tar-gz;
    ln-s = universe.unflake_sourcehut_-goldstein_ln-s;
    naersk = universe.unflake_github_nmattia_naersk;
    nix-minecraft = universe.unflake_github_infinidoge_nix-minecraft;
    nixos-hardware = universe.unflake_github_nixos_nixos-hardware;
    nixpkgs = universe.unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    nixpkgs-wayland = universe.unflake_github_nix-community_nixpkgs-wayland;
    passnag = universe.unflake_github_goldsteine_passnag;
    perlsub = universe.unflake_github_goldsteine_perlsub;
    r9ktg = universe.unflake_github_goldsteine_r9ktg;
    simple-nixos-mailserver = universe.unflake_gitlab_simple-nixos-mailserver_nixos-mailserver;
    t = universe.unflake_github_goldsteine_flake-templates;
    tg-vimhelpbot = universe.unflake_github_pro-vim_tg-vimhelpbot;
    xwayland-satellite = universe.unflake_github_supreeeme_xwayland-satellite;
    self = throw "to use inputs.self, write `import ./unflake.nix (inputs: ...)`";
    withInputs = outputs: let self = outputs (inputs // { inherit self; }); in self;
    __functor = self: self.withInputs;
  };
in inputs