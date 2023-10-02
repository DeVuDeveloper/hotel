import "./chunk-IER6VNQZ.js";

// node_modules/stimulus-vite-helpers/dist/index.js
var CONTROLLER_FILENAME_REGEX = /^(?:.*?(?:controllers|components)\/|\.?\.\/)?(.+)(?:[/_-]controller\..+?)$/;
function registerControllers(application, controllerModules) {
  application.load(definitionsFromGlob(controllerModules));
}
function definitionsFromGlob(controllerModules) {
  return Object.entries(controllerModules).map(definitionFromEntry).filter((value) => value);
}
function definitionFromEntry([name, controllerModule]) {
  const identifier = identifierForGlobKey(name);
  const controllerConstructor = controllerModule.default;
  if (identifier && typeof controllerConstructor === "function")
    return { identifier, controllerConstructor };
}
function identifierForGlobKey(key) {
  const logicalName = (key.match(CONTROLLER_FILENAME_REGEX) || [])[1];
  if (logicalName)
    return logicalName.replace(/_/g, "-").replace(/\//g, "--");
}
export {
  CONTROLLER_FILENAME_REGEX,
  definitionsFromGlob,
  identifierForGlobKey,
  registerControllers
};
//# sourceMappingURL=stimulus-vite-helpers.js.map
