{ lib, ... }:
{
  imports = builtins.filter
    (path: (builtins.match ".+\.nix" (builtins.toString path)) != null && !(lib.strings.hasInfix "default" path))
    (lib.filesystem.listFilesRecursive ./.);
}