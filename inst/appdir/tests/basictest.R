app <- ShinyDriver$new("../")
app$snapshotInit("basictest")

app$snapshot()
app$setInputs(tplId = "2")
app$snapshot()
