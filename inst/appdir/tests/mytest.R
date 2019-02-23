app <- ShinyDriver$new("../")
app$snapshotInit("mytest")

app$setInputs(lang = "es")
app$snapshot()
app$setInputs(lang = "de")
app$snapshot()
app$setInputs(lang = "en")
app$snapshot()
