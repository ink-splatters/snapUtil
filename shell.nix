with import <nixpkgs> { };
mkShell.override { inherit (llvmPackages_19) stdenv; } {
  buildInputs =
    with darwin.apple_sdk.frameworks;
    [
      CoreFoundation
      IOKit
    ]
    ++ [
      gnumake
    ];

}
