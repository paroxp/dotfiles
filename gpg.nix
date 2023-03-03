{ ... }:

let cfg = import ./config.nix; in {
  programs.gpg.settings = {
    auto-key-locate = "keyserver";
    keyserver = "hkps://keyserver.ubuntu.com";
    keyserver-options = "no-honor-keyserver-url";
    personal-cipher-preferences = "AES256 AES192 AES CAST5";
    personal-digest-preferences = "SHA512 SHA384 SHA256 SHA224";
    default-preference-list = "SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed";
    cert-digest-algo = "SHA512";
    s2k-cipher-algo = "AES256";
    s2k-digest-algo = "SHA512";
    charset = "utf-8";
    fixed-list-mode = true;
    no-comments = true;
    no-emit-version = true;
    keyid-format = "0xlong";
    list-options = "show-uid-validity";
    verify-options = "show-uid-validity";
    with-fingerprint = true;
    use-agent = true;
    require-cross-certification = true;
  };

  services.gpg-agent = {
    enable = true;

    defaultCacheTtl = 60;
    enableSshSupport = true;
    maxCacheTtl = 120;
    pinentryFlavor = cfg.pinentry;
  };
}
