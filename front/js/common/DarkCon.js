let Dark = localStorage.getItem("Dark")
if (Dark === undefined || Dark === null)
    Dark = "auto"
changDark()

function changDark() {
    Dark = localStorage.getItem("Dark")
    if (Dark === undefined || Dark === null)
        Dark = "auto"
    if (Dark === "auto")
        autoDark()
    else if (Dark === "ok")
        openDark()
    else
        closeDark()
}

function autoDark() {
    DarkReader.auto({
        brightness: 100,
        contrast: 90,
        sepia: 10
    });
    localStorage.setItem("Dark", "auto");
}

function openDark() {
    DarkReader.enable({
        brightness: 100,
        contrast: 90,
        sepia: 10
    });
    localStorage.setItem("Dark", "ok");
}

function closeDark() {
    DarkReader.disable();
    localStorage.setItem("Dark", "no");
}