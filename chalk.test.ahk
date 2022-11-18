#NoEnv
#SingleInstance, Force
#ErrorStdOut UTF-8
#Warn
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

#Include, %A_ScriptDir%\ahkpm-modules\github.com\joshuacc\AutoHotUnit\AutoHotUnit.ahk
#Include, %A_ScriptDir%\chalk.ahk

ahu.RegisterSuite(ChalkSuite)
ahu.RunSuites()

class ChalkSuite extends AutoHotUnitSuite {
    basicColorFunctionCallsWork() {
        colors := ["black", "red", "green", "yellow", "blue", "magenta", "cyan", "white"]
        for k, col in colors {
            str := chalk[col]("text")
            expected := Chalker._colorCodes[col] . "text" . Chalker._reset
            this.assert.equal(str, expected)    
        }
    }

    basicBackgroundColorFunctionCallsWork() {
        bgColors := ["bgBlack", "bgRed", "bgGreen", "bgYellow", "bgBlue", "bgMagenta", "bgCyan", "bgWhite"]
        for k, col in bgColors {
            str := chalk[col]("text")
            expected := Chalker._bgColorCodes[col] . "text" . Chalker._reset
            this.assert.equal(str, expected)    
        }
    }

    basicModifierFunctionCallsWork() {
        modifiers := ["bold", "dim", "italic", "underline", "overline", "inverse", "hidden", "strikethrough"]
        for k, mod in modifiers {
            str := chalk[mod]("text")
            expected := Chalker._modifierCodes[mod] . "text" . Chalker._reset
            this.assert.equal(str, expected)    
        }
    }

    chainingWorks() {
        str := chalk.red.bold("text")
        expected := Chalker._colorCodes["red"] . Chalker._modifierCodes["bold"] . "text" . Chalker._reset
        this.assert.equal(str, expected)

        str2 := chalk.underline.bold.green("text")
        expected2 := Chalker._colorCodes["green"] . Chalker._modifierCodes["bold"] . Chalker._modifierCodes["underline"] . "text" . Chalker._reset
        this.assert.equal(str2, expected2)

        str3 := chalk.bgRed.bold("text")
        expected3 := Chalker._bgColorCodes["bgRed"] . Chalker._modifierCodes["bold"] . "text" . Chalker._reset
        this.assert.equal(str3, expected3)
    }
}
