let
  inputs = import ./unflake.nix;
in {
  think = (import ./think.nix) inputs;
  gear = (import ./gear.nix) inputs;
  metal = (import ./metal.nix) inputs;
}
