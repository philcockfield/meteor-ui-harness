###
Declares a "suite" as a set of markdown documents.

@param name:       The title of the suite.
@param folderPath: The path to the root folder containing the markdown documents.
@param func:       The suite function.

@returns the resulting [Suite] object.
###
describe.md = (name, folderPath, func) ->
  # Ensure there is no error when the user has put the
  # test file in a shared location.
  return unless Meteor.isClient

  # Fix up parameters.
  if Object.isFunction(folderPath)
    func = folderPath

  if not Object.isString(folderPath)
    folderPath = name

  # Setup initial conditions.
  suite       = describe(name, func)
  meta        = suite.meta
  meta.type   = 'markdown'
  meta.folder = folderPath
  meta.files  = files = {}

  # Store file references.
  for key, value of Markdown.files
    if key.startsWith(folderPath)
      files[key] = value


  # Add child specs.
  specs = []
  for path, file of files
    spec = PKG.markdownSpec(null, path)
    specs.push({ spec:spec, file:file })

  # Sort alphabetically.
  specs = specs.sortBy (item) ->
      item.file.title ? 'Untitled' # NB: Accounts for the *italics* markdown on the spec name.

  for item in specs
    suite.addSpec(item.spec)

  # Finish up.
  suite


