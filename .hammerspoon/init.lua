defaultKeyMappers = {
  {{'ctrl'},'g',{},'escape'},

  {{'ctrl'},'w',{'cmd'},'w'},

  {{'ctrl'},'c',{'cmd'},'c'},
  {{'ctrl'},'v',{'cmd'},'v'},
  {{'ctrl'},'x',{'cmd'},'x'},

  {{'ctrl'},'z',{'cmd'},'z'},
  {{'ctrl', 'shift'},'z',{'cmd', 'shift'},'z'},

  -- {{'ctrl'},'a',{'cmd'},'left'},
  -- {{'ctrl'},'e',{'cmd'},'right'},
  {{'alt'},'b',{'alt'},'left'},
  {{'alt'},'f',{'alt'},'right'},
  {{'alt','shift'},',',{'cmd'},'up'},
  {{'alt','shift'},'.',{'cmd'},'down'},

  {{'ctrl'},'s',{'cmd'},'f'},
}

appKeyMappers = {
  ["Emacs"] = "nochange",

  ["Terminal"] = {
    {{'ctrl', 'shift'},'c',{'cmd'},'c'},
    {{'ctrl', 'shift'},'v',{'cmd'},'v'},
    {{'ctrl', 'shift'},'x',{'cmd'},'x'},

    {{'ctrl'},'z',{'cmd'},'z'},
    {{'ctrl', 'shift'},'z',{'cmd', 'shift'},'z'},

    {{'alt'},'b',{'alt'},'left'},
    {{'alt'},'f',{'alt'},'right'},
  },
}

modal = hs.hotkey.modal.new({}, nil )

function applicationWatcher(appName, eventType, appObject)
  --hs.alert.show(appName..eventType)
  if (eventType == hs.application.watcher.activated) then
    actApp(appName)
  end
end

local appWatcher = hs.application.watcher.new(applicationWatcher):start()

function actApp(appName)
  print(appName.." activated.")
  local isMatch = false
  for app, keyMappers in pairs(appKeyMappers) do
    if(appName == app) then
      if keyMappers == "nochange" then
        print("nochange")
        modal:exit()
      else
        modal:exit()
        bindKeyMappers(keyMappers,modal)
        modal:enter()
      end
      isMatch = true
      break
    end
  end
  if isMatch == false then
    modal:exit()
    bindKeyMappers(defaultKeyMappers,modal)
    modal:enter()
  end
end

function bindKeyMappers(keyMappers,modal)
  for i,mapper in ipairs(keyMappers) do
    if modal == nil then
      hs.hotkey.bind(mapper[1], mapper[2], function()
        hs.eventtap.keyStroke(mapper[3],mapper[4])
      end)
    else
      modal:bind(mapper[1], mapper[2], nil, function()
        modal.triggered = true
        hs.eventtap.keyStroke(mapper[3],mapper[4])
      end)
    end
  end
end
