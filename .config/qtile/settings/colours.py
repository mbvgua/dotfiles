# Monokai Pro
def monokai_pro() -> tuple[list[list[str]], str, str, str, str]:
    colors: list[list[str]] = [
        ["#2D2A2E", "#2D2A2E"],  # bg
        ["#FCFCFA", "#FCFCFA"],  # fg
        ["#403E41", "#403E41"],  # color01
        ["#FF6188", "#FF6188"],  # color02
        ["#A9DC76", "#A9DC76"],  # color03
        ["#FFD866", "#FFD866"],  # color04
        ["#FC9867", "#FC9867"],  # color05
        ["#AB9DF2", "#AB9DF2"],  # color06
        ["#78DCE8", "#78DCE8"],  # color15
        ["#7d7d7d", "#7d7d7d"],  # color09
    ]
    backgroundColor = "#2D2A2E"
    foregroundColor = "#FCFCFA"
    workspaceColor = "#78DCE8"
    foregroundColorTwo = "#7d7d7d"
    return colors, backgroundColor, foregroundColor, workspaceColor, foregroundColorTwo
