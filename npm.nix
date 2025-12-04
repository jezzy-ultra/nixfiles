{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [
    pkgs.nix-update

    (inputs.npm-package.lib.${pkgs.stdenv.hostPlatform.system}.npmPackage {
      name = "claude";
      packageName = "@anthropic-ai/claude-code";
      version = "2.0.58";
    })

    (inputs.npm-package.lib.${pkgs.stdenv.hostPlatform.system}.npmPackage {
      name = "copilot";
      packageName = "@github/copilot";
      version = "0.0.366";
    })

    (inputs.npm-package.lib.${pkgs.stdenv.hostPlatform.system}.npmPackage {
      name = "tailwindcss-language-server";
      packageName = "@tailwindcss/language-server";
      version = "0.14.29";
    })
  ];
}
