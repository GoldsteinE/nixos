{
  enable = true;
  matches.default.matches = [
    { "trigger" = ";;shrug"; "replace" = "¯\\_(ツ)_/¯"; }
    { "trigger" = ";;in"; "replace" = "∈"; }
    { "trigger" = ";;notin"; "replace" = "∉"; }
    { "trigger" = ";;subset"; "replace" = "⊂"; }
    { "trigger" = ";;superset"; "replace" = "⊃"; }
    { "trigger" = ";;exists"; "replace" = "∃"; }
    { "trigger" = ";;forall"; "replace" = "∀"; }
    { "trigger" = ";;bnot"; "replace" = "¬"; }
    { "trigger" = ";;implies"; "replace" = "⇒"; }
    { "trigger" = ";;mail"; "replace" = "root@goldstein.rs"; }
    { "trigger" = ";;ya"; "replace" = "mouse-art@ya.ru"; }
  ];
  configs.default.toggle_key = "OFF";
}
