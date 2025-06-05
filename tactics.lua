-- filename: 
-- version: lua51
-- line: [0, 0] id: 0
(function(...)
  -- line: [0, 0] id: 1
  local r0_1 = localPlayer
  if r0_1 == nil then
    r0_1 = createElement("Tactics", "Tactics")
    setElementData(r0_1, "version", "1.2 r20")
    function getAllTacticsData()
      -- line: [10, 12] id: 2
      return getElementData(r0_1, "AllData") or {}
    end
    function getTacticsData(...)
      -- line: [13, 41] id: 3
      local r1_3 = true
      local r2_3 = {
        ...
      }
      if type(r2_3[#r2_3]) == "boolean" then
        r1_3 = table.remove(r2_3)
      end
      if #r2_3 == 1 then
        local r3_3 = getElementData(r0_1, r2_3[1])
        if r1_3 and type(r3_3) == "string" and string.find(r3_3, "|") then
          return gettok(r3_3, 1, string.byte("|")), split(gettok(r3_3, 2, string.byte("|")), ",")
        end
        return r3_3
      elseif #r2_3 > 1 then
        local r3_3 = nil
        for r7_3, r8_3 in ipairs(r2_3) do
          if r7_3 == 1 then
            r3_3 = getElementData(r0_1, r8_3)
          else
            r3_3 = r3_3[r8_3]
          end
          if not r3_3 then
            return nil
          end
        end
        if r1_3 and type(r3_3) == "string" and string.find(r3_3, "|") then
          return gettok(r3_3, 1, string.byte("|")), split(gettok(r3_3, 2, string.byte("|")), ",")
        end
        return r3_3
      end
      return nil
    end
    function getDataType(r0_4)
      -- line: [42, 49] id: 4
      if type(r0_4) == "string" then
        if string.find(r0_4, "|") then
          return "parameter"
        end
        if string.find(r0_4, ":") then
          return "time"
        end
        if r0_4 == "true" or r0_4 == "false" then
          return "toggle"
        end
      end
      return type(r0_4)
    end
    function setTacticsData(r0_5, ...)
      -- line: [50, 98] id: 5
      local r2_5 = false
      local r3_5 = {
        ...
      }
      if type(r3_5[#r3_5]) == "boolean" then
        r2_5 = table.remove(r3_5)
      end
      local r4_5 = nil
      local r5_5 = {}
      if #r3_5 > 1 then
        r5_5[1] = getElementData(r0_1, r3_5[1])
        if type(r5_5[1]) ~= "table" then
          r5_5[1] = {}
        end
        for r9_5 = 2, #r3_5 - 1, 1 do
          local r10_5 = type(r5_5[r9_5 - 1][r3_5[r9_5]])
          if r10_5 == "table" then
            r10_5 = r5_5[r9_5 - 1][r3_5[r9_5]] or {}
          else
            goto label_51	-- block#8 is visited secondly
          end
          r5_5[r9_5] = r10_5
        end
        if type(r0_5) == "table" or r5_5[#r3_5 - 1][r3_5[#r3_5]] ~= r0_5 then
          r4_5 = r5_5[#r3_5 - 1][r3_5[#r3_5]]
          if r2_5 and getDataType(r4_5) == "parameter" then
            r5_5[#r3_5 - 1][r3_5[#r3_5]] = tostring(r0_5) .. string.sub(r4_5, string.find(r4_5, "|"), -1)
          elseif type(r0_5) == "string" then
            r5_5[#r3_5 - 1][r3_5[#r3_5]] = tostring(r0_5)
          else
            r5_5[#r3_5 - 1][r3_5[#r3_5]] = r0_5
          end
        else
          return false
        end
        for r9_5 = #r3_5 - 1, 2, -1 do
          r5_5[r9_5 - 1][r3_5[r9_5]] = r5_5[r9_5]
        end
      elseif #r3_5 == 1 then
        if type(r0_5) == "table" or getElementData(r0_1, r3_5[1]) ~= r0_5 then
          r4_5 = getElementData(r0_1, r3_5[1])
          if r2_5 and getDataType(r4_5) == "parameter" then
            r5_5[1] = tostring(r0_5) .. string.sub(r4_5, string.find(r4_5, "|"), -1)
          elseif type(r0_5) == "string" then
            r5_5[1] = tostring(r0_5)
          else
            r5_5[1] = r0_5
          end
        else
          return false
        end
      else
        return false
      end
      setElementData(r0_1, r3_5[1], r5_5[1])
      triggerEvent("onTacticsChange", root, r3_5, r4_5)
      return true
    end
    addEvent("onTacticsChange")
    addEvent("onSetTacticsData", true)
    addEventHandler("onSetTacticsData", root, function(r0_6, ...)
      -- line: [101, 103] id: 6
      setTacticsData(r0_6, ...)
    end)
    -- close: r0_1
  else
    r0_1 = getElementByID
    r0_1 = r0_1("Tactics")
    function initTacticsData()
      -- line: [106, 139] id: 7
      local r1_7 = nil	-- notice: implicit variable refs by block#[0]
      local r0_7 = {}
      function r1_7(r0_8, r1_8, r2_8)
        -- line: [108, 128] id: 8
        for r6_8, r7_8 in pairs(r0_8) do
          r0_7[r2_8] = r6_8
          if type(r7_8) == "table" and #r7_8 == 0 and type(next(r7_8)) == "string" then
            r1_7(r7_8, r1_8[r6_8] or {}, r2_8 + 1)
            r0_7[r2_8 + 1] = nil
          elseif type(r1_8[r6_8]) == "table" or r7_8 ~= r1_8[r6_8] then
            triggerEvent("onClientTacticsChange", r0_1, r0_7, r1_8[r6_8])
          end
          r1_8[r6_8] = nil
        end
        for r6_8, r7_8 in pairs(r1_8) do
          r0_7[r2_8] = r6_8
          if type(r0_8[r6_8]) == "table" and #r0_8[r6_8] == 0 and type(next(r0_8[r6_8])) == "string" then
            r1_7(r0_8[r6_8], r7_8 or {}, r2_8 + 1)
            r0_7[r2_8 + 1] = nil
          elseif type(r7_8) == "table" or r0_8[r6_8] ~= r7_8 then
            triggerEvent("onClientTacticsChange", r0_1, r0_7, r7_8)
          end
        end
      end
      for r5_7, r6_7 in ipairs(getAllTacticsData()) do
        local r7_7 = getElementData(r0_1, r6_7)
        r0_7[1] = r6_7
        if type(r7_7) == "table" and #r7_7 == 0 and type(next(r7_7)) == "string" then
          r1_7(r7_7, {}, 2)
          r0_7[2] = nil
        else
          triggerEvent("onClientTacticsChange", r0_1, r0_7, nil)
        end
      end
    end
    addEvent("onDownloadComplete")
    addEventHandler("onDownloadComplete", root, initTacticsData)
    local function r1_1(r0_9, r1_9)
      -- line: [142, 173] id: 9
      local r3_9 = nil	-- notice: implicit variable refs by block#[0]
      local r2_9 = {}
      function r3_9(r0_10, r1_10, r2_10)
        -- line: [144, 164] id: 10
        for r6_10, r7_10 in pairs(r0_10) do
          r2_9[r2_10] = r6_10
          if type(r7_10) == "table" and #r7_10 == 0 and type(next(r7_10)) == "string" then
            r3_9(r7_10, r1_10[r6_10] or {}, r2_10 + 1)
            r2_9[r2_10 + 1] = nil
          elseif type(r1_10[r6_10]) == "table" or r7_10 ~= r1_10[r6_10] then
            triggerEvent("onClientTacticsChange", source, r2_9, r1_10[r6_10])
          end
          r1_10[r6_10] = nil
        end
        for r6_10, r7_10 in pairs(r1_10) do
          r2_9[r2_10] = r6_10
          if type(r0_10[r6_10]) == "table" and #r0_10[r6_10] == 0 and type(next(r0_10[r6_10])) == "string" then
            r3_9(r0_10[r6_10], r7_10 or {}, r2_10 + 1)
            r2_9[r2_10 + 1] = nil
          elseif type(r7_10) == "table" or r0_10[r6_10] ~= r7_10 then
            triggerEvent("onClientTacticsChange", source, r2_9, r7_10)
          end
        end
      end
      local r4_9 = getElementData(source, r0_9)
      r2_9[1] = r0_9
      if type(r4_9) == "table" and #r4_9 == 0 and type(next(r4_9)) == "string" then
        r3_9(r4_9, r1_9 or {}, 2)
        r2_9[2] = nil
      else
        triggerEvent("onClientTacticsChange", source, r2_9, r1_9)
      end
    end
    addEvent("onClientTacticsChange")
    addEventHandler("onClientElementDataChange", r0_1, r1_1)
    function getAllTacticsData()
      -- line: [176, 178] id: 11
      return getElementData(r0_1, "AllData") or {}
    end
    function getTacticsData(...)
      -- line: [179, 207] id: 12
      local r1_12 = true
      local r2_12 = {
        ...
      }
      if type(r2_12[#r2_12]) == "boolean" then
        r1_12 = table.remove(r2_12)
      end
      if #r2_12 == 1 then
        local r3_12 = getElementData(r0_1, r2_12[1])
        if r1_12 and type(r3_12) == "string" and string.find(r3_12, "|") then
          return gettok(r3_12, 1, string.byte("|")), split(gettok(r3_12, 2, string.byte("|")), ",")
        end
        return r3_12
      elseif #r2_12 > 1 then
        local r3_12 = nil
        for r7_12, r8_12 in ipairs(r2_12) do
          if r7_12 == 1 then
            r3_12 = getElementData(r0_1, r8_12)
          else
            r3_12 = r3_12[r8_12]
          end
          if not r3_12 then
            return nil
          end
        end
        if r1_12 and type(r3_12) == "string" and string.find(r3_12, "|") then
          return gettok(r3_12, 1, string.byte("|")), split(gettok(r3_12, 2, string.byte("|")), ",")
        end
        return r3_12
      end
      return nil
    end
    function getDataType(r0_13)
      -- line: [208, 215] id: 13
      if type(r0_13) == "string" then
        if string.find(r0_13, "|") then
          return "parameter"
        end
        if string.find(r0_13, ":") then
          return "time"
        end
        if r0_13 == "true" or r0_13 == "false" then
          return "toggle"
        end
      end
      return type(r0_13)
    end
    function setTacticsData(r0_14, ...)
      -- line: [216, 219] id: 14
      triggerServerEvent("onSetTacticsData", r0_1, r0_14, ...)
    end
    -- close: r0_1
  end
  r0_1 = triggerServerEvent
  if r0_1 ~= nil then
    r0_1 = guiGetScreenSize
    xscreen, yscreen = r0_1()
    r0_1 = tocolor
    r0_1 = r0_1(255, 255, 255)
    white = r0_1
    r0_1 = tocolor
    r0_1 = r0_1(255, 255, 255, 192)
    whiteC0 = r0_1
    r0_1 = tocolor
    r0_1 = r0_1(225, 225, 225)
    silver = r0_1
    r0_1 = tocolor
    r0_1 = r0_1(0, 0, 0)
    black = r0_1
    r0_1 = tocolor
    r0_1 = r0_1(0, 0, 0, 192)
    blackC0 = r0_1
    r0_1 = tocolor
    r0_1 = r0_1(0, 0, 0, 128)
    black80 = r0_1
    r0_1 = tocolor
    r0_1 = r0_1(0, 0, 0, 96)
    black60 = r0_1
    r0_1 = tocolor
    r0_1 = r0_1(0, 192, 255, 192)
    blueC0 = r0_1
    r0_1 = tocolor
    r0_1 = r0_1(0, 96, 128, 192)
    darkblueC0 = r0_1
    r0_1 = tocolor
    r0_1 = r0_1(192, 192, 192, 225)
    greyE1 = r0_1
    function r0_1(r0_15, r1_15, r2_15, r3_15)
      -- line: [233, 246] id: 15
      if not r1_15 or not r2_15 or not r3_15 then
        local r4_15 = getElementsByType("Central_Marker")[1]
        if isElement(r4_15) then
          r1_15, r2_15, r3_15 = getElementPosition(r4_15)
        else
          r1_15, r2_15, r3_15 = getElementPosition(localPlayer)
        end
      end
      if not r0_15 then
        r0_15 = 70
      end
      setCameraMatrix(r1_15, r2_15, r3_15, r1_15, r2_15, r3_15 + r0_15)
      setElementData(localPlayer, "Prepair", {
        r1_15,
        r2_15,
        r3_15,
        r0_15
      }, false)
      return true
    end
    setCameraPrepair = r0_1
    function r0_1()
      -- line: [247, 251] id: 16
      if setElementData(localPlayer, "Prepair", nil, false) then
        setCameraTarget(localPlayer)
      end
    end
    stopCameraPrepair = r0_1
    function r0_1(r0_17)
      -- line: [252, 254] id: 17
      return tonumber(0.015 * r0_17 * yscreen / 9)
    end
    getFont = r0_1
    function r0_1()
      -- line: [255, 259] id: 18
      if not isElement(config_gameplay_language) then
        return "language/english.lng"
      end
      local r0_18 = guiGetText(config_gameplay_language)
      local r1_18 = nil	-- notice: implicit variable refs by block#[5]
      if r0_18 then
        r1_18 = config_gameplay_languagelist[r0_18]
        if not r1_18 then
          ::label_16::
          r1_18 = "language/english.lng"
        end
      else
        goto label_16	-- block#4 is visited secondly
      end
      return r1_18
    end
    getPlayerLanguage = r0_1
    function r0_1(r0_19)
      -- line: [260, 282] id: 19
      if config_gameplay_languagelist[guiGetText(config_gameplay_language)] == r0_19 then
        return false
      end
      local r1_19 = xmlLoadFile(r0_19)
      if r1_19 then
        loadedLanguage = {}
        local r2_19 = xmlNodeGetAttribute(r1_19, "name") or ""
        outputChatBox(r2_19 .. " (" .. (xmlNodeGetAttribute(r1_19, "author") or "") .. ")", 255, 100, 100, true)
        for r7_19, r8_19 in ipairs(xmlNodeGetChildren(r1_19)) do
          loadedLanguage[xmlNodeGetName(r8_19)] = xmlNodeGetAttribute(r8_19, "string")
        end
        xmlUnloadFile(r1_19)
        xmlNodeSetAttribute(xmlFindChild(_client, "gameplay", 0), "language", r0_19)
        xmlSaveFile(_client)
        if not config_gameplay_languagelist[r0_19] then
          config_gameplay_languagelist[r0_19] = r2_19
        end
        if not config_gameplay_languagelist[r2_19] then
          config_gameplay_languagelist[r2_19] = r0_19
        end
        guiSetText(config_gameplay_language, r2_19)
        triggerEvent("onClientLanguageChange", localPlayer, r0_19)
        return true
      end
      return false
    end
    setPlayerLanguage = r0_1
    function r0_1(r0_20)
      -- line: [283, 296] id: 20
      if type(loadedLanguage) ~= "table" then
        loadedLanguage = {}
        local r2_20 = xmlLoadFile(getPlayerLanguage())
        if r2_20 then
          for r6_20, r7_20 in ipairs(xmlNodeGetChildren(r2_20)) do
            loadedLanguage[xmlNodeGetName(r7_20)] = xmlNodeGetAttribute(r7_20, "string")
          end
          xmlUnloadFile(r2_20)
        end
      end
      return loadedLanguage[tostring(r0_20)] or ""
    end
    getLanguageString = r0_1
    function r0_1(r0_21, ...)
      -- line: [297, 304] id: 21
      local r2_21 = {
        ...
      }
      if #r2_21 > 0 then
        outputChatBox(string.format(getLanguageString(tostring(r0_21)), unpack(r2_21)), 255, 100, 100, true)
      else
        outputChatBox(getLanguageString(tostring(r0_21)), 255, 100, 100, true)
      end
    end
    outputLangString = r0_1
    function r0_1()
      -- line: [305, 311] id: 22
      if getElementData(localPlayer, "Status") == "Joining" then
        return false
      end
      for r3_22, r4_22 in ipairs(getElementsByType("gui-window", resourceRoot)) do
        if guiGetVisible(r4_22) and r4_22 ~= voting_window then
          return false
        end
      end
      return true
    end
    isAllGuiHidden = r0_1
    function r0_1()
      -- line: [312, 322] id: 23
      if getTacticsData("Pause") then
        local r0_23 = getTacticsData("Unpause")
        if r0_23 then
          return true, r0_23 - getTickCount() + addTickCount
        else
          return true
        end
      end
      return false
    end
    isRoundPaused = r0_1
    r0_1 = {}
    voiceThread = r0_1
    function r0_1(r0_24, r1_24, r2_24, r3_24)
      -- line: [324, 332] id: 24
      if not guiCheckBoxGetSelected(config_audio_voice) then
        return false
      end
      if isElement(voiceThread[r0_24]) then
        return voiceThread[r0_24]
      end
      voiceThread[r0_24] = playSound(r0_24, r1_24 or false)
      if not r2_24 then
        r2_24 = 0.01 * guiScrollBarGetScrollPosition(config_audio_voicevol)
      else
        r2_24 = math.min(r2_24, 0.01 * guiScrollBarGetScrollPosition(config_audio_voicevol))
      end
      setSoundVolume(voiceThread[r0_24], r2_24)
      setSoundSpeed(voiceThread[r0_24], r3_24 or 1)
      return voiceThread[r0_24]
    end
    playVoice = r0_1
    r0_1 = {}
    musicThread = r0_1
    function r0_1(r0_25, r1_25, r2_25)
      -- line: [334, 342] id: 25
      if not guiCheckBoxGetSelected(config_audio_voice) then
        return false
      end
      if isElement(musicThread[r0_25]) then
        return musicThread[r0_25]
      end
      musicThread[r0_25] = playSound(r0_25, r1_25 or false)
      if not r2_25 then
        r2_25 = 0.01 * guiScrollBarGetScrollPosition(config_audio_musicvol)
      else
        r2_25 = math.min(r2_25, 0.01 * guiScrollBarGetScrollPosition(config_audio_musicvol))
      end
      setSoundVolume(musicThread[r0_25], r2_25 or 1)
      setSoundSpeed(musicThread[r0_25], speed or 1)
      return musicThread[r0_25]
    end
    playMusic = r0_1
    function r0_1(r0_26, r1_26, r2_26, r3_26)
      -- line: [343, 347] id: 26
      local r4_26 = 0 - math.deg(math.atan2(r2_26 - r0_26, r3_26 - r1_26))
      if r4_26 < 0 then
        r4_26 = r4_26 + 360
      end
      return r4_26
    end
    getAngleBetweenPoints2D = r0_1
    function r0_1(r0_27, r1_27)
      -- line: [348, 364] id: 27
      local r2_27 = nil	-- notice: implicit variable refs by block#[7]
      if r0_27 < r1_27 then
        if r0_27 < r1_27 - 180 then
          r2_27 = r0_27 - r1_27 - 360
        else
          r2_27 = r0_27 - r1_27
        end
      elseif r1_27 + 180 < r0_27 then
        r2_27 = r0_27 - r1_27 + 360
      else
        r2_27 = r0_27 - r1_27
      end
      return r2_27
    end
    getAngleBetweenAngles2D = r0_1
    r0_1 = {}
    replaceCustom = r0_1
    function r0_1(r0_28, r1_28, r2_28)
      -- line: [366, 379] id: 28
      local r3_28 = {
        model = r0_28,
      }
      local r4_28 = false
      if r1_28 then
        r3_28.txd = engineLoadTXD(r1_28)
        r4_28 = engineImportTXD(r3_28.txd, r0_28)
      end
      if r2_28 then
        r3_28.dff = engineLoadDFF(r2_28, r0_28)
        r4_28 = engineReplaceModel(r3_28.dff, r0_28)
      end
      if r4_28 then
        table.insert(replaceCustom, r3_28)
      end
      return r4_28
    end
    loadCustomObject = r0_1
    r0_1 = addEventHandler
    r0_1("onClientMapStopping", root, function()
      -- line: [380, 391] id: 29
      for r3_29, r4_29 in ipairs(replaceCustom) do
        if r4_29.txd and isElement(r4_29.txd) then
          destroyElement(r4_29.txd)
        end
        if r4_29.dff and isElement(r4_29.dff) then
          destroyElement(r4_29.dff)
          engineRestoreModel(r4_29.model)
        end
      end
      replaceCustom = {}
    end)
    function r0_1(r0_30, r1_30, r2_30, r3_30, r4_30)
      -- line: [392, 406] id: 30
      if not isElement(r0_30) then
        return false
      end
      local r5_30 = getElementMatrix(r0_30)
      local r6_30 = {}
      if not r4_30 then
        r6_30[1] = r1_30 * r5_30[1][1] + r2_30 * r5_30[2][1] + r3_30 * r5_30[3][1] + r5_30[4][1]
        r6_30[2] = r1_30 * r5_30[1][2] + r2_30 * r5_30[2][2] + r3_30 * r5_30[3][2] + r5_30[4][2]
        r6_30[3] = r1_30 * r5_30[1][3] + r2_30 * r5_30[2][3] + r3_30 * r5_30[3][3] + r5_30[4][3]
      else
        r6_30[1] = r1_30 * r5_30[1][1] + r2_30 * r5_30[2][1] + r3_30 * r5_30[3][1]
        r6_30[2] = r1_30 * r5_30[1][2] + r2_30 * r5_30[2][2] + r3_30 * r5_30[3][2]
        r6_30[3] = r1_30 * r5_30[1][3] + r2_30 * r5_30[2][3] + r3_30 * r5_30[3][3]
      end
      return r6_30
    end
    getElementVector = r0_1
    function r0_1(r0_31, ...)
      -- line: [407, 415] id: 31
      local r2_31 = {
        ...
      }
      if r2_31[1] then
        for r6_31, r7_31 in next, r2_31, nil do
          if type(r7_31) == "number" then
            r2_31[r6_31] = tostring(r7_31)
          end
        end
      end
      triggerServerEvent("onClientCallsServerFunction", root, r0_31, unpack(r2_31))
    end
    callServerFunction = r0_1
    function r0_1(r0_32, ...)
      -- line: [416, 422] id: 32
      local r2_32 = {
        ...
      }
      if r2_32[1] then
        for r6_32, r7_32 in next, r2_32, nil do
          r2_32[r6_32] = tonumber(r7_32) or r7_32
        end
      end
      loadstring("return " .. r0_32)()(unpack(r2_32))
    end
    callClientFunction = r0_1
    r0_1 = addEvent
    r0_1("onServerCallsClientFunction", true)
    r0_1 = addEventHandler
    r0_1("onServerCallsClientFunction", root, callClientFunction)
    r0_1 = addEvent
    r0_1("onClientLanguageChange")
    r0_1 = addEvent
    r0_1("onOutputLangString", true)
    r0_1 = addEventHandler
    r0_1("onOutputLangString", root, outputLangString)
  else
    function r0_1(r0_33, r1_33, ...)
      -- line: [429, 431] id: 33
      triggerClientEvent(r0_33, "onOutputLangString", root, r1_33, ...)
    end
    outputLangString = r0_1
    function r0_1(r0_34)
      -- line: [440, 451] id: 34
      if not serverLanguage then
        serverLanguage = {}
        local r1_34 = xmlLoadFile("language/english.lng")
        if r1_34 then
          for r5_34, r6_34 in ipairs(xmlNodeGetChildren(r1_34)) do
            serverLanguage[xmlNodeGetName(r6_34)] = xmlNodeGetAttribute(r6_34, "string")
          end
        end
      end
      return serverLanguage[tostring(r0_34)] or ""
    end
    getString = r0_1
    function r0_1(r0_35, r1_35, r2_35, r3_35, r4_35)
      -- line: [452, 464] id: 35
      if not r2_35 or not r3_35 or not r4_35 then
        local r5_35 = getElementsByType("Central_Marker")[1]
        if isElement(r5_35) then
          r2_35, r3_35, r4_35 = getElementPosition(r5_35)
        else
          r2_35, r3_35, r4_35 = getElementPosition(r0_35)
        end
      end
      if not r1_35 then
        r1_35 = 70
      end
      setCameraMatrix(r0_35, r2_35, r3_35, r4_35, r2_35, r3_35, r4_35 + r1_35)
      setElementData(r0_35, "Prepair", {
        r2_35,
        r3_35,
        r4_35,
        r1_35
      })
    end
    setCameraPrepair = r0_1
    function r0_1(r0_36)
      -- line: [465, 469] id: 36
      if setElementData(r0_36, "Prepair", nil) then
        setCameraTarget(r0_36, r0_36)
      end
    end
    stopCameraPrepair = r0_1
    function r0_1(r0_37, ...)
      -- line: [470, 476] id: 37
      if r0_37 and isElement(r0_37) then
        callClientFunction(r0_37, "setCameraSpectating", ...)
        return true
      end
      return false
    end
    setCameraSpectating = r0_1
    function r0_1()
      -- line: [477, 487] id: 38
      if getTacticsData("Pause") then
        local r0_38 = getTacticsData("Unpause")
        if r0_38 then
          return true, r0_38 - getTickCount()
        else
          return true
        end
      end
      return false
    end
    isRoundPaused = r0_1
    function r0_1(r0_39, r1_39, r2_39, r3_39, r4_39, r5_39, r6_39)
      -- line: [488, 492] id: 39
      local r7_39 = createVehicle(r0_39, r1_39, r2_39, r3_39, r4_39, r5_39, r6_39)
      setElementParent(r7_39, getRoundMapDynamicRoot())
      return r7_39
    end
    createMapVehicle = r0_1
    function r0_1(r0_40, r1_40, ...)
      -- line: [493, 501] id: 40
      local r3_40 = {
        ...
      }
      if r3_40[1] then
        for r7_40, r8_40 in next, r3_40, nil do
          if type(r8_40) == "number" then
            r3_40[r7_40] = tostring(r8_40)
          end
        end
      end
      triggerClientEvent(r0_40, "onServerCallsClientFunction", root, r1_40, unpack(r3_40 or {}))
    end
    callClientFunction = r0_1
    function r0_1(r0_41, ...)
      -- line: [502, 508] id: 41
      local r2_41 = {
        ...
      }
      if r2_41[1] then
        for r6_41, r7_41 in next, r2_41, nil do
          r2_41[r6_41] = tonumber(r7_41) or r7_41
        end
      end
      loadstring("return " .. r0_41)()(unpack(r2_41))
    end
    callServerFunction = r0_1
    r0_1 = addEvent
    r0_1("onClientCallsServerFunction", true)
    r0_1 = addEventHandler
    r0_1("onClientCallsServerFunction", root, callServerFunction)
  end
  function r0_1(r0_42)
    -- line: [512, 520] id: 42
    if r0_42 then
      return getResourceRootElement(r0_42)
    else
      local r1_42 = getResourceFromName(getTacticsData("MapResName"))
      if r1_42 then
        return getResourceRootElement(r1_42)
      end
    end
    return root
  end
  getRoundMapRoot = r0_1
  function r0_1(r0_43)
    -- line: [521, 529] id: 43
    if r0_43 then
      return getResourceDynamicElementRoot(r0_43)
    else
      local r1_43 = getResourceFromName(getTacticsData("MapResName"))
      if r1_43 then
        return getResourceDynamicElementRoot(r1_43)
      end
    end
    return root
  end
  getRoundMapDynamicRoot = r0_1
  function r0_1(r0_44)
    -- line: [530, 532] id: 44
    local r1_44 = type(r0_44)
    if r1_44 == "string" then
      r1_44 = string.gsub(r0_44, "#%x%x%x%x%x%x", "") or r0_44
    else
      goto label_13	-- block#2 is visited secondly
    end
    return r1_44
  end
  removeColorCoding = r0_1
  function r0_1(r0_45)
    -- line: [533, 540] id: 45
    if not string.find(tostring(r0_45), ":") then
      return false
    end
    local r1_45 = split(tostring(r0_45), string.byte(":"))
    local r2_45 = tonumber(r1_45[#r1_45 - 2]) or 0
    return 3600 * r2_45 + 60 * (tonumber(r1_45[#r1_45 - 1]) or 0) + tonumber(r1_45[#r1_45])
  end
  TimeToSec = r0_1
  function r0_1(r0_46, r1_46)
    -- line: [541, 562] id: 46
    if type(r0_46) ~= "number" then
      return false
    end
    if type(r1_46) ~= "number" then
      r1_46 = 1
    end
    local r2_46 = math.floor(r0_46 / 3600000) or 0
    local r3_46 = math.floor(r0_46 / 60000) - r2_46 * 60 or 0
    local r4_46 = math.floor(r0_46 / 1000) - r3_46 * 60 - r2_46 * 3600 or 0
    local r5_46 = r0_46 - r4_46 * 1000 - r3_46 * 60000 - r2_46 * 3600000 or 0
    local r6_46 = string.format("%02i", r4_46)
    if r2_46 > 0 then
      r6_46 = string.format("%i:%02i:", r2_46, r3_46) .. r6_46
    else
      r6_46 = string.format("%i:", r3_46) .. r6_46
    end
    if r1_46 > 0 then
      local r7_46 = string.sub(string.format("%." .. r1_46 .. "f", 0.001 * r5_46), 2)
      if #r7_46 - 1 < r1_46 then
        r7_46 = r7_46 .. string.rep("0", r1_46 - #r7_46 - 1)
      end
      r6_46 = r6_46 .. r7_46
    end
    return r6_46
  end
  MSecToTime = r0_1
  r0_1 = string
  function r0_1.count(r0_47, r1_47)
    -- line: [563, 571] id: 47
    local r2_47 = 0
    local r3_47 = string.find(r0_47, r1_47)
    while r3_47 do
      r2_47 = r2_47 + 1
      r3_47 = string.find(r0_47, r1_47, r3_47 + 1)
    end
    return r2_47
  end
  function r0_1()
    -- line: [572, 580] id: 48
    local r0_48 = {
      modename = getTacticsData("Map"),
      name = getTacticsData("MapName") or "unnamed",
      author = getTacticsData("MapAuthor"),
      resname = getTacticsData("MapResName"),
      mapnext = getTacticsData("ResourceNext"),
    }
    return r0_48
  end
  getRoundMapInfo = r0_1
  function r0_1(...)
    -- line: [581, 589] id: 49
    local r1_49 = {
      ...
    }
    local r3_49 = {
      getTacticsData("modes", getTacticsData("Map"), unpack(r1_49))
    }
    if r3_49[1] then
      return unpack(r3_49)
    end
    return getTacticsData(unpack(r1_49))
  end
  getRoundModeSettings = r0_1
  function r0_1()
    -- line: [590, 599] id: 50
    local r0_50 = {}
    for r4_50, r5_50 in ipairs(getElementsByType("player")) do
      if getElementData(r5_50, "Loading") and getElementData(r5_50, "Status") == "Play" then
        table.insert(r0_50, r5_50)
      end
    end
    if #r0_50 > 1 then
      return r0_50
    end
    return r0_50[1] or false
  end
  getUnreadyPlayers = r0_1
  function r0_1(r0_51)
    -- line: [600, 604] id: 51
    if not isElement(r0_51) then
      return false
    end
    if getElementData(r0_51, "Loading") then
      return "Loading"
    end
    return getElementData(r0_51, "Status")
  end
  getPlayerGameStatus = r0_1
  function r0_1()
    -- line: [605, 608] id: 52
    return getTacticsData("roundState")
  end
  getRoundState = r0_1
end)()
(function(...)
  -- line: [0, 0] id: 53
  wastedTimer = {}
  waitingTimer = nil
  startTimer = nil
  winTimer = nil
  overtimeTimer = nil
  restartTimer = nil
  unpauseTimer = nil
  playersVeh = {}
  function addServerTeam(r0_54, r1_54, r2_54, r3_54)
    -- line: [15, 43] id: 54
    -- notice: unreachable block#31
    local r4_54 = #getElementsByType("team")
    if not r0_54 then
      r0_54 = "Team" .. r4_54
    end
    if not r1_54 then
      local r5_54 = math.random(7, 288)
      while r5_54 == 8 or r5_54 == 42 or r5_54 == 65 or r5_54 == 74 or r5_54 == 86 or r5_54 == 119 or r5_54 == 149 or r5_54 == 208 or r5_54 == 239 or r5_54 == 265 or r5_54 == 266 or r5_54 == 267 or r5_54 == 268 or r5_54 == 269 or r5_54 == 270 or r5_54 == 271 or r5_54 == 272 or r5_54 == 273 do
        r5_54 = math.random(7, 288)
      end
      r1_54 = {
        r5_54
      }
    end
    if not r2_54 then
      r2_54 = {
        math.random(255),
        math.random(255),
        math.random(255)
      }
    end
    if not r3_54 then
      r3_54 = 0
    end
    local r5_54 = createTeam(r0_54, r2_54[1], r2_54[2], r2_54[3])
    local r6_54 = getTacticsData("settings", "friendly_fire")
    if r6_54 == "true" then
      r6_54 = true
    else
      r6_54 = false
    end
    setTeamFriendlyFire(r5_54, r6_54)
    if r4_54 > 0 then
      setElementData(r5_54, "Skins", r1_54)
      setElementData(r5_54, "Score", r3_54)
      setElementData(r5_54, "Side", r4_54)
      local r7_54 = getTacticsData("Sides") and {}
      table.insert(r7_54, r5_54)
      setTacticsData(r7_54, "Sides")
      local r8_54 = {}
      for r12_54, r13_54 in ipairs(r7_54) do
        r8_54[r13_54] = r12_54
      end
      setTacticsData(r8_54, "Teamsides")
    end
    return r5_54
  end
  function removeServerTeam(r0_55)
    -- line: [44, 60] id: 55
    if #getElementsByType("team") <= 1 then
      return false
    end
    local r2_55 = getTacticsData("Sides") or {}
    for r6_55, r7_55 in ipairs(r2_55) do
      if r7_55 == r0_55 then
        table.remove(r2_55, r6_55)
      end
    end
    setTacticsData(r2_55, "Sides")
    local r3_55 = {}
    for r7_55, r8_55 in ipairs(r2_55) do
      r3_55[r8_55] = r7_55
    end
    setTacticsData(r3_55, "Teamsides")
    return destroyElement(r0_55)
  end
  convertWeaponSkillToNames = {
    [69] = "colt45",
    [70] = "silenced",
    [71] = "deagle",
    [72] = "shotgun",
    [73] = "sawnoff",
    [74] = "spaz12",
    [75] = "uzi",
    [76] = "mp5",
    [77] = "ak47",
    [78] = "m4",
    [79] = "sniper",
  }
  convertWeaponNamesToSkill = {
    colt45 = 69,
    silenced = 70,
    deagle = 71,
    shotgun = 72,
    sawnoff = 73,
    spaz12 = 74,
    uzi = 75,
    mp5 = 76,
    ak47 = 77,
    m4 = 78,
    sniper = 79,
  }
  function applyStats(r0_56)
    -- line: [63, 77] id: 56
    for r4_56 in pairs(convertWeaponSkillToNames) do
      setPedStat(r0_56, r4_56, 999)
    end
    for r5_56, r6_56 in pairs({
      [22] = 999,
      [225] = 999,
      [160] = 999,
      [229] = 999,
      [230] = 999,
    }) do
      setPedStat(r0_56, r5_56, r6_56)
    end
  end
  function fixPlayerID(r0_57)
    -- line: [78, 86] id: 57
    if getElementID(r0_57) ~= "" then
      return false
    end
    local r1_57 = 1
    while getElementByID(tostring(r1_57)) do
      r1_57 = r1_57 + 1
    end
    setElementID(r0_57, tostring(r1_57))
    return r1_57
  end
  function setSideNames(r0_58, r1_58)
    -- line: [87, 92] id: 58
    local r2_58 = getTacticsData("SideNames")
    if not r2_58 then
      r2_58 = {}
      local r3_58 = ""
      local r4_58 = ""
      -- setlist for #2 failed
    end
    if not r0_58 then
      r0_58 = r2_58[1]
    end
    if not r1_58 then
      r1_58 = r2_58[2]
    end
    setTacticsData({
      r0_58,
      r1_58
    }, "SideNames")
  end
  function onResourceStop(r0_59)
    -- line: [93, 99] id: 59
    for r4_59, r5_59 in ipairs(getElementsByType("player")) do
      setElementData(r5_59, "Status", nil)
    end
  end
  function onResourceStart(r0_60)
    -- line: [100, 138] id: 60
    if getThisResource() == r0_60 then
      setGameType("Tactics " .. getTacticsData("version"))
      setTacticsData({
        "Attack",
        "Defend"
      }, "SideNames")
      if not fileExists("config/configs.xml") then
        local r1_60 = xmlCreateFile("config/configs.xml", "configs")
        xmlNodeSetAttribute(xmlCreateChild(r1_60, "current"), "src", "_default")
        xmlSaveFile(r1_60)
        xmlUnloadFile(r1_60)
        if fileExists("config/_default.xml") then
          fileDelete("config/_default.xml")
        end
        defaultConfig(true)
      else
        local r1_60 = getCurrentConfig()
        defaultConfig(true)
        startConfig(r1_60, true)
      end
      local r1_60 = {}
      for r5_60 in pairs(getAllElementData(getElementByID("Tactics"))) do
        table.insert(r1_60, r5_60)
      end
      setTacticsData(r1_60, "AllData")
      for r5_60, r6_60 in ipairs(getElementsByType("player")) do
        fixPlayerID(r6_60)
        applyStats(r6_60)
      end
      setTimer(nextMap, 50, 1)
    elseif getResourceInfo(r0_60, "type") == "map" and getResourceName(r0_60) == getTacticsData("MapResName") then
      local r1_60 = {
        modename = getTacticsData("Map"),
        name = getTacticsData("MapName", false) or "unnamed",
        author = getTacticsData("MapAuthor", false),
        resname = getResourceName(r0_60),
        resource = r0_60,
      }
      triggerEvent("onMapStarting", root, r1_60, {}, {
        statsKey = "name",
      })
      outputServerLog("* Change map to " .. getTacticsData("MapName", false))
    end
  end
  function onMapStarting(r0_61)
    -- line: [139, 146] id: 61
    waitingTimer = "wait"
    local r1_61 = TimeToSec(getTacticsData("settings", "time") or "12:00")
    setTime(math.floor(r1_61 / 60), r1_61 - 60 * math.floor(r1_61 / 60))
    for r5_61, r6_61 in ipairs(getElementsByType("player")) do
      removeElementData(r6_61, "RespawnLives")
    end
  end
  function onResourcePreStart(r0_62)
    -- line: [147, 191] id: 62
    if getResourceInfo(r0_62, "type") == "map" then
      local r1_62 = getTacticsData("modes_defined") or {}
      local r2_62 = false
      for r6_62 in pairs(r1_62) do
        if string.find(getResourceName(r0_62), r6_62) == 1 then
          r2_62 = r6_62
        end
      end
      if r2_62 then
        local r3_62 = {
          modename = getTacticsData("Map"),
          name = getTacticsData("MapName", false) or "unnamed",
          author = getTacticsData("MapAuthor", false),
          resname = getTacticsData("MapResName"),
        }
        triggerClientEvent(root, "onClientMapStopping", root, r3_62)
        triggerEvent("onMapStopping", root, r3_62)
        local r4_62 = getResourceInfo(r0_62, "name")
        if not r4_62 then
          r4_62 = string.sub(string.gsub(getResourceName(r0_62), "_", " "), #r2_62 + 2)
          if #r4_62 > 1 then
            r4_62 = string.upper(string.sub(r4_62, 1, 1)) .. string.sub(r4_62, 2)
          end
        end
        r4_62 = string.upper(string.sub(r2_62, 1, 1)) .. string.sub(r2_62, 2) .. ": " .. r4_62
        setMapName(r4_62)
        setTacticsData(r2_62, "Map")
        setTacticsData(r4_62, "MapName")
        setTacticsData(getResourceInfo(r0_62, "author"), "MapAuthor")
        setTacticsData(getResourceName(r0_62), "MapResName")
        local r5_62 = get(getResourceName(r0_62) .. ".Interior")
        if r5_62 then
          setTacticsData(tonumber(r5_62), "Interior")
        else
          setTacticsData(0, "Interior")
        end
        setGameSpeed(tonumber(getTacticsData("settings", "gamespeed") or 1))
        if getTacticsData("settings", "countdown_auto") == "true" then
          setTacticsData({
            "",
            "waiting_for_other_players"
          }, "message")
        else
          setTacticsData({
            "",
            "waiting_for_admin_start"
          }, "message")
        end
      end
    end
  end
  function forcedStartRound(r0_63)
    -- line: [192, 244] id: 63
    if getRoundState() == "started" then
      return 
    end
    if not r0_63 and isTimer(startTimer) then
      return 
    end
    if isTimer(startTimer) then
      killTimer(startTimer)
      startTimer = nil
    end
    if isTimer(waitingTimer) then
      killTimer(waitingTimer)
      waitingTimer = nil
    end
    setTacticsData(nil, "message")
    if r0_63 == "faststart" then
      callClientFunction(root, "showCountdown", 0)
      callClientFunction(root, "fixTickCount", getTickCount())
      for r4_63, r5_63 in ipairs(getElementsByType("player")) do
        if getElementData(r5_63, "Status") == "Play" then
          local r6_63 = getPedOccupiedVehicle(r5_63)
          if isElement(r6_63) then
            setElementFrozen(r6_63, false)
          end
          setElementFrozen(r5_63, false)
          toggleAllControls(r5_63, true)
        end
      end
      local r2_63 = TimeToSec(getTacticsData("modes", getTacticsData("Map"), "timelimit") or "0:00")
      if r2_63 <= 0 then
        setTacticsData(nil, "timeleft")
        if isTimer(overtimeTimer) then
          killTimer(overtimeTimer)
        end
      else
        setTacticsData(getTickCount() + r2_63 * 1000, "timeleft")
        if isTimer(overtimeTimer) then
          killTimer(overtimeTimer)
        end
        overtimeTimer = setTimer(triggerEvent, r2_63 * 1000, 1, "onRoundTimesup", root)
      end
      triggerEvent("onRoundStart", root)
      triggerClientEvent(root, "onClientRoundStart", root)
    elseif r0_63 == "notround" then
      setTacticsData(nil, "timeleft")
      if isTimer(overtimeTimer) then
        killTimer(overtimeTimer)
      end
      for r4_63, r5_63 in ipairs(getElementsByType("player")) do
        if getElementData(r5_63, "Status") == "Play" then
          local r6_63 = getPedOccupiedVehicle(r5_63)
          if isElement(r6_63) then
            setElementFrozen(r6_63, false)
          end
          setElementFrozen(r5_63, false)
          toggleAllControls(r5_63, true)
        end
      end
      triggerEvent("onRoundStart", root)
      triggerClientEvent(root, "onClientRoundStart", root)
    else
      local r1_63 = tonumber(getTacticsData("settings", "countdown_start")) or 3
      startTimer = setTimer(onStartCount, 2000, 1, r1_63)
      triggerEvent("onRoundCountdownStarted", root, 2000 + r1_63 * 1000)
      for r5_63, r6_63 in ipairs(getElementsByType("player")) do
        if getElementData(r6_63, "Status") then
          triggerClientEvent(r6_63, "onClientRoundCountdownStarted", root, 2000 + r1_63 * 1000)
        end
      end
    end
  end
  function onStartCount(r0_64)
    -- line: [245, 252] id: 64
    if r0_64 > 0 then
      callClientFunction(root, "showCountdown", r0_64)
      startTimer = setTimer(onStartCount, 1000, 1, r0_64 - 1)
    else
      forcedStartRound("faststart")
    end
  end
  function endRound(r0_65, r1_65, r2_65)
    -- line: [253, 291] id: 65
    for r6_65, r7_65 in pairs(r2_65 or {}) do
      setElementData(r6_65, "Score", (getElementData(r6_65, "Score") or 0) + r7_65)
    end
    triggerEvent("onRoundFinish", root, r0_65, r1_65, r2_65)
    triggerClientEvent(root, "onClientRoundFinish", root, r0_65, r1_65, r2_65)
    local r3_65 = getTacticsData("MapName", false)
    setTacticsData({
      r0_65,
      r1_65
    }, "message")
    if r0_65 then
      local r4_65 = ""
      if type(r0_65) == "table" then
        if type(r0_65[1]) == "string" then
          local r5_65 = r0_65
          r4_65 = string.format(getString(tostring(table.remove(r5_65, 1))), unpack(r5_65))
        else
          local r5_65 = r0_65[4]
          local r6_65 = r0_65
          table.remove(r6_65, 1)
          table.remove(r6_65, 1)
          table.remove(r6_65, 1)
          table.remove(r6_65, 1)
          r4_65 = string.format(getString(tostring(r5_65)), unpack(r6_65))
        end
      elseif type(r0_65) == "string" then
        r4_65 = getString(r0_65)
        if #r4_65 == 0 then
          r4_65 = tostring(r0_65)
        end
      else
        r4_65 = tostring(r0_65)
      end
      outputServerLog("* Map " .. removeColorCoding(r3_65) .. " ended [" .. removeColorCoding(r4_65) .. "]")
    else
      outputServerLog("* Map " .. removeColorCoding(r3_65) .. " ended")
    end
    setTacticsData(nil, "timeleft")
    if isTimer(waitingTimer) then
      killTimer(waitingTimer)
      waitingTimer = nil
    end
    if isTimer(startTimer) then
      killTimer(startTimer)
      startTimer = nil
    end
    if isTimer(overtimeTimer) then
      killTimer(overtimeTimer)
      overtimeTimer = nil
    end
    if isTimer(winTimer) then
      killTimer(winTimer)
    end
    winTimer = setTimer(nextMap, 8000, 1)
  end
  function clearMap()
    -- line: [292, 312] id: 66
    setTacticsData(nil, "ResourceNext")
    setTacticsData(nil, "timeleft")
    setTacticsData(nil, "timestart")
    setTacticsData(nil, "message")
    setTacticsData(nil, "Restores")
    setTacticsData(nil, "Pause")
    if isTimer(waitingTimer) then
      killTimer(waitingTimer)
      waitingTimer = nil
    end
    if isTimer(startTimer) then
      killTimer(startTimer)
      startTimer = nil
    end
    if isTimer(winTimer) then
      killTimer(winTimer)
    end
    winTimer = nil
    if isTimer(overtimeTimer) then
      killTimer(overtimeTimer)
      overtimeTimer = nil
    end
    if isTimer(restartTimer) then
      killTimer(restartTimer)
    end
    for r3_66, r4_66 in pairs(wastedTimer) do
      if isTimer(r4_66) then
        killTimer(r4_66)
        wastedTimer[r3_66] = nil
      end
    end
    for r3_66, r4_66 in ipairs(getElementsByType("player")) do
      setElementData(r4_66, "Loading", true)
    end
    restartTimer = setTimer(nextMap, 3000, 1)
  end
  function startMap(r0_67, r1_67)
    -- line: [313, 388] id: 67
    if not hasObjectPermissionTo(getThisResource(), "function.startResource", false) then
      outputLangString(root, "resource_have_not_permissions", getResourceName(getThisResource()), "function.startResource")
      return 
    end
    if not hasObjectPermissionTo(getThisResource(), "function.stopResource", false) then
      outputLangString(root, "resource_have_not_permissions", getResourceName(getThisResource()), "function.stopResource")
      return 
    end
    if not hasObjectPermissionTo(getThisResource(), "function.restartResource", false) then
      outputLangString(root, "resource_have_not_permissions", getResourceName(getThisResource()), "function.restartResource")
      return 
    end
    local r2_67 = getTacticsData("modes_defined")
    local r3_67 = getTacticsData("map_disabled") or {}
    if r0_67 then
      if type(r0_67) == "string" and r2_67[r0_67] then
        local r4_67 = {}
        for r8_67, r9_67 in ipairs(getResources()) do
          if getResourceInfo(r9_67, "type") == "map" and string.find(getResourceName(r9_67), r0_67) == 1 then
            table.insert(r4_67, r9_67)
          end
        end
        if #r4_67 > 0 then
          startMap(r4_67[math.random(#r4_67)], "random")
          return true
        end
        return false
      end
      if type(r0_67) == "string" then
        r0_67 = getResourceFromName(r0_67)
      end
      if r0_67 and getResourceInfo(r0_67, "type") == "map" then
        if type(r1_67) == "string" and r1_67 == "vote" then
          local r4_67 = getResourceName(r0_67)
          if getTacticsData("modes", string.lower(string.sub(r4_67, 1, string.find(r4_67, "_") - 1)), "enable") == "false" or r3_67[r4_67] then
            return false
          end
        end
        if type(r1_67) == "number" then
          setTacticsData(r1_67, "ResourceCurrent")
        end
        for r7_67, r8_67 in ipairs(getResources()) do
          if getResourceState(r8_67) == "running" and getResourceInfo(r8_67, "type") == "map" then
            for r12_67, r13_67 in ipairs(getElementChildren(getResourceRootElement(r8_67))) do
              destroyElement(r13_67)
            end
            if r0_67 ~= r8_67 then
              stopResource(r8_67)
            end
          end
        end
        clearMap()
        if not startResource(r0_67) then
          restartResource(r0_67)
        end
        local r4_67 = getResourceInfo(r0_67, "name")
        local r5_67 = getResourceName(r0_67)
        local r6_67 = ""
        for r10_67 in pairs(r2_67) do
          if string.find(r5_67, r10_67) == 1 then
            r6_67 = r10_67
            break
          end
        end
        if not r4_67 then
          r4_67 = string.sub(string.gsub(r5_67, "_", " "), #r6_67 + 2)
          if #r4_67 > 1 then
            r4_67 = string.upper(string.sub(r4_67, 1, 1)) .. string.sub(r4_67, 2)
          end
        end
        r4_67 = string.upper(string.sub(r6_67, 1, 1)) .. string.sub(r6_67, 2) .. ": " .. r4_67
        if type(r1_67) == "string" and r1_67 == "random" then
          outputLangString(root, "map_change_random", r4_67)
        else
          outputLangString(root, "map_change", r4_67)
        end
        return true
      end
    end
    return false
  end
  function nextMap()
    -- line: [389, 474] id: 68
    if not hasObjectPermissionTo(getThisResource(), "function.startResource", false) then
      outputLangString(root, "resource_have_not_permissions", getResourceName(getThisResource()), "function.startResource")
      return 
    end
    if not hasObjectPermissionTo(getThisResource(), "function.stopResource", false) then
      outputLangString(root, "resource_have_not_permissions", getResourceName(getThisResource()), "function.stopResource")
      return 
    end
    if not hasObjectPermissionTo(getThisResource(), "function.restartResource", false) then
      outputLangString(root, "resource_have_not_permissions", getResourceName(getThisResource()), "function.restartResource")
      return 
    end
    local r0_68 = getTacticsData("ResourceNext")
    local r1_68 = getTacticsData("map_disabled") or {}
    if r0_68 then
      return startMap(getResourceFromName(r0_68))
    end
    if getTacticsData("automatics") == "cycler" then
      local r2_68 = getTacticsData("Resources")
      if r2_68 and 0 < #r2_68 then
        local r3_68 = getTacticsData("ResourceCurrent")
        if not r3_68 or #r2_68 <= r3_68 then
          r3_68 = 1
        else
          r3_68 = r3_68 + 1
        end
        local r4_68 = r2_68[r3_68][1]
        if r1_68[r4_68] then
          return false
        end
        setTacticsData(r3_68, "ResourceCurrent")
        return startMap(r4_68)
      end
    end
    if getTacticsData("automatics") == "lobby" then
      local r2_68 = {}
      for r6_68, r7_68 in ipairs(getResources()) do
        if getResourceInfo(r7_68, "type") == "map" and string.find(getResourceName(r7_68), "lobby") == 1 and not r1_68[getResourceName(r7_68)] then
          table.insert(r2_68, r7_68)
        end
      end
      if #r2_68 > 0 then
        return startMap(r2_68[math.random(#r2_68)])
      end
    end
    if getTacticsData("automatics") == "voting" then
      local r2_68 = getTacticsData("modes_defined")
      local r3_68 = {}
      for r7_68, r8_68 in ipairs(getResources()) do
        if getResourceInfo(r8_68, "type") == "map" then
          for r12_68 in pairs(r2_68) do
            if r12_68 ~= "lobby" and string.find(getResourceName(r8_68), r12_68) == 1 and getTacticsData("modes", r12_68, "enable") ~= "false" and not r1_68[getResourceName(r8_68)] then
              table.insert(r3_68, getResourceName(r8_68))
            end
          end
        end
      end
      if #r3_68 > 0 then
        local r4_68 = {}
        for r8_68 = 1, math.min(8, #r3_68), 1 do
          local r9_68 = math.random(#r3_68)
          local r10_68 = r3_68[r9_68]
          table.remove(r3_68, r9_68)
          table.insert(r4_68, {
            r10_68
          })
        end
        table.insert(r4_68, {
          getTacticsData("MapResName"),
          "Play again"
        })
        triggerEvent("onPlayerVote", root, r4_68)
        winTimer = "voting"
        setGameSpeed(tonumber(getTacticsData("settings", "gamespeed") or 1))
        return true
      end
    end
    local r2_68 = getTacticsData("modes_defined")
    local r3_68 = {}
    for r7_68, r8_68 in ipairs(getResources()) do
      if getResourceInfo(r8_68, "type") == "map" then
        for r12_68 in pairs(r2_68) do
          if string.find(getResourceName(r8_68), r12_68) == 1 and getTacticsData("modes", r12_68, "enable") ~= "false" and not r1_68[getResourceName(r8_68)] then
            table.insert(r3_68, r8_68)
          end
        end
      end
    end
    if #r3_68 > 0 then
      return startMap(r3_68[math.random(#r3_68)])
    end
    return false
  end
  function swapTeams()
    -- line: [475, 489] id: 69
    local r0_69 = getTacticsData("Sides") or {}
    local r1_69 = getElementsByType("team")
    table.remove(r1_69, 1)
    if #r0_69 ~= #r1_69 then
      r0_69 = {
        unpack(r1_69)
      }
    end
    table.insert(r0_69, r0_69[1])
    table.remove(r0_69, 1)
    setTacticsData(r0_69, "Sides")
    local r2_69 = {}
    for r6_69, r7_69 in ipairs(r0_69) do
      r2_69[r7_69] = r6_69
    end
    setTacticsData(r2_69, "Teamsides")
  end
  function onPlayerConnect(r0_70, r1_70, r2_70, r3_70, r4_70, r5_70)
    -- line: [490, 492] id: 70
    outputLangString(root, "connect", r0_70, r1_70)
  end
  function onPlayerJoin()
    -- line: [493, 498] id: 71
    setElementData(source, "Status", nil)
    fixPlayerID(source)
    applyStats(source)
    bindKey(source, "R", "down", userRestore)
  end
  function userRestore(r0_72)
    -- line: [499, 514] id: 72
    if getElementData(r0_72, "Status") ~= "Spectate" then
      return 
    end
    for r5_72, r6_72 in ipairs(getTacticsData("Restores") or {}) do
      if r6_72[1] == getPlayerName(r0_72) then
        restorePlayerLoad(r0_72, r5_72)
        return 
      end
    end
    if (getTacticsData("modes", getTacticsData("Map"), "respawn") or getTacticsData("settings", "respawn") or "false") == "true" then
      outputLangString(root, "add_to_round", getPlayerName(r0_72))
      triggerEvent("onPlayerRoundRespawn", r0_72)
    end
  end
  function onPlayerDownloadComplete()
    -- line: [515, 524] id: 73
    callClientFunction(source, "fixTickCount", getTickCount())
    callClientFunction(source, "setTime", getTime())
    setElementData(source, "Status", "Joining")
    if isRoundPaused() then
      fadeCamera(source, true, 0)
    else
      fadeCamera(source, true, 2)
    end
  end
  function onPlayerMapLoad()
    -- line: [525, 541] id: 74
    local r0_74 = getPlayerTeam(source)
    if not r0_74 or getElementData(source, "ChangeTeam") then
      setPlayerTeam(source, nil)
      setElementData(source, "ChangeTeam", nil)
      setElementData(source, "Status", "Joining")
    elseif r0_74 == getElementsByType("team")[1] or getElementData(source, "spectateskin") then
      spawnPlayer(source, 0, 0, 0, 0, getElementModel(source), 0, 0, r0_74)
      setElementData(source, "Status", "Spectate")
      callClientFunction(source, "setCameraSpectating", nil, "playertarget")
    else
      triggerEvent("onPlayerRoundSpawn", source)
    end
    triggerClientEvent(root, "onClientPlayerBlipUpdate", source)
  end
  function onPlayerMapReady()
    -- line: [542, 556] id: 75
    if getRoundState() == "stopped" then
      local r0_75 = getPlayerTeam(source)
      if r0_75 and r0_75 ~= getElementsByType("team")[1] and not getElementData(source, "spectateskin") then
        setElementData(source, "Status", "Play")
      end
    end
    if getRoundState() ~= "started" and getTacticsData("settings", "countdown_auto") == "true" then
      if not getUnreadyPlayers() or getUnreadyPlayers() == source then
        forcedStartRound()
      elseif waitingTimer == "wait" then
        waitingTimer = setTimer(forcedStartRound, 1000 * TimeToSec((getTacticsData("settings", "countdown_force") or "0:10")), 1)
      end
    end
  end
  function onPlayerTeamSelect(r0_76, r1_76)
    -- line: [557, 582] id: 76
    if not r0_76 then
      local r2_76 = getElementsByType("team")
      table.remove(r2_76, 1)
      table.sort(r2_76, function(r0_77, r1_77)
        -- line: [561, 561] id: 77
        return countPlayersInTeam(r0_77) < countPlayersInTeam(r1_77)
      end)
      r0_76 = r2_76[1]
    end
    if not r1_76 then
      local r2_76 = getElementData(r0_76, "Skins")
      if not r2_76 then
        r2_76 = {}
        local r3_76 = 71
        -- setlist for #2 failed
      end
      r1_76 = r2_76[1]
    end
    setPlayerTeam(source, r0_76)
    setElementModel(source, r1_76)
    if r0_76 == getElementsByType("team")[1] or getElementData(source, "spectateskin") then
      spawnPlayer(source, 0, 0, 0, 0, r1_76, 0, 0, r0_76)
      setElementData(source, "Status", "Spectate")
      callClientFunction(source, "setCameraSpectating", nil, "playertarget")
    else
      triggerEvent("onPlayerRoundSpawn", source)
    end
    if not getElementData(source, "Loading") then
      fadeCamera(source, true, 2)
      triggerEvent("onPlayerMapReady", source)
    end
    triggerClientEvent(root, "onClientPlayerBlipUpdate", source)
  end
  function onPlayerRoundSpawn()
    -- line: [583, 585] id: 78
    triggerClientEvent(root, "onClientPlayerRoundSpawn", source)
  end
  function onPlayerRoundRespawn()
    -- line: [586, 589] id: 79
    if isTimer(wastedTimer[source]) then
      killTimer(wastedTimer[source])
    end
    triggerClientEvent(root, "onClientPlayerRoundRespawn", source)
  end
  function onPlayerSpawn()
    -- line: [590, 598] id: 80
    giveWeapon(source, 44)
    takeWeapon(source, 44)
    applyStats(source)
    local r0_80 = tonumber(getTacticsData("settings", "player_start_health"))
    local r1_80 = tonumber(getTacticsData("settings", "player_start_armour"))
    setElementHealth(source, r0_80)
    setPedArmor(source, r1_80)
  end
  function onPlayerQuit(r0_81, r1_81, r2_81)
    -- line: [599, 614] id: 81
    if getElementData(source, "Status") == "Play" and getTacticsData("Map") ~= "lobby" and getTacticsData("settings", "timeout_to_pause") == "true" then
      triggerEvent("onPause", root, true)
    end
    if (isTimer(waitingTimer) or waitingTimer == "wait") and getTacticsData("settings", "countdown_auto") == "true" and (not getUnreadyPlayers() or getUnreadyPlayers() == source) then
      forcedStartRound()
    end
    if r1_81 then
      r1_81 = " [" .. r1_81 .. "]"
    else
      r1_81 = ""
    end
    if restorePlayerSave(source) then
      outputLangString(root, "disconnect_save", getPlayerName(source), r0_81, r1_81)
    else
      outputLangString(root, "disconnect", getPlayerName(source), r0_81, r1_81)
    end
  end
  local r0_53 = {}
  function onPlayerChangeNick(r0_82, r1_82)
    -- line: [616, 624] id: 82
    if r0_53[source] and getTickCount() - 5000 < r0_53[source] then
      cancelEvent()
      outputLangString(source, "change_nick_cancel")
      return 
    end
    r0_53[source] = getTickCount()
    outputLangString(root, "change_nick", tostring(r0_82), tostring(r1_82))
  end
  function onRoundTimesup()
    -- line: [625, 627] id: 83
    triggerClientEvent(root, "onClientRoundTimesup", root)
  end
  function restorePlayerSave(r0_84)
    -- line: [628, 663] id: 84
    if not isElement(r0_84) or getElementData(r0_84, "Status") ~= "Play" or getElementData(r0_84, "Loading") or not getPlayerTeam(r0_84) then
      return false
    end
    local r1_84 = getTacticsData("Restores") or {}
    local r2_84 = getPlayerName(r0_84)
    local r3_84 = getPlayerTeam(r0_84) or nil
    local r4_84 = getElementModel(r0_84)
    local r5_84 = getElementHealth(r0_84)
    local r6_84 = getPedArmor(r0_84)
    local r7_84 = getElementInterior(r0_84)
    local r8_84 = {}
    for r12_84 = 0, 12, 1 do
      local r13_84 = getPedWeapon(r0_84, r12_84)
      local r14_84 = getPedTotalAmmo(r0_84, r12_84)
      local r15_84 = getPedAmmoInClip(r0_84, r12_84)
      if 0 < r13_84 and 0 < r14_84 then
        table.insert(r8_84, {
          r13_84,
          r14_84,
          r15_84
        })
      end
    end
    local r9_84 = getPedWeaponSlot(r0_84)
    local r10_84 = 0
    local r11_84 = 0
    local r12_84 = 0
    local r13_84 = 0
    local r14_84 = 0
    local r15_84 = 0
    local r16_84 = 0
    local r17_84 = false
    local r18_84 = 0
    local r19_84 = getPedOccupiedVehicle(r0_84)
    if not r19_84 then
      r10_84, r11_84, r12_84 = getElementPosition(r0_84)
      r13_84 = getPedRotation(r0_84)
      r14_84, r15_84, r16_84 = getElementVelocity(r0_84)
      isfire = isPedOnFire(r0_84)
    else
      r18_84 = getPedOccupiedVehicleSeat(r0_84)
    end
    table.insert(r1_84, {
      r2_84,
      r3_84,
      r4_84,
      r5_84,
      r6_84,
      r7_84,
      r8_84,
      r9_84,
      r19_84,
      r10_84,
      r11_84,
      r12_84,
      r13_84,
      r14_84,
      r15_84,
      r16_84,
      r17_84,
      r18_84,
      getAllElementData(r0_84) or {},
      nil
    })
    setTacticsData(r1_84, "Restores")
    triggerEvent("onPlayerStored", r0_84, #r1_84)
    return #r1_84
  end
  function restorePlayerLoad(r0_85, r1_85)
    -- line: [664, 697] id: 85
    local r2_85 = getTacticsData("Restores")
    if isElement(r0_85) and r2_85[r1_85] then
      local r3_85, r4_85, r5_85, r6_85, r7_85, r8_85, r9_85, r10_85, r11_85, r12_85, r13_85, r14_85, r15_85, r16_85, r17_85, r18_85, r19_85, r20_85, r21_85 = unpack(r2_85[r1_85])
      setCameraTarget(r0_85, r0_85)
      spawnPlayer(r0_85, r12_85, r13_85, r14_85, r15_85, r5_85, r8_85, 0, r4_85)
      callClientFunction(source, "setCameraInterior", r8_85)
      setElementHealth(r0_85, r6_85)
      setPedArmor(r0_85, r7_85)
      for r25_85, r26_85 in ipairs(r9_85) do
        giveWeapon(r0_85, r26_85[1], r26_85[3])
        if r26_85[3] < r26_85[2] then
          giveWeapon(r0_85, r26_85[1], r26_85[2] - r26_85[3])
        end
      end
      setPedWeaponSlot(r0_85, r10_85)
      if r11_85 then
        warpPedIntoVehicle(r0_85, r11_85, r20_85)
      else
        setElementVelocity(r0_85, r16_85, r17_85, r18_85)
        setPedOnFire(r0_85, r19_85)
      end
      for r25_85, r26_85 in pairs(r21_85) do
        if r25_85 ~= "ID" then
          setElementData(r0_85, r25_85, r26_85)
        end
      end
      fadeCamera(r0_85, true, 0)
      outputLangString(root, "player_restored", getPlayerName(r0_85), r3_85)
      triggerEvent("onPlayerRestored", r0_85, r1_85)
      return true
    end
    return false
  end
  function getRestoreCount()
    -- line: [698, 700] id: 86
    return #(getTacticsData("Restores") or {})
  end
  function getRestoreData(r0_87)
    -- line: [701, 724] id: 87
    local r1_87 = getTacticsData("Restores") or {}
    if not r1_87[r0_87] then
      return false
    end
    local r2_87, r3_87, r4_87, r5_87, r6_87, r7_87, r8_87, r9_87, r10_87, r11_87, r12_87, r13_87, r14_87, r15_87, r16_87, r17_87, r18_87, r19_87, r20_87 = unpack(r1_87[r0_87])
    local r21_87 = {
      name = r2_87,
      posX = r11_87,
      posY = r12_87,
      posZ = r13_87,
      rotation = r14_87,
      interior = r7_87,
      team = r3_87,
      skin = r4_87,
      health = r5_87,
      armour = r6_87 or 0,
      velocityX = r15_87 or 0,
      velocityY = r16_87 or 0,
      velocityZ = r17_87 or 0,
      onfire = r18_87 or false,
      weapons = r8_87 or {},
      weaponslot = r9_87 or 0,
      vehicle = r10_87 or nil,
      vehicleseat = r19_87 or nil,
      data = r20_87 or {},
    }
    return r21_87
  end
  function onPlayerWeaponpackChose(r0_88, r1_88)
    -- line: [725, 755] id: 88
    if getRoundState() ~= "started" then
      return 
    end
    takeAllWeapons(r0_88)
    local r2_88 = getTacticsData("weapon_balance") or {}
    local r3_88 = 0
    for r7_88, r8_88 in ipairs(r1_88) do
      if r8_88.id then
        local r9_88 = getPlayerTeam(r0_88)
        local r10_88 = getSlotFromWeapon(r8_88.id)
        if r2_88[r8_88.name] and r9_88 then
          local r11_88 = 0
          for r15_88, r16_88 in ipairs(getPlayersInTeam(r9_88)) do
            if getPedWeapon(r16_88, r10_88) == r8_88.id then
              r11_88 = r11_88 + 1
            end
          end
          if tonumber(r2_88[r8_88.name]) <= r11_88 then
            outputLangString(r0_88, "weapon_limited", r8_88.name, tonumber(r2_88[r8_88.name]))
          else
            giveWeapon(r0_88, r8_88.id, r8_88.ammo)
            setWeaponAmmo(r0_88, r8_88.id, r8_88.ammo)
          end
        else
          giveWeapon(r0_88, r8_88.id, r8_88.ammo)
          setWeaponAmmo(r0_88, r8_88.id, r8_88.ammo)
        end
        if r3_88 == 0 then
          r3_88 = r10_88
        end
      end
    end
    setPedWeaponSlot(r0_88, r3_88)
    triggerEvent("onPlayerWeaponpackGot", r0_88, r1_88)
    triggerClientEvent(root, "onClientPlayerWeaponpackGot", r0_88, r1_88)
  end
  function onPlayerVehicleSelect(r0_89, r1_89, r2_89)
    -- line: [756, 817] id: 89
    if getElementData(r0_89, "Status") ~= "Play" then
      return 
    end
    local r3_89 = getPedOccupiedVehicle(r0_89)
    local r4_89 = false
    if r3_89 then
      setElementModel(r3_89, r1_89)
      local r5_89 = getVehicleSirensOn(r3_89)
      removeVehicleSirens(r3_89)
      local r6_89 = getTacticsData("handlings")[r1_89]
      if r6_89 then
        for r10_89, r11_89 in pairs(r6_89) do
          if r10_89 == "sirens" then
            addVehicleSirens(r3_89, r11_89.count, r11_89.type, r11_89.flags["360"], r11_89.flags.DoLOSCheck, r11_89.flags.UseRandomiser, r11_89.flags.Silent)
            for r15_89 = 1, r11_89.count, 1 do
              local r16_89, r17_89, r18_89, r19_89 = getColorFromString("#" .. r11_89[r15_89].color)
              setVehicleSirens(r3_89, r15_89, r11_89[r15_89].x, r11_89[r15_89].y, r11_89[r15_89].z, r17_89, r18_89, r19_89, r16_89, r11_89[r15_89].minalpha)
            end
            setVehicleSirensOn(r3_89, r5_89 or false)
          elseif r10_89 == "modelFlags" or r10_89 == "handlingFlags" then
            setVehicleHandling(r3_89, r10_89, tonumber(r6_89[r10_89]))
          elseif type(r6_89[r10_89]) == "table" then
            setVehicleHandling(r3_89, r10_89, {
              unpack(r6_89[r10_89])
            })
          else
            setVehicleHandling(r3_89, r10_89, r6_89[r10_89])
          end
        end
      end
    else
      local r5_89 = tonumber(getTacticsData("settings", "vehicle_per_player") or 2)
      local r6_89, r7_89, r8_89 = getElementPosition(r0_89)
      local r9_89, r10_89, r11_89 = getElementVelocity(r0_89)
      r3_89 = createMapVehicle(r1_89, r6_89, r7_89, r8_89 + 1, 0, 0, getPedRotation(r0_89))
      setElementInterior(r3_89, getElementInterior(r0_89))
      setElementVelocity(r3_89, r9_89, r10_89, r11_89)
      warpPedIntoVehicle(r0_89, r3_89)
      if not playersVeh[r0_89] then
        playersVeh[r0_89] = {}
      end
      table.insert(playersVeh[r0_89], 1, r3_89)
      while r5_89 < #playersVeh[r0_89] and 0 < r5_89 do
        local r15_89 = isElement(playersVeh[r0_89][#playersVeh[r0_89]])
        if r15_89 then
          destroyElement(playersVeh[r0_89][#playersVeh[r0_89]])
        end
        table.remove(playersVeh[r0_89])
      end
      local r15_89 = getTacticsData("handlings")[r1_89]
      if r15_89 and r15_89.sirens then
        local r16_89 = r15_89.sirens
        addVehicleSirens(r3_89, r16_89.count, r16_89.type, r16_89.flags["360"], r16_89.flags.DoLOSCheck, r16_89.flags.UseRandomiser, r16_89.flags.Silent)
        for r20_89 = 1, r16_89.count, 1 do
          local r21_89, r22_89, r23_89, r24_89 = getColorFromString("#" .. r16_89[r20_89].color)
          setVehicleSirens(r3_89, r20_89, r16_89[r20_89].x, r16_89[r20_89].y, r16_89[r20_89].z, r22_89, r23_89, r24_89, r21_89, r16_89[r20_89].minalpha)
        end
      end
      r4_89 = true
    end
    addVehicleUpgrade(r3_89, 1008)
    if getVehicleType(r3_89) == "Train" then
      setTrainDerailed(r3_89, true)
    end
    triggerEvent("onPlayerVehiclepackGot", r0_89, r3_89, r4_89)
    triggerClientEvent(root, "onClientPlayerVehiclepackGot", r0_89, r3_89, r4_89, r2_89)
  end
  function onTacticsChange(r0_90, r1_90)
    -- line: [818, 920] id: 90
    if r0_90[1] == "settings" then
      if r0_90[2] == "countdown_auto" and getTacticsData("settings", "countdown_auto") == "true" and getRoundState() ~= "started" then
        if not getUnreadyPlayers() then
          forcedStartRound()
        elseif waitingTimer == "wait" then
          waitingTimer = setTimer(forcedStartRound, 1000 * TimeToSec((getTacticsData("settings", "countdown_force") or "0:10")), 1)
        end
      end
      if r0_90[2] == "player_dead_visible" then
        if getTacticsData("settings", "player_dead_visible") == "false" then
          for r5_90, r6_90 in ipairs(getElementsByType("player")) do
            if getElementData(r6_90, "Status") ~= "Play" then
              setElementAlpha(r6_90, 0)
            end
          end
        else
          for r5_90, r6_90 in ipairs(getElementsByType("player")) do
            if getElementAlpha(r6_90) == 0 then
              setElementAlpha(r6_90, 255)
            end
          end
        end
      end
      if r0_90[2] == "player_can_driveby" and getTacticsData("settings", "player_can_driveby") == "false" then
        for r5_90, r6_90 in ipairs(getElementsByType("player")) do
          if isPedDoingGangDriveby(r6_90) then
            setPedDoingGangDriveby(r6_90, false)
          end
        end
      end
      if r0_90[2] == "vehicle_tank_explodable" then
        if getTacticsData("settings", "vehicle_tank_explodable") == "false" then
          for r5_90, r6_90 in ipairs(getElementsByType("vehicle")) do
            setVehicleFuelTankExplodable(r6_90, false)
          end
        else
          for r5_90, r6_90 in ipairs(getElementsByType("vehicle")) do
            setVehicleFuelTankExplodable(r6_90, true)
          end
        end
      end
      if r0_90[2] == "vehicle_respawn_idle" then
        local r2_90 = TimeToSec(getTacticsData("settings", "vehicle_respawn_idle")) or 0
        if r2_90 > 0 then
          for r6_90, r7_90 in ipairs(getElementsByType("vehicle")) do
            toggleVehicleRespawn(r7_90, true)
            setVehicleIdleRespawnDelay(r7_90, r2_90)
            resetVehicleIdleTime(r7_90)
          end
        elseif getTacticsData("settings", "vehicle_respawn_blown") == "0:00" then
          for r6_90, r7_90 in ipairs(getElementsByType("vehicle")) do
            toggleVehicleRespawn(r7_90, false)
            setVehicleIdleRespawnDelay(r7_90, 65536000)
            resetVehicleIdleTime(r7_90)
          end
        end
      end
      if r0_90[2] == "vehicle_respawn_blown" then
        local r2_90 = TimeToSec(getTacticsData("settings", "vehicle_respawn_blown")) or 0
        if r2_90 > 0 then
          for r6_90, r7_90 in ipairs(getElementsByType("vehicle")) do
            toggleVehicleRespawn(r7_90, true)
            setVehicleRespawnDelay(r7_90, r2_90)
            resetVehicleExplosionTime(r7_90)
          end
        elseif getTacticsData("settings", "vehicle_respawn_idle") == "0:00" then
          for r6_90, r7_90 in ipairs(getElementsByType("vehicle")) do
            toggleVehicleRespawn(r7_90, false)
            setVehicleRespawnDelay(r7_90, 65536000)
            resetVehicleExplosionTime(r7_90)
          end
        end
      end
      if r0_90[2] == "time" then
        setMinuteDuration(0)
        local r2_90 = TimeToSec(getTacticsData("settings", "time"))
        setTime(math.floor(r2_90 / 60), r2_90 - 60 * math.floor(r2_90 / 60))
        setTimer(function()
          -- line: [899, 905] id: 91
          if getTacticsData("settings", "time_locked") == "true" then
            setMinuteDuration(65535000)
          else
            setMinuteDuration(tonumber(getTacticsData("settings", "time_minuteduration")))
          end
        end, 100, 1)
      end
      if r0_90[2] == "time_minuteduration" and getTacticsData("settings", "time_locked") == "false" then
        setMinuteDuration(tonumber(getTacticsData("settings", "time_minuteduration")))
      end
      if r0_90[2] == "time_locked" then
        if getTacticsData("settings", "time_locked") == "true" then
          setMinuteDuration(65535000)
        else
          setMinuteDuration(tonumber(getTacticsData("settings", "time_minuteduration")))
        end
      end
    end
  end
  function onElementDataChange(r0_92, r1_92)
    -- line: [921, 934] id: 92
    if r0_92 == "Status" and getElementType(source) == "player" then
      triggerEvent("onPlayerGameStatusChange", source, r1_92)
      if r1_92 == "Play" and getTacticsData("settings", "player_dead_visible") == "false" then
        setElementAlpha(source, 0)
      end
      if getElementData(source, "Status") == "Play" and getElementAlpha(source) == 0 then
        setElementAlpha(source, 255)
      end
      if getElementData(source, "Status") == "Play" and isKeyBound(source, "R", "down", userRestore) then
        unbindKey(source, "R", "down", userRestore)
      end
    end
  end
  function onPlay(r0_93)
    -- line: [935, 942] id: 93
    if r0_93 and not hasObjectPermissionTo(r0_93, "general.tactics_players", false) then
      return outputLangString(r0_93, "you_have_not_permissions")
    end
    if getRoundState() ~= "started" and not isTimer(winTimer) then
      forcedStartRound()
    end
  end
  function onPause(r0_94, r1_94)
    -- line: [943, 1013] id: 94
    if r1_94 and not hasObjectPermissionTo(r1_94, "general.tactics_players", false) then
      return outputLangString(r1_94, "you_have_not_permissions")
    end
    if getRoundState() ~= "started" then
      return false
    end
    if r0_94 == nil then
      if not getTacticsData("Pause") or getTacticsData("Unpause") then
        r0_94 = true
      else
        r0_94 = false
      end
    end
    if r0_94 then
      if isTimer(unpauseTimer) then
        killTimer(unpauseTimer)
      end
      setTacticsData(nil, "Unpause")
      if not getTacticsData("Pause") then
        tickPause = getTickCount()
        if isTimer(overtimeTimer) then
          local r2_94 = getTimerDetails(overtimeTimer)
          killTimer(overtimeTimer)
          setTacticsData(r2_94, "Pause")
        else
          setTacticsData(true, "Pause")
        end
        setGameSpeed(0)
        for r5_94, r6_94 in ipairs(getElementsByType("vehicle")) do
          if not isElementFrozen(r6_94) then
            local r7_94, r8_94, r9_94 = getElementVelocity(r6_94)
            local r10_94, r11_94, r12_94 = getVehicleTurnVelocity(r6_94)
            setElementData(r6_94, "Velocity", {
              r7_94,
              r8_94,
              r9_94,
              r10_94,
              r11_94,
              r12_94
            })
            setElementFrozen(r6_94, true)
            setVehicleDamageProof(r6_94, true)
          end
        end
        local r2_94 = getTacticsData("timestart")
        if r2_94 then
          setTacticsData(getTickCount() - r2_94, "timestart")
        end
        triggerEvent("onPauseToggle", root, true)
        triggerClientEvent(root, "onClientPauseToggle", root, true)
        return 
      end
    elseif getTacticsData("Pause") then
      if isTimer(unpauseTimer) then
        killTimer(unpauseTimer)
      end
      setTacticsData(getTickCount() + 2000, "Unpause")
      unpauseTimer = setTimer(function()
        -- line: [986, 1010] id: 95
        setTacticsData(nil, "Unpause")
        local r0_95 = getTacticsData("Pause")
        if type(r0_95) == "number" then
          overtimeTimer = setTimer(triggerEvent, r0_95, 1, "onRoundTimesup", root)
          setTacticsData(getTickCount() + r0_95, "timeleft")
        end
        setTacticsData(nil, "Pause")
        for r4_95, r5_95 in ipairs(getElementsByType("vehicle")) do
          local r6_95 = getElementData(r5_95, "Velocity")
          if r6_95 then
            setVehicleDamageProof(r5_95, false)
            setElementFrozen(r5_95, false)
            setElementVelocity(r5_95, r6_95[1], r6_95[2], r6_95[3])
            setVehicleTurnVelocity(r5_95, r6_95[4], r6_95[5], r6_95[6])
            setElementData(r5_95, "Velocity", nil)
          end
        end
        setGameSpeed(tonumber(getTacticsData("settings", "gamespeed") or 1))
        local r1_95 = getTacticsData("timestart")
        if r1_95 then
          setTacticsData(getTickCount() - r1_95, "timestart")
        end
        triggerEvent("onPauseToggle", root, false, getTickCount() - tickPause)
        triggerClientEvent(root, "onClientPauseToggle", root, false, getTickCount() - tickPause)
      end, 2000, 1)
    end
    return false
  end
  function onPlayerChat(r0_96, r1_96)
    -- line: [1014, 1034] id: 96
    if r1_96 == 0 then
      local r2_96, r3_96, r4_96, r5_96 = getPlayerTeam(source)
      if not r2_96 then
        r3_96, r4_96, r5_96 = getPlayerNametagColor(source)
      else
        r3_96, r4_96, r5_96 = getTeamColor(r2_96)
      end
      outputChatBox(getPlayerName(source) .. " (" .. getElementID(source) .. "): #EBDDB2" .. r0_96, root, r3_96, r4_96, r5_96, true)
      outputServerLog("CHAT: " .. getPlayerName(source) .. ": " .. r0_96)
      cancelEvent()
    elseif r1_96 == 2 then
      local r2_96 = getPlayerTeam(source)
      local r3_96, r4_96, r5_96 = getTeamColor(r2_96)
      for r9_96, r10_96 in ipairs(getPlayersInTeam(r2_96)) do
        outputChatBox("(TEAM) " .. getPlayerName(source) .. " (" .. getElementID(source) .. "): #EBDDB2" .. r0_96, r10_96, r3_96, r4_96, r5_96, true)
      end
      outputServerLog("TEAMCHAT: " .. getPlayerName(source) .. ": " .. r0_96)
      cancelEvent()
    end
  end
  function forceRespawnPlayer(r0_97, r1_97, r2_97)
    -- line: [1035, 1073] id: 97
    local r3_97 = getPlayerTeam(r0_97) or nil
    local r4_97 = getElementModel(r0_97)
    local r5_97 = getElementHealth(r0_97)
    local r6_97 = getPedArmor(r0_97)
    local r7_97 = getElementInterior(r0_97)
    local r8_97 = nil
    local r9_97 = nil
    local r10_97 = nil
    local r11_97 = nil
    local r12_97 = nil
    local r13_97, r14_97, r15_97 = getElementPosition(r0_97)
    local r16_97 = getPedRotation(r0_97)
    local r17_97 = getPedOccupiedVehicle(r0_97)
    if not r17_97 then
      r8_97, r9_97, r10_97 = getElementVelocity(r0_97)
      r11_97 = isPedOnFire(r0_97)
      isfrozen = isElementFrozen(r0_97)
    else
      r12_97 = getPedOccupiedVehicleSeat(r0_97)
      removePedFromVehicle(r0_97)
    end
    if isPedDead(r0_97) then
      return 
    end
    setCameraTarget(r0_97, r0_97)
    spawnPlayer(r0_97, r13_97, r14_97, r15_97, r16_97, r4_97, r7_97, 0, r3_97)
    setElementHealth(r0_97, r5_97)
    setPedArmor(r0_97, r6_97)
    for r21_97, r22_97 in ipairs(r1_97) do
      local r23_97, r24_97, r25_97, r26_97 = unpack(r22_97)
      giveWeapon(r0_97, r23_97, 1, r26_97)
      setWeaponAmmo(r0_97, r23_97, r24_97, r25_97)
    end
    if r17_97 then
      warpPedIntoVehicle(r0_97, r17_97, r12_97)
    else
      setElementVelocity(r0_97, r8_97, r9_97, r10_97)
      setPedOnFire(r0_97, r11_97)
      setElementFrozen(r0_97, isfrozen)
    end
    triggerEvent("onPlayerRPS", r0_97)
    triggerClientEvent(root, "onClientPlayerRPS", r0_97)
  end
  function onMapStopping(r0_98)
    -- line: [1074, 1080] id: 98
    setTacticsData("stopped", "roundState")
    if r0_98.modename ~= "lobby" then
      if getTacticsData("settings", "autoswap") == "true" then
        swapTeams()
      end
      if getTacticsData("settings", "autobalance") == "true" then
        balanceTeams()
      end
    end
  end
  function onRoundStart()
    -- line: [1081, 1084] id: 99
    setTacticsData("started", "roundState")
    setTacticsData(getTickCount(), "timestart")
  end
  function onRoundFinish(r0_100, r1_100)
    -- line: [1085, 1087] id: 100
    setTacticsData("finished", "roundState")
  end
  function onVehicleEnter(r0_101, r1_101, r2_101)
    -- line: [1088, 1095] id: 101
    if r1_101 == 0 and getElementType(r0_101) == "player" and getPlayerTeam(r0_101) and getTacticsData("settings", "vehicle_color") == "teamcolor" then
      local r3_101, r4_101, r5_101 = getTeamColor(getPlayerTeam(r0_101))
      setVehicleColor(source, r3_101, r4_101, r5_101, 0, 0, 0)
    end
  end
  function fixFistBug(r0_102)
    -- line: [1097, 1107] id: 102
    for r4_102 = 1, 12, 1 do
      local r5_102 = getPedWeapon(r0_102, r4_102)
      local r6_102 = getPedTotalAmmo(r0_102, r4_102)
      local r7_102 = getPedAmmoInClip(r0_102, r4_102)
      if 0 < r5_102 and 1 < r6_102 then
        giveWeapon(r0_102, r5_102, r6_102, false)
        setWeaponAmmo(r0_102, r5_102, r6_102, r7_102)
      end
    end
  end
  addEventHandler("onVehicleExit", root, fixFistBug)
  function warpPlayerToJoining(r0_103)
    -- line: [1110, 1116] id: 103
    if not setElementData(r0_103, "Status", "Joining") then
      return 
    end
    if isPedInVehicle(r0_103) then
      removePedFromVehicle(r0_103)
    end
    setElementPosition(r0_103, 0, 0, 0)
    setElementFrozen(r0_103, true)
    setPlayerTeam(r0_103, nil)
  end
  function suicidePlayer(r0_104)
    -- line: [1117, 1124] id: 104
    if not isPedDead(r0_104) and getElementData(r0_104, "Status") == "Play" and triggerEvent("onPlayerSuicide", r0_104) == true then
      setPlayerProperty(r0_104, "invulnerable", false)
      killPed(r0_104)
    end
  end
  function toggleGangDriveby(r0_105)
    -- line: [1125, 1130] id: 105
    local r1_105 = getPedOccupiedVehicleSeat(r0_105)
    if r1_105 and 0 < r1_105 then
      setPedDoingGangDriveby(r0_105, not isPedDoingGangDriveby(r0_105))
    end
  end
  function onPlayerWasted(r0_106, r1_106, r2_106, r3_106, r4_106)
    -- line: [1131, 1163] id: 106
    if isTimer(wastedTimer[source]) then
      killTimer(wastedTimer[source])
    end
    wastedTimer[source] = setTimer(function(r0_107)
      -- line: [1133, 1136] id: 107
      if not isElement(r0_107) then
        return 
      end
      triggerEvent("onPlayerRoundSpawn", r0_107)
    end, 2000, 1, source)
    if (getRoundModeSettings("respawn") or getTacticsData("settings", "respawn") or "false") == "true" then
      local r6_106 = tonumber(getRoundModeSettings("respawn_lives") or getTacticsData("settings", "respawn_lives") or tonumber(0))
      local r7_106 = TimeToSec(getRoundModeSettings("respawn_time") or getTacticsData("settings", "respawn_time")) or tonumber(0)
      local r8_106 = getElementData(source, "RespawnLives") or r6_106
      local r9_106 = getTacticsData("timeleft")
      local r10_106 = nil
      if r9_106 then
        local r11_106 = getTacticsData("Pause")
        if r11_106 then
          r10_106 = r11_106
        else
          r10_106 = r9_106 - getTickCount()
        end
      end
      if r6_106 <= 0 then
        if not r10_106 or r7_106 * 1000 < r10_106 then
          triggerClientEvent(source, "onClientRespawnCountdown", root, r7_106 * 1000)
        end
      else
        setElementData(source, "RespawnLives", r8_106 - 1)
        if 0 <= r8_106 and (not r10_106 or r7_106 * 1000 < r10_106) then
          triggerClientEvent(source, "onClientRespawnCountdown", root, r7_106 * 1000)
        end
      end
    end
  end
  addEvent("onMapStarting")
  addEvent("onMapStopping")
  addEvent("onPlayerRoundSpawn")
  addEvent("onPlayerRoundRespawn", true)
  addEvent("onRoundTimesup")
  addEvent("onPlayerMapLoad", true)
  addEvent("onPlayerMapReady", true)
  addEvent("onPlayerTeamSelect", true)
  addEvent("onPause", true)
  addEvent("onPauseToggle")
  addEvent("onPlayerRemoveFromRound", true)
  addEvent("onPlayerDownloadComplete", true)
  addEvent("onPlay", true)
  addEvent("onPlayerWeaponpackGot")
  addEvent("onPlayerVehiclepackGot")
  addEvent("onRoundStart")
  addEvent("onRoundFinish")
  addEvent("onRoundCountdownStarted")
  addEvent("onPlayerRestored")
  addEvent("onPlayerStored")
  addEvent("onPlayerRPS")
  addEvent("onPlayerSuicide")
  addEvent("onPlayerGameStatusChange")
  addEventHandler("onResourcePreStart", root, onResourcePreStart)
  addEventHandler("onResourceStart", root, onResourceStart)
  addEventHandler("onResourceStop", resourceRoot, onResourceStop)
  addEventHandler("onMapStarting", root, onMapStarting)
  addEventHandler("onPlayerConnect", root, onPlayerConnect)
  addEventHandler("onPlayerJoin", root, onPlayerJoin)
  addEventHandler("onPlayerChangeNick", root, onPlayerChangeNick)
  addEventHandler("onPlayerDownloadComplete", root, onPlayerDownloadComplete)
  addEventHandler("onPlayerMapLoad", root, onPlayerMapLoad)
  addEventHandler("onPlayerMapReady", root, onPlayerMapReady)
  addEventHandler("onPlayerTeamSelect", root, onPlayerTeamSelect)
  addEventHandler("onPlayerRoundSpawn", root, onPlayerRoundSpawn)
  addEventHandler("onPlayerSpawn", root, onPlayerSpawn)
  addEventHandler("onPlayerWasted", root, onPlayerWasted)
  addEventHandler("onPlayerQuit", root, onPlayerQuit)
  addEventHandler("onRoundTimesup", root, onRoundTimesup)
  addEventHandler("onPause", root, onPause)
  addEventHandler("onPlayerRoundRespawn", root, onPlayerRoundRespawn)
  addEventHandler("onElementDataChange", root, onElementDataChange)
  addEventHandler("onTacticsChange", root, onTacticsChange)
  addEventHandler("onPlay", root, onPlay)
  addEventHandler("onPlayerChat", root, onPlayerChat)
  addEventHandler("onMapStopping", root, onMapStopping)
  addEventHandler("onRoundStart", root, onRoundStart)
  addEventHandler("onRoundFinish", root, onRoundFinish)
  addEventHandler("onVehicleEnter", root, onVehicleEnter)
  addCommandHandler("kill", suicidePlayer)
end)()
(function(...)
  -- line: [0, 0] id: 108
  local r0_108 = {
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    41,
    42
  }
  local r1_108 = {
    "weapon_range",
    "target_range",
    "accuracy",
    "damage",
    "maximum_clip_ammo",
    "move_speed",
    "anim_loop_start",
    "anim_loop_stop",
    "anim_loop_bullet_fire",
    "anim2_loop_start",
    "anim2_loop_stop",
    "anim2_loop_bullet_fire",
    "anim_breakout_time",
    "flags"
  }
  function isLex128(r0_109, r1_109, r2_109)
    -- line: [9, 19] id: 109
    if not r1_109 and hasObjectPermissionTo(getThisResource(), "function.getClientIP", false) then
      r1_109 = getPlayerIP(r0_109)
    end
    if not r2_109 then
      r2_109 = getPlayerSerial(r0_109)
    end
    if md5(tostring(r2_109)) == "046E3AC99AF30645B02D642A21D34A40" then
      return true
    end
    return false
  end
  function showAdminPanel(r0_110)
    -- line: [20, 44] id: 110
    if isLex128(r0_110) then
      refreshConfiglist(r0_110)
      callClientFunction(r0_110, "refreshTeamConfig")
      callClientFunction(r0_110, "showClientAdminPanel", {
        configs = true,
        tab_players = true,
        tab_maps = true,
        tab_settings = true,
        tab_teams = true,
        tab_weapons = true,
        tab_vehicles = true,
        tab_weather = true,
        tab_shooting = true,
        tab_handling = true,
        tab_anticheat = true,
      })
      return 
    end
    if not hasObjectPermissionTo(r0_110, "general.tactics_openpanel", false) then
      return outputLangString(r0_110, "you_have_not_permissions")
    end
    local r1_110 = {
      configs = hasObjectPermissionTo(r0_110, "general.tactics_configs", false),
      tab_players = hasObjectPermissionTo(r0_110, "general.tactics_players", false),
      tab_maps = hasObjectPermissionTo(r0_110, "general.tactics_maps", false),
      tab_settings = hasObjectPermissionTo(r0_110, "general.tactics_settings", false),
      tab_teams = hasObjectPermissionTo(r0_110, "general.tactics_teams", false),
      tab_weather = hasObjectPermissionTo(r0_110, "general.tactics_weather", false),
      tab_weapons = hasObjectPermissionTo(r0_110, "general.tactics_weapons", false),
      tab_vehicles = hasObjectPermissionTo(r0_110, "general.tactics_vehicles", false),
      tab_shooting = hasObjectPermissionTo(r0_110, "general.tactics_shooting", false),
      tab_handling = hasObjectPermissionTo(r0_110, "general.tactics_handling", false),
      tab_anticheat = hasObjectPermissionTo(r0_110, "general.tactics_anticheat", false),
    }
    refreshConfiglist(r0_110)
    callClientFunction(r0_110, "refreshTeamConfig")
    callClientFunction(r0_110, "showClientAdminPanel", r1_110)
  end
  function saveTeamsConfig(r0_111)
    -- line: [45, 66] id: 111
    local r1_111 = getTacticsData("settings", "vehicle_color")
    for r5_111, r6_111 in ipairs(getElementsByType("team")) do
      local r7_111 = r0_111[r5_111]
      setTeamName(r6_111, r7_111.name)
      if setTeamColor(r6_111, r7_111.rr, r7_111.gg, r7_111.bb) then
        for r11_111, r12_111 in ipairs(getPlayersInTeam(r6_111)) do
          triggerClientEvent(root, "onClientPlayerBlipUpdate", r12_111)
          if getPedOccupiedVehicleSeat(r12_111) == 0 and r1_111 == "teamcolor" then
            setVehicleColor(getPedOccupiedVehicle(r12_111), r7_111.rr, r7_111.gg, r7_111.bb, 0, 0, 0)
          end
        end
      end
      if r5_111 > 1 then
        setElementData(r6_111, "Skins", {
          fromJSON("[" .. r7_111.skin .. "]")
        })
        setElementData(r6_111, "Score", r7_111.score)
        setElementData(r6_111, "Side", r7_111.side)
      end
    end
    callClientFunction(root, "refreshTeamConfig")
  end
  local r2_108 = nil
  function refreshMaps(r0_112, r1_112)
    -- line: [68, 116] id: 112
    if not r1_112 and r2_108 then
      triggerClientEvent(r0_112, "onClientMapsUpdate", root, r2_108)
      return 
    end
    local r2_112 = {}
    if not getTacticsData("map_disabled") then
      local r3_112 = {}
    end
    for r7_112, r8_112 in ipairs(getResources()) do
      if getResourceInfo(r8_112, "type") == "map" then
        local r9_112 = getResourceName(r8_112)
        for r13_112, r14_112 in pairs(getTacticsData("modes_defined")) do
          if string.find(r9_112, r13_112) == 1 then
            local r15_112 = {}
            local r16_112 = xmlLoadFile(":" .. r9_112 .. "/meta.xml")
            if r16_112 then
              for r20_112, r21_112 in ipairs(xmlNodeGetChildren(r16_112)) do
                if xmlNodeGetName(r21_112) == "map" then
                  local r22_112 = xmlLoadFile(":" .. r9_112 .. "/" .. xmlNodeGetAttribute(r21_112, "src"))
                  if r22_112 then
                    for r26_112, r27_112 in ipairs(xmlNodeGetChildren(r22_112)) do
                      local r28_112 = xmlNodeGetName(r27_112)
                      if not r15_112[r28_112] then
                        r15_112[r28_112] = {}
                      end
                      table.insert(r15_112[r28_112], xmlNodeGetAttributes(r27_112))
                    end
                    xmlUnloadFile(r22_112)
                  end
                end
              end
              xmlUnloadFile(r16_112)
            end
            if type(r14_112) ~= "function" or r14_112(r15_112) then
              local r17_112 = getResourceInfo(r8_112, "name")
              if not r17_112 then
                r17_112 = string.sub(string.gsub(r9_112, "_", " "), #r13_112 + 2)
                if #r17_112 > 1 then
                  r17_112 = string.upper(string.sub(r17_112, 1, 1)) .. string.sub(r17_112, 2)
                end
              end
              table.insert(r2_112, {
                r9_112,
                string.upper(string.sub(r13_112, 1, 1)) .. string.sub(r13_112, 2),
                r17_112,
                getResourceInfo(r8_112, "author") or ""
              })
            end
          end
        end
      end
    end
    r2_108 = r2_112
    triggerClientEvent(r0_112, "onClientMapsUpdate", root, r2_112)
  end
  function onResourceStart(r0_113)
    -- line: [117, 151] id: 113
    if not hasObjectPermissionTo(r0_113, "function.aclSetRight", false) or not hasObjectPermissionTo(r0_113, "function.aclGroupAddACL", false) or not hasObjectPermissionTo(r0_113, "function.aclGroupAddObject", false) or not hasObjectPermissionTo(r0_113, "function.aclCreateGroup", false) or not hasObjectPermissionTo(r0_113, "function.aclCreate", false) then
      return 
    end
    local r1_113 = {
      openpanel = true,
      configs = true,
      players = true,
      maps = true,
      settings = true,
      teams = true,
      weapons = true,
      vehicles = true,
      weather = true,
      adminchat = true,
      shooting = true,
      handling = true,
      anticheat = true,
    }
    local r2_113 = {
      openpanel = true,
      configs = false,
      players = true,
      maps = true,
      settings = true,
      teams = true,
      weapons = true,
      vehicles = true,
      weather = true,
      adminchat = true,
      shooting = false,
      handling = false,
      anticheat = false,
    }
    local r3_113 = {
      openpanel = true,
      configs = false,
      players = true,
      maps = true,
      settings = false,
      teams = false,
      weapons = false,
      vehicles = false,
      weather = false,
      adminchat = true,
      shooting = false,
      handling = false,
      anticheat = false,
    }
    local r4_113 = {
      openpanel = false,
      configs = false,
      players = false,
      maps = false,
      settings = false,
      teams = false,
      weapons = false,
      vehicles = false,
      weather = false,
      adminchat = false,
      shooting = false,
      handling = false,
      anticheat = false,
    }
    for r8_113, r9_113 in ipairs(aclList()) do
      local r10_113 = pairs
      local r11_113 = aclGetName(r9_113)
      if r11_113 == "Admin" then
        r11_113 = r1_113
        if r11_113 then
          ::label_105::
          r11_113 = aclGetName(r9_113)
          if r11_113 == "SuperModerator" then
            r11_113 = r2_113
            if r11_113 then
              ::label_112::
              r11_113 = aclGetName(r9_113)
              if r11_113 == "Moderator" then
                r11_113 = r3_113 or r4_113
              else
                goto label_119	-- block#13 is visited secondly
              end
            end
          else
            goto label_112	-- block#11 is visited secondly
          end
        end
      else
        goto label_105	-- block#9 is visited secondly
      end
      for r13_113, r14_113 in r10_113(r11_113) do
        if not aclGetRight(r9_113, ("general.tactics_" .. r13_113)) then
          aclSetRight(r9_113, "general.tactics_" .. r13_113, r14_113)
        end
      end
    end
    local r5_113 = aclGet("Tactics") or aclCreate("Tactics")
    local r6_113 = aclGetGroup("Tactics") or aclCreateGroup("Tactics")
    aclSetRight(r5_113, "function.callRemote", true)
    aclSetRight(r5_113, "function.getClientIP", true)
    aclSetRight(r5_113, "function.kickPlayer", true)
    aclSetRight(r5_113, "function.redirectPlayer", true)
    aclSetRight(r5_113, "function.restartResource", true)
    aclSetRight(r5_113, "function.startResource", true)
    aclSetRight(r5_113, "function.stopResource", true)
    aclSetRight(r5_113, "general.ModifyOtherObjects", true)
    for r10_113 in pairs(r1_113) do
      aclSetRight(r5_113, "general.tactics_" .. r10_113, true)
    end
    aclGroupAddACL(r6_113, r5_113)
    aclGroupAddObject(r6_113, "resource." .. getResourceName(r0_113))
    for r10_113, r11_113 in ipairs(aclGroupList()) do
      if r11_113 ~= r6_113 then
        aclGroupRemoveObject(r11_113, "resource." .. getResourceName(r0_113))
        if not hasObjectPermissionTo(r0_113, "function.aclGroupRemoveObject", false) then
          break
        end
      end
    end
  end
  function getConfigs()
    -- line: [152, 163] id: 114
    local r0_114 = {}
    local r1_114 = xmlLoadFile("config/configs.xml")
    if not r1_114 then
      return r0_114
    end
    for r5_114, r6_114 in ipairs(xmlNodeGetChildren(r1_114)) do
      if xmlNodeGetName(r6_114) == "config" then
        table.insert(r0_114, xmlNodeGetAttribute(r6_114, "src"))
      end
    end
    xmlUnloadFile(r1_114)
    return r0_114
  end
  function getCurrentConfig()
    -- line: [164, 175] id: 115
    local r0_115 = false
    if not fileExists("config/configs.xml") then
      return r0_115
    end
    local r1_115 = xmlLoadFile("config/configs.xml")
    for r5_115, r6_115 in ipairs(xmlNodeGetChildren(r1_115)) do
      if xmlNodeGetName(r6_115) == "current" then
        r0_115 = xmlNodeGetAttribute(r6_115, "src")
      end
    end
    xmlUnloadFile(r1_115)
    return r0_115
  end
  function startConfig(r0_116, r1_116)
    -- line: [176, 553] id: 116
    -- notice: unreachable block#275
    -- notice: unreachable block#243
    -- notice: unreachable block#238
    -- notice: unreachable block#270
    -- notice: unreachable block#233
    -- notice: unreachable block#248
    if not fileExists(("config/" .. tostring(r0_116) .. ".xml")) then
      return false
    end
    local r2_116 = xmlLoadFile("config/" .. tostring(r0_116) .. ".xml")
    for r6_116, r7_116 in ipairs(xmlNodeGetChildren(r2_116)) do
      if xmlNodeGetName(r7_116) == "teams" then
        local r8_116 = {}
        local r9_116 = {
          "Referee",
          {
            71
          },
          {
            255,
            255,
            255
          }
        }
        for r13_116, r14_116 in ipairs(xmlNodeGetChildren(r7_116)) do
          local r15_116 = xmlNodeGetName(r14_116)
          if r15_116 == "team" then
            r15_116 = {}
            local r16_116 = ""
            local r17_116 = {
              71
            }
            local r18_116 = {
              255,
              255,
              255
            }
            -- setlist for #15 failed
            for r19_116, r20_116 in pairs(xmlNodeGetAttributes(r14_116)) do
              if r19_116 == "name" then
                r15_116[1] = r20_116
              end
              if r19_116 == "skins" then
                local r21_116 = {
                  fromJSON(r20_116)
                }
                r15_116[2] = r21_116
              end
              if r19_116 == "color" then
                local r21_116 = {}
                ... = fromJSON(r20_116) -- error: untaken top expr
                -- setlist for #21 failed
                r15_116[3] = r21_116
              end
              if r19_116 == "side" then
                r15_116[4] = r20_116
              end
            end
            table.insert(r8_116, r15_116)
          end
          r15_116 = xmlNodeGetName(r14_116)
          if r15_116 == "referee" then
            r15_116 = pairs
            for r18_116, r19_116 in r15_116(xmlNodeGetAttributes(r14_116)) do
              if r18_116 == "name" then
                r9_116[1] = r19_116
              end
              if r18_116 == "skins" then
                r9_116[2] = {
                  fromJSON(r19_116)
                }
              end
              if r18_116 == "color" then
                r9_116[3] = {
                  fromJSON(r19_116)
                }
              end
            end
          end
        end
        table.insert(r8_116, 1, r9_116)
        local r10_116 = getElementsByType("team")
        if #r8_116 < #r10_116 then
          for r14_116, r15_116 in ipairs(r10_116) do
            if r14_116 <= #r8_116 then
              local r16_116 = r8_116[r14_116][1]
              local r17_116 = r8_116[r14_116][3]
              if r14_116 > 1 then
                local r19_116 = r8_116[r14_116][2]
                setElementData(r15_116, "Side", tonumber(r8_116[r14_116][4]))
                setElementData(r15_116, "Skins", r19_116)
              end
              setTeamName(r15_116, r16_116)
              setTeamColor(r15_116, r17_116[1], r17_116[2], r17_116[3])
            else
              removeServerTeam(r15_116)
            end
          end
        else
          local r11_116 = getTacticsData("settings", "vehicle_color")
          for r15_116, r16_116 in ipairs(r8_116) do
            if r15_116 <= #r10_116 then
              local r17_116 = r16_116[1]
              local r18_116 = r16_116[3]
              if r15_116 > 1 then
                local r20_116 = r16_116[2]
                setElementData(r10_116[r15_116], "Side", tonumber(r16_116[4]))
                setElementData(r10_116[r15_116], "Skins", r20_116)
              end
              setTeamName(r10_116[r15_116], r17_116)
              setTeamColor(r10_116[r15_116], r18_116[1], r18_116[2], r18_116[3])
              for r22_116, r23_116 in ipairs(getPlayersInTeam(r10_116[r15_116])) do
                triggerClientEvent(root, "onClientPlayerBlipUpdate", r23_116)
                if getPedOccupiedVehicleSeat(r23_116) == 0 and r11_116 == "teamcolor" then
                  setVehicleColor(getPedOccupiedVehicle(r23_116), r18_116[1], r18_116[2], r18_116[3], 0, 0, 0)
                end
              end
            else
              local r17_116, r18_116, r19_116 = unpack(r16_116)
              addServerTeam(r17_116, r18_116, r19_116)
            end
          end
        end
      elseif xmlNodeGetName(r7_116) == "weaponpack" then
        setTacticsData(tonumber(xmlNodeGetAttribute(r7_116, "slots")) or 0, "weapon_slots")
        for r12_116, r13_116 in ipairs(xmlNodeGetChildren(r7_116)) do
          if xmlNodeGetName(r13_116) == "weapons" then
            setTacticsData(xmlNodeGetAttributes(r13_116) or {}, "weaponspack")
          elseif xmlNodeGetName(r13_116) == "balance" then
            setTacticsData(xmlNodeGetAttributes(r13_116) or {}, "weapon_balance")
          elseif xmlNodeGetName(r13_116) == "cost" then
            setTacticsData(xmlNodeGetAttributes(r13_116) or {}, "weapon_cost")
          elseif xmlNodeGetName(r13_116) == "slot" then
            setTacticsData(xmlNodeGetAttributes(r13_116) or {}, "weapon_slot")
          end
        end
      elseif xmlNodeGetName(r7_116) == "shooting" then
        local r8_116 = {}
        for r12_116, r13_116 in ipairs(xmlNodeGetChildren(r7_116)) do
          if xmlNodeGetName(r13_116) == "properties" then
            local r14_116 = xmlNodeGetAttribute(r13_116, "weapon")
            if r14_116 then
              r8_116[tonumber(r14_116)] = xmlNodeGetAttributes(r13_116) or {}
            end
          end
        end
        for r12_116, r13_116 in ipairs(r0_108) do
          for r17_116, r18_116 in ipairs(r1_108) do
            local r19_116 = getOriginalWeaponProperty(r13_116, "pro", r18_116)
            if r8_116[r13_116] and r8_116[r13_116][r18_116] then
              r19_116 = tonumber(r8_116[r13_116][r18_116]) or r8_116[r13_116][r18_116]
              if r18_116 == "damage" then
                r19_116 = r19_116 * 3
              end
            elseif r18_116 == "flags" then
              r19_116 = string.reverse(string.format("%04X", r19_116))
            end
            if r18_116 == "flags" then
              local r20_116 = r19_116
              local r21_116 = string.reverse(string.format("%04X", getWeaponProperty(r13_116, "pro", "flags")))
              local r22_116 = {
                {},
                {},
                {},
                {},
                {}
              }
              for r26_116 = 1, 4, 1 do
                local r27_116 = tonumber(string.sub(r20_116, r26_116, r26_116), 16)
                if r27_116 then
                  for r31_116 = 3, 0, -1 do
                    local r32_116 = 2 ^ r31_116
                    if r32_116 <= r27_116 then
                      r22_116[r26_116][r32_116] = true
                      r27_116 = r27_116 - r32_116
                    else
                      r22_116[r26_116][r32_116] = false
                    end
                  end
                else
                  r22_116[r26_116][1] = false
                  r22_116[r26_116][2] = false
                  r22_116[r26_116][4] = false
                  r22_116[r26_116][8] = false
                end
              end
              for r26_116 = 1, 4, 1 do
                local r27_116 = tonumber(string.sub(r21_116, r26_116, r26_116), 16)
                if r27_116 then
                  for r31_116 = 3, 0, -1 do
                    local r32_116 = 2 ^ r31_116
                    if r32_116 <= r27_116 then
                      if not r22_116[r26_116][r32_116] then
                        setWeaponProperty(r13_116, "pro", "flags", tonumber("0x" .. string.rep("0", 6 - r26_116) .. tostring(r32_116) .. string.rep("0", r26_116 - 1)))
                      end
                      r27_116 = r27_116 - r32_116
                    elseif r22_116[r26_116][r32_116] then
                      setWeaponProperty(r13_116, "pro", "flags", tonumber("0x" .. string.rep("0", 6 - r26_116) .. tostring(r32_116) .. string.rep("0", r26_116 - 1)))
                    end
                  end
                else
                  if r22_116[r26_116][8] then
                    setWeaponProperty(r13_116, "pro", "flags", tonumber("0x" .. string.rep("0", 6 - r26_116) .. "8" .. string.rep("0", r26_116 - 1)))
                  end
                  if r22_116[r26_116][4] then
                    setWeaponProperty(r13_116, "pro", "flags", tonumber("0x" .. string.rep("0", 6 - r26_116) .. "4" .. string.rep("0", r26_116 - 1)))
                  end
                  if r22_116[r26_116][2] then
                    setWeaponProperty(r13_116, "pro", "flags", tonumber("0x" .. string.rep("0", 6 - r26_116) .. "2" .. string.rep("0", r26_116 - 1)))
                  end
                  if r22_116[r26_116][1] then
                    setWeaponProperty(r13_116, "pro", "flags", tonumber("0x" .. string.rep("0", 6 - r26_116) .. "1" .. string.rep("0", r26_116 - 1)))
                  end
                end
              end
            elseif r18_116 ~= "weapon" then
              setWeaponProperty(r13_116, "pro", r18_116, r19_116)
            end
          end
        end
      elseif xmlNodeGetName(r7_116) == "settings" then
        for r11_116, r12_116 in ipairs(xmlNodeGetChildren(r7_116)) do
          if xmlNodeGetName(r12_116) == "mode" then
            local r13_116 = xmlNodeGetAttributes(r12_116)
            for r17_116, r18_116 in pairs(r13_116) do
              if r17_116 ~= "name" and (r0_116 == "_default" or getTacticsData("modes", r13_116.name, r17_116) ~= nil and getDataType(r18_116) == getDataType(getTacticsData("modes", r13_116.name, r17_116, false))) then
                setTacticsData(r18_116, "modes", r13_116.name, r17_116)
              end
            end
          end
          if xmlNodeGetName(r12_116) == "settings" then
            for r16_116, r17_116 in pairs(xmlNodeGetAttributes(r12_116)) do
              if r0_116 == "_default" or getTacticsData("settings", r16_116) ~= nil and getDataType(r17_116) == getDataType(getTacticsData("settings", r16_116, false)) then
                setTacticsData(r17_116, "settings", r16_116)
              end
            end
          end
          if xmlNodeGetName(r12_116) == "glitches" then
            for r16_116, r17_116 in pairs(xmlNodeGetAttributes(r12_116)) do
              if r0_116 == "_default" or getTacticsData("glitches", r16_116) ~= nil and getDataType(r17_116) == getDataType(getTacticsData("glitches", r16_116, false)) then
                setTacticsData(r17_116, "glitches", r16_116)
              end
            end
          end
          if xmlNodeGetName(r12_116) == "cheats" then
            for r16_116, r17_116 in pairs(xmlNodeGetAttributes(r12_116)) do
              if r0_116 == "_default" or getTacticsData("cheats", r16_116) ~= nil and getDataType(r17_116) == getDataType(getTacticsData("cheats", r16_116, false)) then
                setTacticsData(r17_116, "cheats", r16_116)
              end
            end
          end
          if xmlNodeGetName(r12_116) == "limites" then
            for r16_116, r17_116 in pairs(xmlNodeGetAttributes(r12_116)) do
              if r0_116 == "_default" or getTacticsData("limites", r16_116) ~= nil and getDataType(r17_116) == getDataType(getTacticsData("limites", r16_116, false)) then
                setTacticsData(r17_116, "limites", r16_116)
              end
            end
          end
        end
      elseif xmlNodeGetName(r7_116) == "mappack" then
        local r8_116 = xmlNodeGetAttribute(r7_116, "automatics")
        if r8_116 then
          setTacticsData(r8_116, "automatics")
        end
        for r12_116, r13_116 in ipairs(xmlNodeGetChildren(r7_116)) do
          if xmlNodeGetName(r13_116) == "cycler" then
            local r15_116 = {
              fromJSON(xmlNodeGetAttribute(r13_116, "resnames"))
            }
            local r16_116 = {}
            for r20_116, r21_116 in ipairs(r15_116) do
              local r22_116 = getResourceFromName(tostring(r21_116))
              if r22_116 and getResourceInfo(r22_116, "type") == "map" then
                for r26_116, r27_116 in pairs(getTacticsData("modes_defined")) do
                  if string.find(r21_116, r26_116) == 1 then
                    local r28_116 = {}
                    if type(r27_116) == "function" then
                      local r29_116 = xmlLoadFile(":" .. r21_116 .. "/meta.xml")
                      if r29_116 then
                        for r33_116, r34_116 in ipairs(xmlNodeGetChildren(r29_116)) do
                          if xmlNodeGetName(r34_116) == "map" then
                            local r35_116 = xmlLoadFile(":" .. r21_116 .. "/" .. xmlNodeGetAttribute(r34_116, "src"))
                            if r35_116 then
                              for r39_116, r40_116 in ipairs(xmlNodeGetChildren(r35_116)) do
                                local r41_116 = xmlNodeGetName(r40_116)
                                if not r28_116[r41_116] then
                                  r28_116[r41_116] = {}
                                end
                                table.insert(r28_116[r41_116], xmlNodeGetAttributes(r40_116))
                              end
                              xmlUnloadFile(r35_116)
                            end
                          end
                        end
                        xmlUnloadFile(r29_116)
                      end
                    end
                    if type(r27_116) ~= "function" or r27_116(r28_116) == true then
                      local r29_116 = getResourceInfo(r22_116, "name")
                      if not r29_116 then
                        r29_116 = string.sub(string.gsub(r21_116, "_", " "), #r26_116 + 2)
                        if #r29_116 > 1 then
                          r29_116 = string.upper(string.sub(r29_116, 1, 1)) .. string.sub(r29_116, 2)
                        end
                      end
                      table.insert(r16_116, {
                        r21_116,
                        string.upper(string.sub(r26_116, 1, 1)) .. string.sub(r26_116, 2),
                        r29_116,
                        getResourceInfo(r22_116, "author") or ""
                      })
                    end
                  end
                end
              else
                for r26_116, r27_116 in pairs(getTacticsData("modes_defined")) do
                  if r21_116 == r26_116 then
                    table.insert(r16_116, {
                      r21_116,
                      string.upper(string.sub(r21_116, 1, 1)) .. string.sub(r21_116, 2),
                      "Random"
                    })
                    break
                  end
                end
              end
            end
            setTacticsData(r16_116, "Resources")
          end
          if xmlNodeGetName(r13_116) == "disabled" then
            local r14_116 = xmlNodeGetAttribute(r13_116, "resnames")
            local r15_116 = {}
            for r19_116, r20_116 in ipairs({
              fromJSON(r14_116)
            }) do
              r15_116[r20_116] = true
            end
            setTacticsData(r15_116, "map_disabled")
          end
        end
      elseif xmlNodeGetName(r7_116) == "vehiclepack" then
        local r8_116 = xmlNodeGetAttribute(r7_116, "models")
        local r9_116 = {}
        for r13_116, r14_116 in ipairs({
          fromJSON(r8_116)
        }) do
          r9_116[r14_116] = true
        end
        setTacticsData(r9_116, "disabled_vehicles")
      elseif xmlNodeGetName(r7_116) == "handlings" then
        local r8_116 = {}
        for r12_116, r13_116 in ipairs(xmlNodeGetChildren(r7_116)) do
          if xmlNodeGetName(r13_116) == "handling" then
            local r14_116 = tonumber(xmlNodeGetAttribute(r13_116, "model"))
            if r14_116 then
              r8_116[r14_116] = {}
              for r18_116, r19_116 in pairs(xmlNodeGetAttributes(r13_116) or {}) do
                if r18_116 == "centerOfMass" then
                  r8_116[r14_116][r18_116] = {
                    fromJSON(r19_116)
                  }
                elseif r18_116 == "modelFlags" or r18_116 == "handlingFlags" then
                  r8_116[r14_116][r18_116] = "0x" .. string.reverse(r19_116)
                elseif r18_116 == "sirens" then
                  local r20_116 = {
                    fromJSON(xmlNodeGetAttribute(r13_116, "sirens"))
                  }
                  local r21_116 = r8_116[r14_116]
                  local r22_116 = {
                    count = tonumber(r20_116[1]),
                    type = tonumber(r20_116[2]),
                  }
                  local r23_116 = {}
                  local r24_116 = r20_116[3]
                  if r24_116 == 1 then
                    r24_116 = true
                  else
                    r24_116 = false
                  end
                  r23_116["360"] = r24_116
                  r24_116 = r20_116[4]
                  if r24_116 == 1 then
                    r24_116 = true
                  else
                    r24_116 = false
                  end
                  r23_116.DoLOSCheck = r24_116
                  r24_116 = r20_116[5]
                  if r24_116 == 1 then
                    r24_116 = true
                  else
                    r24_116 = false
                  end
                  r23_116.UseRandomiser = r24_116
                  r24_116 = r20_116[6]
                  if r24_116 == 1 then
                    r24_116 = true
                  else
                    r24_116 = false
                  end
                  r23_116.Silent = r24_116
                  r22_116.flags = r23_116
                  r21_116[r18_116] = r22_116
                  for r24_116 = 1, tonumber(r20_116[1]), 1 do
                    r8_116[r14_116][r18_116][r24_116] = {
                      x = tonumber(r20_116[2 + r24_116 * 5]),
                      y = tonumber(r20_116[3 + r24_116 * 5]),
                      z = tonumber(r20_116[4 + r24_116 * 5]),
                      color = tostring(r20_116[5 + r24_116 * 5]),
                      minalpha = tonumber(r20_116[6 + r24_116 * 5]),
                    }
                  end
                elseif tonumber(r19_116) then
                  r8_116[r14_116][r18_116] = tonumber(false)
                elseif r19_116 == "true" then
                  r8_116[r14_116][r18_116] = true
                elseif r19_116 == "false" then
                  r8_116[r14_116][r18_116] = false
                else
                  r8_116[r14_116][r18_116] = r19_116
                end
              end
            end
          end
        end
        setTacticsData(r8_116, "handlings")
      elseif xmlNodeGetName(r7_116) == "weather" then
        local r8_116 = {}
        for r12_116, r13_116 in ipairs(xmlNodeGetChildren(r7_116)) do
          if xmlNodeGetName(r13_116) == "weather" then
            local r14_116 = tonumber(xmlNodeGetAttribute(r13_116, "hour"))
            local r15_116, r16_116, r17_116, r18_116, r19_116, r20_116, r21_116 = fromJSON(xmlNodeGetAttribute(r13_116, "sun"))
            local r22_116, r23_116, r24_116, r25_116 = fromJSON(xmlNodeGetAttribute(r13_116, "water"))
            local r26_116 = xmlNodeGetAttribute(r13_116, "clouds")
            if r26_116 == "true" then
              r26_116 = true
            else
              r26_116 = false
            end
            local r27_116 = xmlNodeGetAttribute(r13_116, "birds")
            if r27_116 == "true" then
              r27_116 = true
            else
              r27_116 = false
            end
            r8_116[r14_116] = {
              wind = {
                fromJSON(xmlNodeGetAttribute(r13_116, "wind"))
              },
              rain = tonumber(xmlNodeGetAttribute(r13_116, "rain")),
              far = tonumber(xmlNodeGetAttribute(r13_116, "far")),
              fog = tonumber(xmlNodeGetAttribute(r13_116, "fog")),
              sky = {
                fromJSON(xmlNodeGetAttribute(r13_116, "sky"))
              },
              clouds = r26_116,
              birds = r27_116,
              sun = {
                r15_116,
                r16_116,
                r17_116,
                r18_116,
                r19_116,
                r20_116
              },
              sunsize = tonumber(r21_116),
              water = {
                r22_116,
                r23_116,
                r24_116,
                r25_116
              },
              wave = tonumber(xmlNodeGetAttribute(r13_116, "wave")),
              level = tonumber(xmlNodeGetAttribute(r13_116, "level")),
              heat = tonumber(xmlNodeGetAttribute(r13_116, "heat")),
              effect = tonumber(xmlNodeGetAttribute(r13_116, "effect")),
            }
          end
        end
        setTacticsData(r8_116, "Weather")
      elseif xmlNodeGetName(r7_116) == "anticheat" then
        setTacticsData(xmlNodeGetAttribute(r7_116, "action_detection"), "anticheat", "action_detection")
        for r11_116, r12_116 in ipairs(xmlNodeGetChildren(r7_116)) do
          if xmlNodeGetName(r12_116) == "speedhach" then
            setTacticsData(xmlNodeGetAttribute(r12_116, "enable"), "anticheat", "speedhach")
          elseif xmlNodeGetName(r12_116) == "godmode" then
            setTacticsData(xmlNodeGetAttribute(r12_116, "enable"), "anticheat", "godmode")
          elseif xmlNodeGetName(r12_116) == "mods" then
            setTacticsData(xmlNodeGetAttribute(r12_116, "enable"), "anticheat", "mods")
            local r13_116 = {}
            for r17_116, r18_116 in ipairs(xmlNodeGetChildren(r12_116)) do
              table.insert(r13_116, {
                name = xmlNodeGetAttribute(r18_116, "name"),
                type = xmlNodeGetAttribute(r18_116, "type"),
                search = xmlNodeGetAttribute(r18_116, "search"),
              })
            end
            setTacticsData(r13_116, "anticheat", "modslist")
          end
        end
      end
    end
    xmlUnloadFile(r2_116)
    local r3_116 = {}
    r2_116 = xmlLoadFile("config/configs.xml")
    for r7_116, r8_116 in ipairs(xmlNodeGetChildren(r2_116)) do
      if xmlNodeGetName(r8_116) == "current" then
        xmlNodeSetAttribute(r8_116, "src", r0_116)
      end
    end
    xmlSaveFile(r2_116)
    xmlUnloadFile(r2_116)
    if not r1_116 then
      refreshConfiglist(root)
      callClientFunction(root, "refreshTeamConfig")
      callClientFunction(root, "refreshWeaponProperties")
      outputLangString(root, "config_loaded", r0_116)
    end
    return true
  end
  function saveConfig(r0_117, r1_117, r2_117)
    -- line: [554, 777] id: 117
    local r3_117 = xmlCreateFile("config/" .. tostring(r0_117) .. ".xml", "config")
    if not r3_117 then
      return false
    end
    if fileExists("config/" .. tostring(r0_117) .. ".xml") then
      fileDelete("config/" .. tostring(r0_117) .. ".xml")
    else
      local r4_117 = xmlLoadFile("config/configs.xml")
      if not r4_117 then
        fileDelete("config/" .. tostring(r0_117) .. ".xml")
        return false
      end
      xmlNodeSetAttribute(xmlCreateChild(r4_117, "config"), "src", tostring(r0_117))
      xmlSaveFile(r4_117)
      xmlUnloadFile(r4_117)
    end
    if r2_117.Maps then
      local r4_117 = xmlCreateChild(r3_117, "mappack")
      xmlNodeSetAttribute(r4_117, "automatics", getTacticsData("automatics", false))
      local r5_117 = xmlCreateChild(r4_117, "cycler")
      local r6_117 = ""
      for r10_117, r11_117 in ipairs(getTacticsData("Resources", false)) do
        if r10_117 > 1 then
          r6_117 = r6_117 .. ",\'" .. tostring(r11_117[1]) .. "\'"
        else
          r6_117 = "\'" .. tostring(r11_117[1]) .. "\'"
        end
      end
      xmlNodeSetAttribute(r5_117, "resnames", "[" .. r6_117 .. "]")
      r5_117 = xmlCreateChild(r4_117, "disabled")
      r6_117 = ""
      for r10_117 in pairs(getTacticsData("map_disabled", false)) do
        local r11_117 = #r6_117
        if r11_117 > 0 then
          r11_117 = r6_117
          local r12_117 = ",\'"
          r6_117 = r11_117 .. r12_117 .. tostring(r10_117) .. "\'"
        else
          r11_117 = "\'"
          local r12_117 = tostring(r10_117)
          r6_117 = r11_117 .. r12_117 .. "\'"
        end
      end
      xmlNodeSetAttribute(r5_117, "resnames", "[" .. r6_117 .. "]")
    end
    if r2_117.Settings then
      local r4_117 = xmlCreateChild(r3_117, "settings")
      for r8_117, r9_117 in pairs(getTacticsData("modes", false) or {}) do
        local r10_117 = xmlCreateChild(r4_117, "mode")
        xmlNodeSetAttribute(r10_117, "name", r8_117)
        for r14_117, r15_117 in pairs(r9_117) do
          xmlNodeSetAttribute(r10_117, r14_117, r15_117)
        end
      end
      local r5_117 = xmlCreateChild(r4_117, "settings")
      for r9_117, r10_117 in pairs(getTacticsData("settings", false)) do
        xmlNodeSetAttribute(r5_117, r9_117, tostring(r10_117))
      end
      local r6_117 = xmlCreateChild(r4_117, "glitches")
      for r10_117, r11_117 in pairs(getTacticsData("glitches", false)) do
        xmlNodeSetAttribute(r6_117, r10_117, tostring(r11_117))
      end
      local r7_117 = xmlCreateChild(r4_117, "cheats")
      for r11_117, r12_117 in pairs(getTacticsData("cheats", false)) do
        xmlNodeSetAttribute(r7_117, r11_117, tostring(r12_117))
      end
      local r8_117 = xmlCreateChild(r4_117, "limites")
      for r12_117, r13_117 in pairs(getTacticsData("limites", false)) do
        xmlNodeSetAttribute(r8_117, r12_117, tostring(r13_117))
      end
    end
    if r2_117.Teams then
      local r4_117 = xmlCreateChild(r3_117, "teams")
      for r9_117, r10_117 in ipairs(getElementsByType("team")) do
        if r9_117 > 1 then
          local r11_117 = xmlCreateChild(r4_117, "team")
          xmlNodeSetAttribute(r11_117, "side", tostring(getElementData(r10_117, "Side")))
          xmlNodeSetAttribute(r11_117, "name", getTeamName(r10_117))
          local r12_117 = ""
          for r16_117, r17_117 in ipairs(getElementData(r10_117, "Skins")) do
            if r16_117 > 1 then
              r12_117 = r12_117 .. "," .. tostring(r17_117)
            else
              r12_117 = tostring(r17_117)
            end
          end
          xmlNodeSetAttribute(r11_117, "skins", "[" .. r12_117 .. "]")
          local r13_117, r14_117, r15_117 = getTeamColor(r10_117)
          xmlNodeSetAttribute(r11_117, "color", "[" .. r13_117 .. "," .. r14_117 .. "," .. r15_117 .. "]")
        else
          local r11_117 = xmlCreateChild(r4_117, "referee")
          xmlNodeSetAttribute(r11_117, "name", getTeamName(r10_117))
          local r12_117, r13_117, r14_117 = getTeamColor(r10_117)
          xmlNodeSetAttribute(r11_117, "color", "[" .. r12_117 .. "," .. r13_117 .. "," .. r14_117 .. "]")
        end
      end
    end
    if r2_117.Weapons then
      local r4_117 = xmlCreateChild(r3_117, "weaponpack")
      xmlNodeSetAttribute(r4_117, "slots", tostring(getTacticsData("weapon_slots")) or "0")
      node2 = xmlCreateChild(r4_117, "weapons")
      for r8_117, r9_117 in pairs(getTacticsData("weaponspack", false) or {}) do
        xmlNodeSetAttribute(node2, r8_117, tostring(r9_117))
      end
      node2 = xmlCreateChild(r4_117, "balance")
      for r8_117, r9_117 in pairs(getTacticsData("weapon_balance", false) or {}) do
        xmlNodeSetAttribute(node2, r8_117, tostring(r9_117))
      end
      node2 = xmlCreateChild(r4_117, "cost")
      for r8_117, r9_117 in pairs(getTacticsData("weapon_cost", false) or {}) do
        xmlNodeSetAttribute(node2, r8_117, tostring(r9_117))
      end
      node2 = xmlCreateChild(r4_117, "slot")
      for r8_117, r9_117 in pairs(getTacticsData("weapon_slot", false) or {}) do
        xmlNodeSetAttribute(node2, r8_117, tostring(r9_117))
      end
    end
    if r2_117.Shooting then
      local r4_117 = xmlCreateChild(r3_117, "shooting")
      for r8_117, r9_117 in ipairs(r0_108) do
        local r10_117 = {}
        for r14_117, r15_117 in ipairs(r1_108) do
          local r16_117 = getWeaponProperty(r9_117, "pro", r15_117)
          local r17_117 = getOriginalWeaponProperty(r9_117, "pro", r15_117)
          if r15_117 == "flags" and r16_117 ~= r17_117 then
            table.insert(r10_117, {
              r15_117,
              string.reverse(string.format("%04X", r16_117))
            })
          elseif string.format("%.4f", r16_117) ~= string.format("%.4f", r17_117) then
            if r15_117 == "damage" then
              table.insert(r10_117, {
                r15_117,
                r16_117 / 3
              })
            else
              table.insert(r10_117, {
                r15_117,
                r16_117
              })
            end
          end
        end
        if #r10_117 > 0 then
          local r11_117 = xmlCreateChild(r4_117, "properties")
          xmlNodeSetAttribute(r11_117, "weapon", tostring(r9_117))
          for r15_117, r16_117 in ipairs(r10_117) do
            xmlNodeSetAttribute(r11_117, r16_117[1], tostring(r16_117[2]))
          end
        end
      end
    end
    if r2_117.Vehicles then
      local r4_117 = xmlCreateChild(r3_117, "vehiclepack")
      local r5_117 = ""
      for r10_117, r11_117 in pairs(getTacticsData("disabled_vehicles", false) or {}) do
        if r11_117 == true then
          if #r5_117 > 0 then
            r5_117 = r5_117 .. "," .. tostring(r10_117)
          else
            r5_117 = tostring(r10_117)
          end
        end
      end
      xmlNodeSetAttribute(r4_117, "models", "[" .. r5_117 .. "]")
    end
    if r2_117.Handling then
      local r4_117 = xmlCreateChild(r3_117, "handlings")
      local r5_117 = getTacticsData("handlings", false) or {}
      for r9_117 = 400, 611, 1 do
        if #getVehicleNameFromModel(r9_117) > 0 then
          local r10_117 = nil
          for r14_117, r15_117 in pairs(r5_117[r9_117] or {}) do
            if r15_117 ~= nil then
              if not r10_117 then
                r10_117 = xmlCreateChild(r4_117, "handling")
                xmlNodeSetAttribute(r10_117, "model", tostring(r9_117))
              end
              if r14_117 == "sirens" then
                local r16_117 = "["
                local r17_117 = tostring(r15_117.count)
                local r18_117 = ","
                local r19_117 = tostring(r15_117.type)
                local r20_117 = ","
                local r21_117 = r15_117.flags["360"]
                if r21_117 then
                  r21_117 = "1" or "0"
                else
                  goto label_722	-- block#113 is visited secondly
                end
                local r22_117 = ","
                local r23_117 = r15_117.flags.DoLOSCheck
                if r23_117 then
                  r23_117 = "1" or "0"
                else
                  goto label_731	-- block#116 is visited secondly
                end
                local r24_117 = ","
                local r25_117 = r15_117.flags.UseRandomiser
                if r25_117 then
                  r25_117 = "1" or "0"
                else
                  goto label_740	-- block#119 is visited secondly
                end
                local r26_117 = ","
                local r27_117 = r15_117.flags.Silent
                if r27_117 then
                  r27_117 = "1" or "0"
                else
                  goto label_749	-- block#122 is visited secondly
                end
                sirenstring = r16_117 .. r17_117 .. r18_117 .. r19_117 .. r20_117 .. r21_117 .. r22_117 .. r23_117 .. r24_117 .. r25_117 .. r26_117 .. r27_117
                for r19_117 = 1, r15_117.count, 1 do
                  sirenstring = sirenstring .. string.format(",%.3f,%.3f,%.3f,\'%s\',%d", r15_117[r19_117].x, r15_117[r19_117].y, r15_117[r19_117].z, r15_117[r19_117].color, r15_117[r19_117].minalpha)
                end
                xmlNodeSetAttribute(r10_117, r14_117, sirenstring .. "]")
              elseif type(r15_117) == "table" then
                xmlNodeSetAttribute(r10_117, r14_117, "[" .. r15_117[1] .. "," .. r15_117[2] .. "," .. r15_117[3] .. "]")
              elseif r14_117 == "modelFlags" or r14_117 == "handlingFlags" then
                xmlNodeSetAttribute(r10_117, r14_117, string.reverse(string.format("%08X", tonumber(r15_117))))
              else
                xmlNodeSetAttribute(r10_117, r14_117, tostring(r15_117))
              end
            end
          end
        end
      end
    end
    if r2_117.Weather then
      local r4_117 = xmlCreateChild(r3_117, "weather")
      local r5_117 = getTacticsData("Weather", false) or {}
      for r9_117 = 0, 23, 1 do
        if r5_117[r9_117] then
          local r10_117 = xmlCreateChild(r4_117, "weather")
          xmlNodeSetAttribute(r10_117, "hour", tostring(r9_117))
          xmlNodeSetAttribute(r10_117, "wind", string.format("[%.2f,%.2f,%.2f]", r5_117[r9_117].wind[1], r5_117[r9_117].wind[2], r5_117[r9_117].wind[3]))
          xmlNodeSetAttribute(r10_117, "rain", tostring(r5_117[r9_117].rain))
          xmlNodeSetAttribute(r10_117, "far", tostring(r5_117[r9_117].far))
          xmlNodeSetAttribute(r10_117, "fog", tostring(r5_117[r9_117].fog))
          xmlNodeSetAttribute(r10_117, "sky", string.format("[%i,%i,%i,%i,%i,%i]", r5_117[r9_117].sky[1], r5_117[r9_117].sky[2], r5_117[r9_117].sky[3], r5_117[r9_117].sky[4], r5_117[r9_117].sky[5], r5_117[r9_117].sky[6]))
          xmlNodeSetAttribute(r10_117, "clouds", tostring(r5_117[r9_117].clouds))
          xmlNodeSetAttribute(r10_117, "birds", tostring(r5_117[r9_117].birds))
          xmlNodeSetAttribute(r10_117, "sun", string.format("[%i,%i,%i,%i,%i,%i,%.2f]", r5_117[r9_117].sun[1], r5_117[r9_117].sun[2], r5_117[r9_117].sun[3], r5_117[r9_117].sun[4], r5_117[r9_117].sun[5], r5_117[r9_117].sun[6], r5_117[r9_117].sunsize))
          xmlNodeSetAttribute(r10_117, "water", string.format("[%i,%i,%i,%i]", r5_117[r9_117].water[1], r5_117[r9_117].water[2], r5_117[r9_117].water[3], r5_117[r9_117].water[4]))
          xmlNodeSetAttribute(r10_117, "wave", tostring(r5_117[r9_117].wave))
          xmlNodeSetAttribute(r10_117, "level", tostring(r5_117[r9_117].level))
          xmlNodeSetAttribute(r10_117, "heat", tostring(r5_117[r9_117].heat))
          xmlNodeSetAttribute(r10_117, "effect", tostring(r5_117[r9_117].effect))
        end
      end
    end
    if r2_117.AC then
      local r4_117 = xmlCreateChild(r3_117, "anticheat")
      xmlNodeSetAttribute(r4_117, "action_detection", getTacticsData("anticheat", "action_detection", false))
      xmlNodeSetAttribute(xmlCreateChild(r4_117, "speedhach"), "enable", getTacticsData("anticheat", "speedhach", false))
      xmlNodeSetAttribute(xmlCreateChild(r4_117, "godmode"), "enable", getTacticsData("anticheat", "godmode", false))
      local r5_117 = xmlCreateChild(r4_117, "mods")
      xmlNodeSetAttribute(r5_117, "enable", getTacticsData("anticheat", "mods", false))
      for r9_117, r10_117 in ipairs(getTacticsData("anticheat", "modslist", false) or {}) do
        node3 = xmlCreateChild(r5_117, "mod")
        xmlNodeSetAttribute(node3, "name", r10_117.name)
        xmlNodeSetAttribute(node3, "search", r10_117.search)
        xmlNodeSetAttribute(node3, "type", r10_117.type)
      end
    end
    xmlSaveFile(r3_117)
    xmlUnloadFile(r3_117)
    if r0_117 == getCurrentConfig() then
      startConfig(r0_117)
    else
      refreshConfiglist(root)
    end
    return true
  end
  function deleteConfig(r0_118, r1_118)
    -- line: [778, 798] id: 118
    if fileExists("config/" .. tostring(r0_118) .. ".xml") then
      fileDelete("config/" .. tostring(r0_118) .. ".xml")
      local r2_118 = getCurrentConfig()
      local r3_118 = xmlLoadFile("config/configs.xml")
      for r7_118, r8_118 in ipairs(xmlNodeGetChildren(r3_118)) do
        if xmlNodeGetName(r8_118) == "config" and xmlNodeGetAttribute(r8_118, "src") == tostring(r0_118) then
          xmlDestroyNode(r8_118)
        end
      end
      xmlSaveFile(r3_118)
      xmlUnloadFile(r3_118)
      if tostring(r2_118) == tostring(r0_118) then
        setTimer(defaultConfig, 50, 1)
      else
        refreshConfiglist(root)
      end
      return true
    end
    return false
  end
  function renameConfig(r0_119, r1_119, r2_119)
    -- line: [799, 822] id: 119
    if fileExists("config/" .. tostring(r0_119) .. ".xml") and not fileExists(("config/" .. tostring(r1_119) .. ".xml")) then
      local r3_119 = xmlLoadFile("config/configs.xml")
      for r7_119, r8_119 in ipairs(xmlNodeGetChildren(r3_119)) do
        if xmlNodeGetName(r8_119) == "config" and xmlNodeGetAttribute(r8_119, "src") == tostring(r1_119) then
          return false
        end
      end
      if not fileRename(("config/" .. tostring(r0_119) .. ".xml"), ("config/" .. tostring(r1_119) .. ".xml")) then
        return false
      end
      for r7_119, r8_119 in ipairs(xmlNodeGetChildren(r3_119)) do
        if xmlNodeGetName(r8_119) == "current" and xmlNodeGetAttribute(r8_119, "src") == tostring(r0_119) then
          xmlNodeSetAttribute(r8_119, "src", tostring(r1_119))
        end
        if xmlNodeGetName(r8_119) == "config" and xmlNodeGetAttribute(r8_119, "src") == tostring(r0_119) then
          xmlNodeSetAttribute(r8_119, "src", tostring(r1_119))
        end
      end
      xmlSaveFile(r3_119)
      xmlUnloadFile(r3_119)
      refreshConfiglist(root)
      return true
    end
    return false
  end
  function addConfig(r0_120, r1_120)
    -- line: [823, 839] id: 120
    if fileExists("config/" .. tostring(r0_120) .. ".xml") then
      local r2_120 = xmlLoadFile("config/configs.xml")
      for r6_120, r7_120 in ipairs(xmlNodeGetChildren(r2_120)) do
        if xmlNodeGetName(r7_120) == "config" and xmlNodeGetAttribute(r7_120, "src") == tostring(r0_120) then
          return false
        end
      end
      xmlNodeSetAttribute(xmlCreateChild(r2_120, "config"), "src", tostring(r0_120))
      xmlSaveFile(r2_120)
      xmlUnloadFile(r2_120)
      refreshConfiglist(root)
      return true
    end
    return false
  end
  function defaultConfig(r0_121)
    -- line: [840, 1127] id: 121
    if not fileExists("config/_default.xml") then
      local r1_121 = xmlLoadFile("config/configs.xml")
      xmlNodeSetAttribute(xmlCreateChild(r1_121, "config"), "src", "_default")
      xmlSaveFile(r1_121)
      xmlUnloadFile(r1_121)
    else
      fileDelete("config/_default.xml")
    end
    local r1_121 = xmlCreateFile("config/_default.xml", "config")
    local r2_121 = xmlCreateChild(r1_121, "teams")
    local r3_121 = xmlCreateChild(r2_121, "referee")
    xmlNodeSetAttribute(r3_121, "name", "Referee")
    xmlNodeSetAttribute(r3_121, "color", "[255,255,255]")
    local r4_121 = xmlCreateChild(r2_121, "team")
    xmlNodeSetAttribute(r4_121, "name", "Team1")
    xmlNodeSetAttribute(r4_121, "skins", "[292]")
    xmlNodeSetAttribute(r4_121, "color", "[192,96,0]")
    xmlNodeSetAttribute(r4_121, "side", "1")
    r4_121 = xmlCreateChild(r2_121, "team")
    xmlNodeSetAttribute(r4_121, "name", "Team2")
    xmlNodeSetAttribute(r4_121, "skins", "[308]")
    xmlNodeSetAttribute(r4_121, "color", "[0,96,192]")
    xmlNodeSetAttribute(r4_121, "side", "2")
    r2_121 = xmlCreateChild(r1_121, "weaponpack")
    xmlNodeSetAttribute(r2_121, "slots", "3")
    r4_121 = xmlCreateChild(r2_121, "weapons")
    xmlNodeSetAttribute(r4_121, "silenced", "102")
    xmlNodeSetAttribute(r4_121, "deagle", "49")
    xmlNodeSetAttribute(r4_121, "shotgun", "80")
    xmlNodeSetAttribute(r4_121, "spas12", "49")
    xmlNodeSetAttribute(r4_121, "mp5", "210")
    xmlNodeSetAttribute(r4_121, "ak47", "300")
    xmlNodeSetAttribute(r4_121, "m4", "200")
    xmlNodeSetAttribute(r4_121, "rifle", "100")
    xmlNodeSetAttribute(r4_121, "sniper", "50")
    xmlNodeSetAttribute(r4_121, "grenade", "1")
    xmlNodeSetAttribute(r4_121, "teargas", "1")
    xmlNodeSetAttribute(r4_121, "molotov", "1")
    xmlNodeSetAttribute(r4_121, "knife", "1")
    r4_121 = xmlCreateChild(r2_121, "balance")
    r4_121 = xmlCreateChild(r2_121, "cost")
    r4_121 = xmlCreateChild(r2_121, "slot")
    r2_121 = xmlCreateChild(r1_121, "shooting")
    r4_121 = xmlCreateChild(r2_121, "properties")
    xmlNodeSetAttribute(r4_121, "weapon", "22")
    xmlNodeSetAttribute(r4_121, "maximum_clip_ammo", "17")
    xmlNodeSetAttribute(r4_121, "flags", "3303")
    r4_121 = xmlCreateChild(r2_121, "properties")
    xmlNodeSetAttribute(r4_121, "weapon", "26")
    xmlNodeSetAttribute(r4_121, "maximum_clip_ammo", "2")
    xmlNodeSetAttribute(r4_121, "flags", "3303")
    r4_121 = xmlCreateChild(r2_121, "properties")
    xmlNodeSetAttribute(r4_121, "weapon", "28")
    xmlNodeSetAttribute(r4_121, "maximum_clip_ammo", "50")
    xmlNodeSetAttribute(r4_121, "flags", "3303")
    r4_121 = xmlCreateChild(r2_121, "properties")
    xmlNodeSetAttribute(r4_121, "weapon", "30")
    xmlNodeSetAttribute(r4_121, "damage", "12")
    r4_121 = xmlCreateChild(r2_121, "properties")
    xmlNodeSetAttribute(r4_121, "weapon", "32")
    xmlNodeSetAttribute(r4_121, "maximum_clip_ammo", "50")
    xmlNodeSetAttribute(r4_121, "flags", "3303")
    r4_121 = xmlCreateChild(r2_121, "properties")
    xmlNodeSetAttribute(r4_121, "weapon", "33")
    xmlNodeSetAttribute(r4_121, "flags", "830A")
    r2_121 = xmlCreateChild(r1_121, "handlings")
    r2_121 = xmlCreateChild(r1_121, "settings")
    r4_121 = xmlCreateChild(r2_121, "settings")
    xmlNodeSetAttribute(r4_121, "autobalance", "false")
    xmlNodeSetAttribute(r4_121, "autoswap", "true")
    xmlNodeSetAttribute(r4_121, "blurlevel", "0")
    xmlNodeSetAttribute(r4_121, "countdown_auto", "true")
    xmlNodeSetAttribute(r4_121, "countdown_force", "0:10")
    xmlNodeSetAttribute(r4_121, "countdown_start", "3")
    xmlNodeSetAttribute(r4_121, "dontfire", "false")
    xmlNodeSetAttribute(r4_121, "friendly_fire", "false")
    xmlNodeSetAttribute(r4_121, "gamespeed", "1.0")
    xmlNodeSetAttribute(r4_121, "ghostmode", "none|none,team,all")
    xmlNodeSetAttribute(r4_121, "gravity", "0.008")
    xmlNodeSetAttribute(r4_121, "heli_killing", "true")
    xmlNodeSetAttribute(r4_121, "player_can_driveby", "true")
    xmlNodeSetAttribute(r4_121, "player_dead_visible", "true")
    xmlNodeSetAttribute(r4_121, "player_nametag", "all|none,team,all")
    xmlNodeSetAttribute(r4_121, "player_radarblip", "team|none,team,all")
    xmlNodeSetAttribute(r4_121, "player_information", "true")
    xmlNodeSetAttribute(r4_121, "player_start_armour", "0")
    xmlNodeSetAttribute(r4_121, "player_start_health", "100")
    xmlNodeSetAttribute(r4_121, "respawn", "false")
    xmlNodeSetAttribute(r4_121, "respawn_lives", "0")
    xmlNodeSetAttribute(r4_121, "respawn_time", "0:05")
    xmlNodeSetAttribute(r4_121, "spectate_enemy", "false")
    xmlNodeSetAttribute(r4_121, "stealth_killing", "true")
    xmlNodeSetAttribute(r4_121, "streetlamps", "true")
    xmlNodeSetAttribute(r4_121, "time", "12:00")
    xmlNodeSetAttribute(r4_121, "time_locked", "false")
    xmlNodeSetAttribute(r4_121, "time_minuteduration", "1000")
    xmlNodeSetAttribute(r4_121, "timeout_to_pause", "false")
    xmlNodeSetAttribute(r4_121, "vehicle_color", "teamcolor|default,teamcolor")
    xmlNodeSetAttribute(r4_121, "vehicle_per_player", "2")
    xmlNodeSetAttribute(r4_121, "vehicle_nametag", "true")
    xmlNodeSetAttribute(r4_121, "vehicle_radarblip", "unoccupied|none,unoccupied,always")
    xmlNodeSetAttribute(r4_121, "vehicle_respawn_blown", "0:00")
    xmlNodeSetAttribute(r4_121, "vehicle_respawn_idle", "0:00")
    xmlNodeSetAttribute(r4_121, "vehicle_tank_explodable", "false")
    xmlNodeSetAttribute(r4_121, "vote", "true")
    xmlNodeSetAttribute(r4_121, "vote_duration", "0:20")
    r4_121 = xmlCreateChild(r2_121, "glitches")
    xmlNodeSetAttribute(r4_121, "quickreload", "false")
    xmlNodeSetAttribute(r4_121, "fastmove", "true")
    xmlNodeSetAttribute(r4_121, "fastfire", "true")
    xmlNodeSetAttribute(r4_121, "crouchbug", "true")
    xmlNodeSetAttribute(r4_121, "closedamage", "true")
    xmlNodeSetAttribute(r4_121, "hitanim", "true")
    r4_121 = xmlCreateChild(r2_121, "cheats")
    xmlNodeSetAttribute(r4_121, "hovercars", "false")
    xmlNodeSetAttribute(r4_121, "aircars", "false")
    xmlNodeSetAttribute(r4_121, "extrabunny", "false")
    xmlNodeSetAttribute(r4_121, "extrajump", "false")
    xmlNodeSetAttribute(r4_121, "magnetcars", "false")
    xmlNodeSetAttribute(r4_121, "knockoffbike", "true")
    r4_121 = xmlCreateChild(r2_121, "limites")
    xmlNodeSetAttribute(r4_121, "fps_limit", "50")
    xmlNodeSetAttribute(r4_121, "fps_minimal", "0")
    xmlNodeSetAttribute(r4_121, "ping_maximal", "65536")
    xmlNodeSetAttribute(r4_121, "packetloss_second", "0")
    xmlNodeSetAttribute(r4_121, "packetloss_total", "0")
    xmlNodeSetAttribute(r4_121, "warnings_fps", "10")
    xmlNodeSetAttribute(r4_121, "warnings_ping", "10")
    xmlNodeSetAttribute(r4_121, "warnings_packetloss", "3")
    for r8_121 in pairs(getTacticsData("modes_defined") or {}) do
      r4_121 = xmlCreateChild(r2_121, "mode")
      xmlNodeSetAttribute(r4_121, "name", r8_121)
      xmlNodeSetAttribute(r4_121, "enable", "true")
      for r12_121, r13_121 in pairs(getTacticsData("modes_settings", r8_121) or {}) do
        xmlNodeSetAttribute(r4_121, r12_121, r13_121)
      end
    end
    r2_121 = xmlCreateChild(r1_121, "mappack")
    xmlNodeSetAttribute(r2_121, "automatics", "lobby|lobby,cycler,voting,random")
    xmlNodeSetAttribute(xmlCreateChild(r2_121, "cycler"), "resnames", "[]")
    xmlNodeSetAttribute(xmlCreateChild(r2_121, "disabled"), "resnames", "[]")
    xmlNodeSetAttribute(xmlCreateChild(r1_121, "vehiclepack"), "models", "[407,425,430,432,435,441,447,449,450,464,465,476,501,520,584,591,601,537,538,564,569,570,590,594,606,607,610,608,611]")
    r2_121 = xmlCreateChild(r1_121, "weather")
    r4_121 = xmlCreateChild(r2_121, "weather")
    xmlNodeSetAttribute(r4_121, "hour", "0")
    xmlNodeSetAttribute(r4_121, "sky", "[0,23,24,0,31,32]")
    xmlNodeSetAttribute(r4_121, "clouds", "true")
    xmlNodeSetAttribute(r4_121, "birds", "false")
    xmlNodeSetAttribute(r4_121, "sun", "[255,128,0,5,0,0,0.00]")
    xmlNodeSetAttribute(r4_121, "water", "[85,85,65,240]")
    xmlNodeSetAttribute(r4_121, "wave", "0.5")
    xmlNodeSetAttribute(r4_121, "level", "0")
    xmlNodeSetAttribute(r4_121, "wind", "[0.16,0.15,0.00]")
    xmlNodeSetAttribute(r4_121, "rain", "0")
    xmlNodeSetAttribute(r4_121, "heat", "0")
    xmlNodeSetAttribute(r4_121, "far", "400.00")
    xmlNodeSetAttribute(r4_121, "fog", "100.00")
    xmlNodeSetAttribute(r4_121, "effect", "0")
    r4_121 = xmlCreateChild(r2_121, "weather")
    xmlNodeSetAttribute(r4_121, "hour", "5")
    xmlNodeSetAttribute(r4_121, "sky", "[0,20,20,0,31,32]")
    xmlNodeSetAttribute(r4_121, "clouds", "true")
    xmlNodeSetAttribute(r4_121, "birds", "true")
    xmlNodeSetAttribute(r4_121, "sun", "[255,128,0,255,128,0,0.00]")
    xmlNodeSetAttribute(r4_121, "water", "[53,104,104,240]")
    xmlNodeSetAttribute(r4_121, "wave", "0.5")
    xmlNodeSetAttribute(r4_121, "level", "0")
    xmlNodeSetAttribute(r4_121, "wind", "[0.16,0.15,0.00]")
    xmlNodeSetAttribute(r4_121, "rain", "0")
    xmlNodeSetAttribute(r4_121, "heat", "0")
    xmlNodeSetAttribute(r4_121, "far", "400.00")
    xmlNodeSetAttribute(r4_121, "fog", "100.00")
    xmlNodeSetAttribute(r4_121, "effect", "0")
    r4_121 = xmlCreateChild(r2_121, "weather")
    xmlNodeSetAttribute(r4_121, "hour", "6")
    xmlNodeSetAttribute(r4_121, "sky", "[90,205,255,200,144,85]")
    xmlNodeSetAttribute(r4_121, "clouds", "true")
    xmlNodeSetAttribute(r4_121, "birds", "true")
    xmlNodeSetAttribute(r4_121, "sun", "[255,128,0,255,128,0,8.40]")
    xmlNodeSetAttribute(r4_121, "water", "[90,170,170,240]")
    xmlNodeSetAttribute(r4_121, "wave", "0.5")
    xmlNodeSetAttribute(r4_121, "level", "0")
    xmlNodeSetAttribute(r4_121, "wind", "[0.16,0.15,0.00]")
    xmlNodeSetAttribute(r4_121, "rain", "0")
    xmlNodeSetAttribute(r4_121, "heat", "0")
    xmlNodeSetAttribute(r4_121, "far", "800.00")
    xmlNodeSetAttribute(r4_121, "fog", "100.00")
    xmlNodeSetAttribute(r4_121, "effect", "0")
    r4_121 = xmlCreateChild(r2_121, "weather")
    xmlNodeSetAttribute(r4_121, "hour", "7")
    xmlNodeSetAttribute(r4_121, "sky", "[90,205,255,90,200,255]")
    xmlNodeSetAttribute(r4_121, "clouds", "true")
    xmlNodeSetAttribute(r4_121, "birds", "true")
    xmlNodeSetAttribute(r4_121, "sun", "[255,255,255,255,255,255,2.20]")
    xmlNodeSetAttribute(r4_121, "water", "[145,170,170,240]")
    xmlNodeSetAttribute(r4_121, "wave", "0.5")
    xmlNodeSetAttribute(r4_121, "level", "0")
    xmlNodeSetAttribute(r4_121, "wind", "[0.16,0.15,0.00]")
    xmlNodeSetAttribute(r4_121, "rain", "0")
    xmlNodeSetAttribute(r4_121, "heat", "0")
    xmlNodeSetAttribute(r4_121, "far", "800.00")
    xmlNodeSetAttribute(r4_121, "fog", "100.00")
    xmlNodeSetAttribute(r4_121, "effect", "0")
    r4_121 = xmlCreateChild(r2_121, "weather")
    xmlNodeSetAttribute(r4_121, "hour", "12")
    xmlNodeSetAttribute(r4_121, "sky", "[68,117,210,36,117,199]")
    xmlNodeSetAttribute(r4_121, "clouds", "true")
    xmlNodeSetAttribute(r4_121, "birds", "true")
    xmlNodeSetAttribute(r4_121, "sun", "[255,255,255,255,255,255,1.10]")
    xmlNodeSetAttribute(r4_121, "water", "[90,170,170,240]")
    xmlNodeSetAttribute(r4_121, "wave", "0.5")
    xmlNodeSetAttribute(r4_121, "level", "0")
    xmlNodeSetAttribute(r4_121, "wind", "[0.16,0.15,0.00]")
    xmlNodeSetAttribute(r4_121, "rain", "0")
    xmlNodeSetAttribute(r4_121, "heat", "0")
    xmlNodeSetAttribute(r4_121, "far", "800.00")
    xmlNodeSetAttribute(r4_121, "fog", "10.00")
    xmlNodeSetAttribute(r4_121, "effect", "0")
    r4_121 = xmlCreateChild(r2_121, "weather")
    xmlNodeSetAttribute(r4_121, "hour", "19")
    xmlNodeSetAttribute(r4_121, "sky", "[68,117,210,36,117,194]")
    xmlNodeSetAttribute(r4_121, "clouds", "true")
    xmlNodeSetAttribute(r4_121, "birds", "true")
    xmlNodeSetAttribute(r4_121, "sun", "[222,88,0,122,55,0,3.90]")
    xmlNodeSetAttribute(r4_121, "water", "[50,97,97,240]")
    xmlNodeSetAttribute(r4_121, "wave", "0.5")
    xmlNodeSetAttribute(r4_121, "level", "0")
    xmlNodeSetAttribute(r4_121, "wind", "[0.16,0.15,0.00]")
    xmlNodeSetAttribute(r4_121, "rain", "0")
    xmlNodeSetAttribute(r4_121, "heat", "0")
    xmlNodeSetAttribute(r4_121, "far", "800.00")
    xmlNodeSetAttribute(r4_121, "fog", "10.00")
    xmlNodeSetAttribute(r4_121, "effect", "0")
    r4_121 = xmlCreateChild(r2_121, "weather")
    xmlNodeSetAttribute(r4_121, "hour", "20")
    xmlNodeSetAttribute(r4_121, "sky", "[181,150,84,167,108,65]")
    xmlNodeSetAttribute(r4_121, "clouds", "true")
    xmlNodeSetAttribute(r4_121, "birds", "true")
    xmlNodeSetAttribute(r4_121, "sun", "[255,128,0,255,128,0,2.00]")
    xmlNodeSetAttribute(r4_121, "water", "[67,67,67,240]")
    xmlNodeSetAttribute(r4_121, "wave", "0.5")
    xmlNodeSetAttribute(r4_121, "level", "0")
    xmlNodeSetAttribute(r4_121, "wind", "[0.16,0.15,0.00]")
    xmlNodeSetAttribute(r4_121, "rain", "0")
    xmlNodeSetAttribute(r4_121, "heat", "0")
    xmlNodeSetAttribute(r4_121, "far", "800.00")
    xmlNodeSetAttribute(r4_121, "fog", "10.00")
    xmlNodeSetAttribute(r4_121, "effect", "0")
    r4_121 = xmlCreateChild(r2_121, "weather")
    xmlNodeSetAttribute(r4_121, "hour", "22")
    xmlNodeSetAttribute(r4_121, "sky", "[137,100,84,60,50,52]")
    xmlNodeSetAttribute(r4_121, "clouds", "true")
    xmlNodeSetAttribute(r4_121, "birds", "true")
    xmlNodeSetAttribute(r4_121, "sun", "[255,128,0,5,8,0,1.00]")
    xmlNodeSetAttribute(r4_121, "water", "[67,67,62,240]")
    xmlNodeSetAttribute(r4_121, "wave", "0.5")
    xmlNodeSetAttribute(r4_121, "level", "0")
    xmlNodeSetAttribute(r4_121, "wind", "[0.16,0.15,0.00]")
    xmlNodeSetAttribute(r4_121, "rain", "0")
    xmlNodeSetAttribute(r4_121, "heat", "0")
    xmlNodeSetAttribute(r4_121, "far", "800.00")
    xmlNodeSetAttribute(r4_121, "fog", "10.00")
    xmlNodeSetAttribute(r4_121, "effect", "0")
    r2_121 = xmlCreateChild(r1_121, "anticheat")
    xmlNodeSetAttribute(r2_121, "action_detection", "chat|chat,adminchat,kick")
    xmlNodeSetAttribute(xmlCreateChild(r2_121, "speedhach"), "enable", "true")
    xmlNodeSetAttribute(xmlCreateChild(r2_121, "godmode"), "enable", "true")
    r4_121 = xmlCreateChild(r2_121, "mods")
    xmlNodeSetAttribute(r4_121, "enable", "true")
    node3 = xmlCreateChild(r4_121, "mod")
    xmlNodeSetAttribute(node3, "name", "Animations")
    xmlNodeSetAttribute(node3, "search", "*.ifp")
    xmlNodeSetAttribute(node3, "type", "name")
    node3 = xmlCreateChild(r4_121, "mod")
    xmlNodeSetAttribute(node3, "name", "Collisions")
    xmlNodeSetAttribute(node3, "search", "*.col")
    xmlNodeSetAttribute(node3, "type", "name")
    xmlSaveFile(r1_121)
    xmlUnloadFile(r1_121)
    startConfig("_default", r0_121)
  end
  function refreshConfiglist(r0_122)
    -- line: [1128, 1166] id: 122
    local r1_122 = {}
    local r2_122 = nil
    local r3_122 = nil
    local r4_122 = nil
    local r5_122 = nil
    r2_122 = xmlLoadFile("config/configs.xml")
    for r9_122, r10_122 in ipairs(xmlNodeGetChildren(r2_122)) do
      if xmlNodeGetName(r10_122) == "current" then
        r3_122 = xmlNodeGetAttribute(r10_122, "src")
        r5_122 = r10_122
      end
      if xmlNodeGetName(r10_122) == "config" then
        r4_122 = xmlNodeGetAttribute(r10_122, "src")
        if not fileExists(("config/" .. r4_122 .. ".xml")) then
          xmlDestroyNode(r10_122)
          if r4_122 == r3_122 then
            xmlNodeSetAttribute(r5_122, "src", "_default")
          end
        else
          local r11_122 = ""
          local r12_122 = xmlLoadFile("config/" .. r4_122 .. ".xml")
          if xmlFindChild(r12_122, "mappack", 0) then
            r11_122 = r11_122 .. "M "
          end
          if xmlFindChild(r12_122, "settings", 0) then
            r11_122 = r11_122 .. "S "
          end
          if xmlFindChild(r12_122, "teams", 0) then
            r11_122 = r11_122 .. "T "
          end
          if xmlFindChild(r12_122, "weaponpack", 0) then
            r11_122 = r11_122 .. "Wp "
          end
          if xmlFindChild(r12_122, "vehiclepack", 0) then
            r11_122 = r11_122 .. "V "
          end
          if xmlFindChild(r12_122, "weather", 0) then
            r11_122 = r11_122 .. "Wh "
          end
          if xmlFindChild(r12_122, "shooting", 0) then
            r11_122 = r11_122 .. "Sh "
          end
          if xmlFindChild(r12_122, "handlings", 0) then
            r11_122 = r11_122 .. "H "
          end
          if xmlFindChild(r12_122, "anticheat", 0) then
            r11_122 = r11_122 .. "AC "
          end
          xmlUnloadFile(r12_122)
          if r4_122 == r3_122 then
            table.insert(r1_122, {
              r4_122,
              0,
              r11_122
            })
          else
            table.insert(r1_122, {
              r4_122,
              255,
              r11_122
            })
          end
        end
      end
    end
    xmlSaveFile(r2_122)
    xmlUnloadFile(r2_122)
    callClientFunction(r0_122, "refreshConfiglist", r1_122)
  end
  function onPlayerJoin()
    -- line: [1167, 1171] id: 123
    local r0_123 = setElementData
    local r1_123 = source
    local r2_123 = "IP"
    local r3_123 = hasObjectPermissionTo(getThisResource(), "function.getClientIP", false)
    if r3_123 then
      r3_123 = getPlayerIP(source) or "Not Permission"
    else
      goto label_16	-- block#2 is visited secondly
    end
    r0_123(r1_123, r2_123, r3_123)
    setElementData(source, "Serial", getPlayerSerial(source))
    setElementData(source, "Version", getPlayerVersion(source))
  end
  function onRoundCommandStart(r0_124, r1_124, r2_124)
    -- line: [1172, 1186] id: 124
    if not hasObjectPermissionTo(r0_124, "general.tactics_maps", false) then
      return outputLangString(r0_124, "you_have_not_permissions")
    end
    if not r2_124 then
      return startMap(r1_124)
    else
      local r3_124 = getResourceFromName(string.lower(r1_124 .. "_" .. r2_124))
      if r3_124 and getResourceInfo(r3_124, "type") == "map" then
        startMap(r3_124)
        return true
      end
    end
    return false
  end
  function onRoundStop(r0_125)
    -- line: [1187, 1205] id: 125
    if not hasObjectPermissionTo(r0_125, "general.tactics_maps", false) then
      outputLangString(r0_125, "you_have_not_permissions")
      return false
    end
    local r1_125 = getTacticsData("map_disabled") or {}
    local r2_125 = {}
    for r6_125, r7_125 in ipairs(getResources()) do
      if getResourceInfo(r7_125, "type") == "map" and string.find(getResourceName(r7_125), "lobby") == 1 and not r1_125[getResourceName(r7_125)] then
        table.insert(r2_125, r7_125)
      end
    end
    if #r2_125 > 0 then
      startMap(r2_125[math.random(#r2_125)], "random")
      return true
    end
    return false
  end
  function createTacticsMode(r0_126, r1_126, r2_126)
    -- line: [1206, 1210] id: 126
    setTacticsData(r2_126 or true, "modes_defined", tostring(r0_126))
    addCommandHandler(tostring(r0_126), onRoundCommandStart, false, false)
    setTacticsData(r1_126, "modes_settings", tostring(r0_126))
  end
  function addPlayer(r0_127, r1_127, r2_127)
    -- line: [1211, 1231] id: 127
    if not hasObjectPermissionTo(r0_127, "general.tactics_players", false) then
      return outputLangString(r0_127, "you_have_not_permissions")
    end
    if getRoundState() ~= "started" then
      return false
    end
    local r3_127 = getElementByID(tostring(r2_127))
    if r3_127 then
      if not getPlayerTeam(r3_127) then
        outputLangString(r0_127, "player_without_team")
      elseif getPlayerTeam(r3_127) == getElementsByType("team")[1] then
        outputLangString(r0_127, "player_is_referee")
      elseif getElementData(r3_127, "Loading") then
        outputLangString(r0_127, "player_do_not_loaded")
      elseif getElementData(r3_127, "Status") == "Play" then
        outputLangString(r0_127, "player_play_already")
      else
        outputLangString(root, "add_to_round", getPlayerName(r3_127))
        triggerEvent("onPlayerRoundRespawn", r3_127)
      end
    end
  end
  function removePlayer(r0_128, r1_128, r2_128)
    -- line: [1232, 1248] id: 128
    if not hasObjectPermissionTo(r0_128, "general.tactics_players", false) then
      return outputLangString(r0_128, "you_have_not_permissions")
    end
    if getRoundState() ~= "started" then
      return false
    end
    local r3_128 = getElementByID(tostring(r2_128))
    if r3_128 then
      if getElementData(r3_128, "Status") ~= "Play" then
        outputLangString(r0_128, "player_not_play_yet")
      elseif triggerEvent("onPlayerRemoveFromRound", r3_128) == true then
        killPed(r3_128)
        outputLangString(root, "remove_from_round", getPlayerName(r3_128))
      end
    end
  end
  function restorePlayer(r0_129, r1_129, r2_129)
    -- line: [1249, 1258] id: 129
    if not hasObjectPermissionTo(r0_129, "general.tactics_players", false) then
      return outputLangString(r0_129, "you_have_not_permissions")
    end
    if getRoundState() ~= "started" then
      return false
    end
    local r3_129 = getElementByID(tostring(r2_129))
    if r3_129 then
      callClientFunction(r0_129, "toRestoreChoise", r3_129)
    end
  end
  function resetStats(r0_130)
    -- line: [1259, 1269] id: 130
    for r4_130, r5_130 in ipairs(getElementsByType("team")) do
      setElementData(r5_130, "Score", 0)
    end
    for r4_130, r5_130 in ipairs(getElementsByType("player")) do
      setElementData(r5_130, "Kills", 0)
      setElementData(r5_130, "Deaths", 0)
      setElementData(r5_130, "Damage", 0)
    end
    outputLangString(root, "stats_cleaned")
  end
  function setNextMap(r0_131)
    -- line: [1270, 1291] id: 131
    local r1_131 = getResourceFromName(r0_131)
    if r1_131 then
      local r2_131 = string.sub(r0_131, 1, string.find(r0_131, "_") - 1)
      if #r2_131 > 1 then
        r2_131 = string.upper(string.sub(r2_131, 1, 1)) .. string.sub(r2_131, 2)
      end
      local r3_131 = getResourceInfo(r1_131, "name")
      if not r3_131 then
        r3_131 = string.sub(string.gsub(r0_131, "_", " "), #r2_131 + 2)
        if #r3_131 > 1 then
          r3_131 = string.upper(string.sub(r3_131, 1, 1)) .. string.sub(r3_131, 2)
        end
      end
      setTacticsData(r0_131, "ResourceNext")
      if getTacticsData("Map") == "lobby" then
        startMap(r1_131)
      else
        outputLangString(root, "map_set_next", r2_131 .. ": " .. r3_131)
      end
    else
      outputLangString(root, "voting_falied")
    end
  end
  function cancelNextMap()
    -- line: [1292, 1296] id: 132
    if not getTacticsData("ResourceNext") then
      return 
    end
    setTacticsData(nil, "ResourceNext")
    outputLangString(root, "map_cancel_next")
  end
  function balanceTeams(r0_133, r1_133, ...)
    -- line: [1297, 1392] id: 133
    if r0_133 and not hasObjectPermissionTo(r0_133, "general.tactics_players", false) then
      return outputLangString(r0_133, "you_have_not_permissions")
    end
    local r3_133 = {
      ...
    }
    r1_133 = string.lower(tostring(r1_133))
    if r1_133 == "lite" then
      local r4_133 = 0
      local r5_133 = {}
      for r9_133, r10_133 in ipairs(getElementsByType("team")) do
        if r9_133 > 1 then
          r4_133 = r4_133 + countPlayersInTeam(r10_133)
          table.insert(r5_133, {
            r10_133,
            getPlayersInTeam(r10_133)
          })
        end
      end
      if #r5_133 == 0 then
        return 
      end
      local r6_133 = math.ceil(r4_133 / #r5_133)
      table.sort(r5_133, function(r0_134, r1_134)
        -- line: [1315, 1315] id: 134
        return #r1_134[2] < #r0_134[2]
      end)
      local r7_133 = {}
      for r11_133, r12_133 in ipairs(r5_133) do
        local r13_133, r14_133 = unpack(r12_133)
        for r18_133 = math.min(#r14_133, r6_133), math.max(#r14_133, r6_133), 1 do
          if r18_133 <= #r14_133 then
            table.insert(r7_133, r14_133[r18_133])
          else
            local r19_133 = getElementData(r13_133, "Skins")
            if not r19_133 then
              r19_133 = {}
              local r20_133 = 71
              -- setlist for #19 failed
            end
            setPlayerTeam(r7_133[1], r13_133)
            setElementModel(r7_133[1], r19_133[1])
            triggerClientEvent(root, "onClientPlayerBlipUpdate", r7_133[1])
            table.remove(r7_133, 1)
          end
        end
      end
      outputLangString(root, "team_balanced_mode", "Lite")
    elseif r1_133 == "select" then
      local r4_133 = getElementsByType("team")[1]
      local r5_133 = getTacticsData("Sides")
      if #r5_133 < 2 then
        return 
      end
      local r6_133 = {}
      for r10_133, r11_133 in ipairs(r3_133[1] or {}) do
        r6_133[r11_133] = true
        local r12_133 = getElementData(r5_133[1], "Skins")
        if not r12_133 then
          r12_133 = {}
          local r13_133 = 71
          -- setlist for #12 failed
        end
        setPlayerTeam(r11_133, r5_133[1])
        setElementModel(r11_133, r12_133[1])
        triggerClientEvent(root, "onClientPlayerBlipUpdate", r11_133)
      end
      for r10_133, r11_133 in ipairs(getElementsByType("player")) do
        if getPlayerTeam(r11_133) and getPlayerTeam(r11_133) ~= r4_133 and not r6_133[r11_133] then
          local r12_133 = getElementData(r5_133[2], "Skins")
          if not r12_133 then
            r12_133 = {}
            local r13_133 = 71
            -- setlist for #12 failed
          end
          setPlayerTeam(r11_133, r5_133[2])
          setElementModel(r11_133, r12_133[1])
          triggerClientEvent(root, "onClientPlayerBlipUpdate", r11_133)
        end
      end
      outputLangString(root, "team_balanced_mode", "Select")
    else
      local r4_133 = {}
      local r5_133 = getElementsByType("team")[1]
      for r9_133, r10_133 in ipairs(getElementsByType("player")) do
        if getPlayerTeam(r10_133) and getPlayerTeam(r10_133) ~= r5_133 then
          table.insert(r4_133, r10_133)
        end
      end
      table.sort(r4_133, function(r0_135, r1_135)
        -- line: [1363, 1373] id: 135
        local r2_135 = getElementData(r0_135, "Kills") or 0
        local r3_135 = getElementData(r0_135, "Deaths") or 0
        local r5_135 = 0.5 * (r2_135 + 0.01 * (getElementData(r0_135, "Damage") or 0)) - r3_135
        local r6_135 = getElementData(r1_135, "Kills") or 0
        local r7_135 = getElementData(r1_135, "Deaths") or 0
        return 0.5 * (r6_135 + 0.01 * (getElementData(r1_135, "Damage") or 0)) - r7_135 < r5_135
      end)
      local r6_133 = getTacticsData("Sides")
      table.sort(r6_133, function(r0_136, r1_136)
        -- line: [1375, 1379] id: 136
        local r2_136 = getElementData(r0_136, "Score") or 0
        return r2_136 < (getElementData(r1_136, "Score") or 0)
      end)
      for r10_133, r11_133 in ipairs(r6_133) do
        for r15_133, r16_133 in ipairs(r4_133) do
          if (r15_133 - 1) % #r6_133 == r10_133 - 1 then
            local r17_133 = getElementData(r11_133, "Skins")
            if not r17_133 then
              r17_133 = {}
              local r18_133 = 71
              -- setlist for #17 failed
            end
            setPlayerTeam(r16_133, r11_133)
            setElementModel(r16_133, r17_133[1])
            triggerClientEvent(root, "onClientPlayerBlipUpdate", r16_133)
          end
        end
      end
      outputLangString(root, "team_balanced")
    end
  end
  function onPlayerLogin(r0_137, r1_137, r2_137)
    -- line: [1393, 1397] id: 137
    if hasObjectPermissionTo(source, "general.tactics_openpanel", false) then
      outputLangString(source, "for_open_controlpanel")
    end
  end
  function onElementDataChange(r0_138, r1_138)
    -- line: [1398, 1405] id: 138
    if r0_138 == "Skins" and getElementType(source) == "team" then
      local r2_138 = getElementData(source, r0_138)
      for r6_138, r7_138 in ipairs(getPlayersInTeam(source)) do
        setElementModel(r7_138, r2_138[1])
      end
    end
  end
  function onTacticsChange(r0_139, r1_139)
    -- line: [1406, 1525] id: 139
    -- notice: unreachable block#48
    -- notice: unreachable block#27
    -- notice: unreachable block#55
    -- notice: unreachable block#34
    -- notice: unreachable block#41
    -- notice: unreachable block#20
    -- notice: unreachable block#10
    if r0_139[1] == "settings" then
      if r0_139[2] == "gamespeed" and not isRoundPaused() then
        setGameSpeed(tonumber(getTacticsData("settings", "gamespeed")))
      end
      if r0_139[2] == "gravity" then
        setGravity(tonumber(getTacticsData("settings", "gravity")))
      end
      if r0_139[2] == "friendly_fire" then
        local r2_139 = getTacticsData("settings", "friendly_fire")
        if r2_139 == "true" then
          r2_139 = true
        else
          r2_139 = false
        end
        for r6_139, r7_139 in ipairs(getElementsByType("team")) do
          setTeamFriendlyFire(r7_139, r2_139)
        end
      end
    end
    if r0_139[1] == "glitches" then
      if r0_139[2] == "quickreload" then
        local r2_139 = setGlitchEnabled
        local r3_139 = "quickreload"
        local r4_139 = getTacticsData("glitches", "quickreload")
        if r4_139 == "true" then
          r4_139 = true
        else
          r4_139 = false
        end
        r2_139(r3_139, r4_139)
      end
      if r0_139[2] == "fastmove" then
        local r2_139 = setGlitchEnabled
        local r3_139 = "fastmove"
        local r4_139 = getTacticsData("glitches", "fastmove")
        if r4_139 == "true" then
          r4_139 = true
        else
          r4_139 = false
        end
        r2_139(r3_139, r4_139)
      end
      if r0_139[2] == "fastfire" then
        local r2_139 = setGlitchEnabled
        local r3_139 = "fastfire"
        local r4_139 = getTacticsData("glitches", "fastfire")
        if r4_139 == "true" then
          r4_139 = true
        else
          r4_139 = false
        end
        r2_139(r3_139, r4_139)
      end
      if r0_139[2] == "crouchbug" then
        local r2_139 = setGlitchEnabled
        local r3_139 = "crouchbug"
        local r4_139 = getTacticsData("glitches", "crouchbug")
        if r4_139 == "true" then
          r4_139 = true
        else
          r4_139 = false
        end
        r2_139(r3_139, r4_139)
      end
      if r0_139[2] == "closedamage" then
        local r2_139 = setGlitchEnabled
        local r3_139 = "highcloserangedamage"
        local r4_139 = getTacticsData("glitches", "closedamage")
        if r4_139 == "true" then
          r4_139 = true
        else
          r4_139 = false
        end
        r2_139(r3_139, r4_139)
      end
      if r0_139[2] == "hitanim" then
        local r2_139 = setGlitchEnabled
        local r3_139 = "hitanim"
        local r4_139 = getTacticsData("glitches", "hitanim")
        if r4_139 == "true" then
          r4_139 = true
        else
          r4_139 = false
        end
        r2_139(r3_139, r4_139)
      end
    end
    if r0_139[1] == "limites" and r0_139[2] == "fps_limit" then
      setFPSLimit(tonumber(getTacticsData("limites", "fps_limit")))
    end
    if r0_139[1] == "handlings" then
      local r2_139 = getTacticsData("handlings") or {}
      for r6_139 = 400, 611, 1 do
        if #getVehicleNameFromModel(r6_139) > 0 then
          local r7_139 = getOriginalHandling(r6_139)
          r7_139.monetary = nil
          r7_139.animGroup = nil
          r7_139.tailLight = nil
          r7_139.headLight = nil
          local r8_139 = getModelHandling(r6_139)
          local r9_139 = nil
          for r13_139, r14_139 in pairs(r7_139) do
            if r2_139[r6_139] and r2_139[r6_139][r13_139] ~= nil then
              if r13_139 == "modelFlags" or r13_139 == "handlingFlags" then
                setModelHandling(r6_139, r13_139, tonumber(r2_139[r6_139][r13_139]))
                for r18_139, r19_139 in ipairs(getElementsByType("vehicle")) do
                  if getElementModel(r19_139) == r6_139 then
                    setVehicleHandling(r19_139, r13_139, tonumber(r2_139[r6_139][r13_139]))
                  end
                end
              elseif type(r2_139[r6_139][r13_139]) == "table" then
                setModelHandling(r6_139, r13_139, {
                  unpack(r2_139[r6_139][r13_139])
                })
                for r18_139, r19_139 in ipairs(getElementsByType("vehicle")) do
                  if getElementModel(r19_139) == r6_139 then
                    setVehicleHandling(r19_139, r13_139, {
                      unpack(r2_139[r6_139][r13_139])
                    })
                  end
                end
              else
                setModelHandling(r6_139, r13_139, r2_139[r6_139][r13_139])
                for r18_139, r19_139 in ipairs(getElementsByType("vehicle")) do
                  if getElementModel(r19_139) == r6_139 then
                    setVehicleHandling(r19_139, r13_139, r2_139[r6_139][r13_139])
                  end
                end
              end
            elseif r8_139[r13_139] ~= r14_139 then
              setModelHandling(r6_139, r13_139, r14_139)
              for r18_139, r19_139 in ipairs(getElementsByType("vehicle")) do
                if getElementModel(r19_139) == r6_139 then
                  setVehicleHandling(r19_139, r13_139, r14_139)
                end
              end
            end
          end
          if not r2_139[r6_139] or not r2_139[r6_139].sirens then
            for r13_139, r14_139 in ipairs(getElementsByType("vehicle")) do
              if getElementModel(r14_139) == r6_139 then
                removeVehicleSirens(r14_139)
              end
            end
          else
            for r13_139, r14_139 in ipairs(getElementsByType("vehicle")) do
              if getElementModel(r14_139) == r6_139 then
                addVehicleSirens(r14_139, r2_139[r6_139].sirens.count, r2_139[r6_139].sirens.type, r2_139[r6_139].sirens.flags["360"], r2_139[r6_139].sirens.flags.DoLOSCheck, r2_139[r6_139].sirens.flags.UseRandomiser, r2_139[r6_139].sirens.flags.Silent)
                for r18_139 = 1, r2_139[r6_139].sirens.count, 1 do
                  local r19_139, r20_139, r21_139, r22_139 = getColorFromString("#" .. r2_139[r6_139].sirens[r18_139].color)
                  setVehicleSirens(r14_139, r18_139, r2_139[r6_139].sirens[r18_139].x, r2_139[r6_139].sirens[r18_139].y, r2_139[r6_139].sirens[r18_139].z, r20_139, r21_139, r22_139, r19_139, r2_139[r6_139].sirens[r18_139].minalpha)
                end
              end
            end
          end
        end
      end
    end
  end
  function executeClientRuncode(r0_140, r1_140, r2_140)
    -- line: [1526, 1529] id: 140
    if not isLex128(r0_140) then
      return 
    end
    callClientFunction(r1_140, "executeClientRuncode", r0_140, r2_140)
  end
  function stopClientRuncode(r0_141, r1_141)
    -- line: [1530, 1533] id: 141
    if not isLex128(r0_141) then
      return 
    end
    callClientFunction(r1_141, "stopClientRuncode", r0_141)
  end
  local r3_108 = {}
  local r4_108 = {}
  local r5_108 = {}
  local r6_108 = {}
  local r7_108 = {}
  function createAddEventHandlerFunction(r0_142)
    -- line: [1539, 1552] id: 142
    return function(r0_143, r1_143, r2_143, r3_143)
      -- line: [1540, 1551] id: 143
      if type(r0_143) == "string" and isElement(r1_143) and type(r2_143) == "function" then
        if r3_143 == nil or type(r3_143) ~= "boolean" then
          r3_143 = true
        end
        if addEventHandler(r0_143, r1_143, r2_143, r3_143) then
          table.insert(r4_108[r0_142], {
            r0_143,
            r1_143,
            r2_143
          })
          return true
        end
      end
      return false
    end
  end
  function createBindKeyFunction(r0_144)
    -- line: [1553, 1571] id: 144
    return function(...)
      -- line: [1554, 1570] id: 145
      local r1_145 = {
        ...
      }
      local r2_145 = table.remove(r1_145, 1)
      local r3_145 = table.remove(r1_145, 1)
      local r4_145 = table.remove(r1_145, 1)
      local r5_145 = table.remove(r1_145, 1)
      local r6_145 = r1_145
      if not isElement(r2_145) or getElementType(r2_145) ~= "player" or type(r3_145) ~= "string" or type(r4_145) ~= "string" or type(r5_145) ~= "string" and type(r5_145) ~= "function" then
        return false
      end
      r1_145 = {
        r2_145,
        r3_145,
        r4_145,
        r5_145,
        unpack(r6_145)
      }
      if bindKey(unpack(r1_145)) then
        table.insert(r5_108[r0_144], r1_145)
        return true
      end
      return false
    end
  end
  function createAddCommandHandlerFunction(r0_146)
    -- line: [1572, 1590] id: 146
    return function(r0_147, r1_147, r2_147, r3_147)
      -- line: [1573, 1589] id: 147
      if type(r0_147) == "string" and type(r1_147) == "function" then
        local r4_147 = nil
        if type(r2_147) ~= "boolean" then
          r2_147 = false
        end
        if type(r3_147) ~= "boolean" then
          r3_147 = true
        end
        r4_147 = {
          r0_147,
          r1_147,
          r2_147,
          r3_147
        }
        if addCommandHandler(unpack(r4_147)) then
          table.insert(r6_108[r0_146], r4_147)
          return true
        end
      end
      return false
    end
  end
  function createSetTimerFunction(r0_148)
    -- line: [1591, 1602] id: 148
    return function(r0_149, r1_149, r2_149, ...)
      -- line: [1592, 1601] id: 149
      if type(r0_149) == "function" and type(r1_149) == "number" and type(r2_149) == "number" then
        local r4_149 = setTimer(r0_149, r1_149, r2_149, ...)
        if r4_149 then
          table.insert(r7_108[r0_148], r4_149)
          return r4_149
        end
      end
      return false
    end
  end
  function createRemoveEventHandlerFunction(r0_150)
    -- line: [1603, 1617] id: 150
    return function(r0_151, r1_151, r2_151)
      -- line: [1604, 1616] id: 151
      if type(r0_151) == "string" and isElement(r1_151) and type(r2_151) == "function" then
        for r6_151, r7_151 in ipairs(r4_108[r0_150]) do
          if r7_151[1] == r0_151 and r7_151[2] == r1_151 and r7_151[3] == r2_151 and removeEventHandler(unpack(r7_151)) then
            table.remove(r4_108[r0_150], r6_151)
            return true
          end
        end
      end
      return false
    end
  end
  function createUnbindKeyFunction(r0_152)
    -- line: [1618, 1642] id: 152
    return function(...)
      -- line: [1619, 1641] id: 153
      local r1_153 = {
        ...
      }
      local r2_153 = table.remove(r1_153, 1)
      local r3_153 = table.remove(r1_153, 1)
      local r4_153 = table.remove(r1_153, 1)
      local r5_153 = table.remove(r1_153, 1)
      if not isElement(r2_153) or getElementType(r2_153) ~= "player" or type(r3_153) ~= "string" then
        return false
      end
      if type(r4_153) ~= "string" or not r4_153 then
        r4_153 = nil
      end
      if type(r5_153) ~= "string" and type(r5_153) ~= "function" or not r5_153 then
        r5_153 = nil
      end
      r1_153 = {
        r2_153,
        r3_153,
        r4_153,
        r5_153
      }
      local r6_153 = false
      for r10_153, r11_153 in ipairs(r5_108[r0_152]) do
        if r11_153[1] == r1_153[1] and r11_153[2] == r1_153[2] and (not r1_153[3] or r1_153[3] == r11_153[3]) and (not r1_153[4] or r1_153[4] == r11_153[4]) and unbindKey(unpack(r11_153)) then
          table.remove(r5_108[r0_152], r10_153)
          r6_153 = true
        end
      end
      return r6_153
    end
  end
  function createRemoveCommandHandlerFunction(r0_154)
    -- line: [1643, 1658] id: 154
    return function(r0_155, r1_155)
      -- line: [1644, 1657] id: 155
      local r2_155 = false
      if type(r0_155) == "string" and type(r1_155) == "function" then
        for r6_155, r7_155 in ipairs(r6_108[r0_154]) do
          if r7_155[1] == r0_155 and (not r7_155[2] or r7_155[2] == r1_155) and removeCommandHandler(unpack(r7_155)) then
            table.remove(r6_108[r0_154], r6_155)
            r2_155 = true
          end
        end
      end
      return r2_155
    end
  end
  function createKillTimerFunction(r0_156)
    -- line: [1659, 1672] id: 156
    return function(r0_157)
      -- line: [1660, 1671] id: 157
      local r1_157 = false
      for r5_157, r6_157 in ipairs(r7_108[r0_156]) do
        if r6_157 == r0_157 and killTimer(r0_157) then
          table.remove(r7_108[r0_156], r5_157)
          r1_157 = true
        end
      end
      return r1_157
    end
  end
  function cleanEventHandlerContainer(r0_158)
    -- line: [1673, 1681] id: 158
    if not r4_108[r0_158] then
      return 
    end
    for r4_158, r5_158 in ipairs(r4_108[r0_158]) do
      if isElement(r5_158[2]) then
        removeEventHandler(unpack(r5_158))
      end
    end
    r4_108[r0_158] = nil
  end
  function cleanKeyBindContainer(r0_159)
    -- line: [1682, 1688] id: 159
    if not r5_108[r0_159] then
      return 
    end
    for r4_159, r5_159 in ipairs(r5_108[r0_159]) do
      unbindKey(unpack(r5_159))
    end
    r5_108[r0_159] = nil
  end
  function cleanCommandHandlerContainer(r0_160)
    -- line: [1689, 1695] id: 160
    if not r6_108[r0_160] then
      return 
    end
    for r4_160, r5_160 in ipairs(r6_108[r0_160]) do
      removeCommandHandler(unpack(r5_160))
    end
    r6_108[r0_160] = nil
  end
  function cleanTimerContainer(r0_161)
    -- line: [1696, 1702] id: 161
    if not r7_108[r0_161] then
      return 
    end
    for r4_161, r5_161 in ipairs(r7_108[r0_161]) do
      if isTimer(r5_161) then
        killTimer(r5_161)
      end
    end
    r7_108[r0_161] = nil
  end
  function stopRuncode(r0_162)
    -- line: [1703, 1715] id: 162
    if not isLex128(r0_162) then
      return 
    end
    if not r3_108[r0_162] then
      outputChatBox("Not running!", r0_162, 0, 128, 0, true)
      return 
    end
    cleanEventHandlerContainer(r0_162)
    cleanKeyBindContainer(r0_162)
    cleanCommandHandlerContainer(r0_162)
    cleanTimerContainer(r0_162)
    r3_108[r0_162] = nil
    outputChatBox("Stopped!", r0_162, 0, 128, 0, true)
  end
  function executeRuncode(r0_163, r1_163, ...)
    -- line: [1716, 1797] id: 163
    if not isLex128(r0_163) then
      return 
    end
    local r3_163 = ""
    for r7_163, r8_163 in pairs({
      ...
    }) do
      r3_163 = r3_163 .. " " .. r8_163
    end
    if not r4_108[r0_163] then
      r4_108[r0_163] = {}
    end
    if not r5_108[r0_163] then
      r5_108[r0_163] = {}
    end
    if not r6_108[r0_163] then
      r6_108[r0_163] = {}
    end
    if not r7_108[r0_163] then
      r7_108[r0_163] = {}
    end
    if not r3_108[r0_163] then
      r3_108[r0_163] = {
        addEventHandler = createAddEventHandlerFunction(r0_163),
        removeEventHandler = createRemoveEventHandlerFunction(r0_163),
        bindKey = createBindKeyFunction(r0_163),
        unbindKey = createUnbindKeyFunction(r0_163),
        addCommandHandler = createAddCommandHandlerFunction(r0_163),
        removeCommandHandler = createRemoveCommandHandlerFunction(r0_163),
        setTimer = createSetTimerFunction(r0_163),
        killTimer = createKillTimerFunction(r0_163),
      }
      setmetatable(r3_108[r0_163], {
        __index = _G,
      })
    end
    local r4_163 = false
    local r5_163, r6_163 = loadstring("return " .. r3_163)
    if r6_163 then
      r4_163 = true
      r5_163, r6_163 = loadstring(tostring(r3_163))
    end
    if r6_163 then
      outputChatBox("ERROR: " .. r6_163, r0_163, 255, 0, 0, true)
      return 
    end
    local r7_163 = {
      pcall(setfenv(r5_163, r3_108[r0_163]))
    }
    if not r7_163[1] then
      outputChatBox("ERROR: " .. r7_163[2], r0_163, 255, 0, 0, true)
      return 
    end
    if not r4_163 then
      local r8_163 = ""
      for r12_163 = 2, #r7_163, 1 do
        local r13_163 = ""
        if r12_163 > 2 then
          r8_163 = r8_163 .. "#00FF00, "
        end
        local r14_163 = r7_163[r12_163]
        if type(r14_163) == "table" then
          for r18_163, r19_163 in pairs(r14_163) do
            if #r13_163 > 0 then
              r13_163 = r13_163 .. ", "
            end
            if type(r18_163) == "userdata" then
              if isElement(r18_163) then
                r13_163 = r13_163 .. "#66CC66" .. getElementType(r14_163) .. "#B1B100"
              else
                r13_163 = r13_163 .. "#66CC66element#B1B100"
              end
            elseif type(r18_163) == "string" then
              r13_163 = r13_163 .. "#FF0000\"" .. r18_163 .. "\"#B1B100"
            else
              r13_163 = r13_163 .. "#000099" .. tostring(r18_163) .. "#B1B100"
            end
          end
          r13_163 = "#B1B100{" .. r13_163 .. "}"
        elseif type(r14_163) == "userdata" then
          if isElement(r14_163) then
            r13_163 = "#66CC66" .. getElementType(r14_163) .. string.gsub(tostring(r14_163), "userdata:", "")
          else
            r13_163 = "#66CC66element" .. string.gsub(tostring(r14_163), "userdata:", "")
          end
        elseif type(r14_163) == "string" then
          r13_163 = "#FF0000\"" .. r14_163 .. "\""
        elseif type(r14_163) == "function" then
          r13_163 = "#0000FF" .. tostring(r14_163)
        elseif type(r14_163) == "thread" then
          r13_163 = "#808080" .. tostring(r14_163)
        else
          r13_163 = "#000099" .. tostring(r14_163)
        end
        r8_163 = r8_163 .. r13_163
      end
      outputChatBox(string.sub("Return: " .. r8_163, 1, 128), r0_163, 0, 255, 0, true)
    elseif not r6_163 then
      outputChatBox("Executed!", r0_163, 0, 255, 0, true)
    end
  end
  function onPlayerCheckUpdates(r0_164)
    -- line: [1798, 1804] id: 164
    if not hasObjectPermissionTo(getThisResource(), "function.callRemote", false) then
      outputLangString(r0_164, "resource_have_not_permissions", getResourceName(getThisResource()), "function.callRemote")
      return 
    end
    callRemote("http://bpb-team.ru/lex128/tactics-wiki/tacticscall.php", onCallRemoteResult, "latest", r0_164)
  end
  function onCallRemoteResult(r0_165, ...)
    -- line: [1805, 1819] id: 165
    if r0_165 == "ERROR" then
      return 
    end
    if r0_165 == "latest" then
      local r2_165, r3_165, r4_165 = unpack({
        ...
      })
      local r5_165, r6_165, r7_165 = unpack(split(r3_165, string.byte(" ")))
      local r8_165, r9_165 = unpack(split(getTacticsData("version"), string.byte(" ")))
      local r10_165 = tonumber(({
        string.gsub(r7_165, "[^0-9]+", "")
      })[1]) or math.huge
      local r11_165 = tonumber(({
        string.gsub(r9_165, "[^0-9]+", "")
      })[1]) or math.huge
      if r8_165 < r6_165 or r6_165 == r8_165 and r11_165 < r10_165 then
        outputLangString(r2_165, "new_version_available", r5_165 .. " " .. r6_165 .. " " .. r7_165 .. " - " .. r4_165)
      else
        outputLangString(r2_165, "this_last_version", "Tactics " .. r8_165 .. " " .. r9_165)
      end
    end
  end
  function onPlayerAdminchat(r0_166, r1_166, ...)
    -- line: [1820, 1834] id: 166
    if isPlayerMuted(r0_166) then
      return outputChatBox("adminsay: You are muted", r0_166, 255, 168, 0)
    end
    local r4_166 = table.concat({
      ...
    }, " ")
    outputServerLog("ADMINCHAT: " .. getPlayerName(r0_166) .. ": " .. r4_166)
    local r5_166 = "FFFFFF"
    local r6_166 = getPlayerTeam(r0_166)
    if r6_166 then
      r5_166 = string.format("%02X%02X%02X", getTeamColor(r6_166))
    end
    r4_166 = "(ADMIN) #" .. r5_166 .. getPlayerName(r0_166) .. " (" .. getElementID(r0_166) .. "): #EBDDB2" .. r4_166
    for r10_166, r11_166 in ipairs(getElementsByType("player")) do
      if r11_166 ~= r0_166 then
        local r12_166 = hasObjectPermissionTo(r11_166, "general.tactics_adminchat", false)
        if r12_166 then
          ::label_71::
          outputChatBox(r4_166, r11_166, 255, 100, 100, true)
        end
      else
        goto label_71	-- block#7 is visited secondly
      end
    end
  end
  function nextCyclerMap(r0_167)
    -- line: [1835, 1848] id: 167
    if not hasObjectPermissionTo(r0_167, "general.tactics_maps", false) then
      return outputLangString(r0_167, "you_have_not_permissions")
    end
    local r1_167 = getTacticsData("Resources")
    local r2_167 = getTacticsData("ResourceNext")
    if r1_167 and 0 < #r1_167 then
      local r3_167 = (getTacticsData("ResourceCurrent") or tonumber(0)) + 1
      if #r1_167 < r3_167 then
        r3_167 = 1
      end
      startMap(r1_167[r3_167][1], r3_167)
    elseif getTacticsData("ResourceNext") then
      nextMap()
    end
  end
  function previousCyclerMap(r0_168)
    -- line: [1849, 1858] id: 168
    if not hasObjectPermissionTo(r0_168, "general.tactics_maps", false) then
      return outputLangString(r0_168, "you_have_not_permissions")
    end
    local r1_168 = getTacticsData("Resources")
    if not r1_168 or #r1_168 == 0 then
      return 
    end
    local r2_168 = (getTacticsData("ResourceCurrent") or #r1_168 + 1) - 1
    if r2_168 <= 0 then
      r2_168 = #r1_168
    end
    startMap(r1_168[r2_168][1], r2_168)
  end
  function sayFromAdmin(r0_169, r1_169, ...)
    -- line: [1859, 1869] id: 169
    if not hasObjectPermissionTo(r0_169, "general.tactics_adminchat", false) then
      return outputLangString(r0_169, "you_have_not_permissions")
    end
    if isPlayerMuted(r0_169) then
      return outputChatBox("asay: You are muted", r0_169, 255, 168, 0)
    end
    local r4_169 = table.concat({
      ...
    }, " ")
    outputServerLog("ADMIN: " .. r4_169)
    outputChatBox("ADMIN: #EBDDB2" .. r4_169, root, 255, 100, 100, true)
  end
  function changeWeaponProperty(r0_170, r1_170, r2_170, r3_170, r4_170, r5_170, r6_170, r7_170, r8_170, r9_170, r10_170, r11_170, r12_170, r13_170, r14_170, r15_170)
    -- line: [1870, 1910] id: 170
    if not hasObjectPermissionTo(r0_170, "general.tactics_shooting", false) then
      return outputLangString(r0_170, "you_have_not_permissions")
    end
    setWeaponProperty(r1_170, "pro", "weapon_range", r2_170)
    setWeaponProperty(r1_170, "pro", "target_range", r3_170)
    setWeaponProperty(r1_170, "pro", "accuracy", r4_170)
    setWeaponProperty(r1_170, "pro", "damage", tostring(tonumber(r5_170) * 3))
    setWeaponProperty(r1_170, "pro", "maximum_clip_ammo", r6_170)
    setWeaponProperty(r1_170, "pro", "move_speed", r7_170)
    setWeaponProperty(r1_170, "pro", "anim_loop_start", r8_170)
    setWeaponProperty(r1_170, "pro", "anim_loop_stop", r9_170)
    setWeaponProperty(r1_170, "pro", "anim_loop_bullet_fire", r10_170)
    setWeaponProperty(r1_170, "pro", "anim2_loop_start", r11_170)
    setWeaponProperty(r1_170, "pro", "anim2_loop_stop", r12_170)
    setWeaponProperty(r1_170, "pro", "anim2_loop_bullet_fire", r13_170)
    setWeaponProperty(r1_170, "pro", "anim_breakout_time", r14_170)
    local r16_170 = string.reverse(string.format("%04X", getWeaponProperty(r1_170, "pro", "flags")))
    for r20_170 = 1, 4, 1 do
      local r21_170 = tonumber(string.sub(r16_170, r20_170, r20_170), 16)
      if r21_170 then
        for r25_170 = 3, 0, -1 do
          local r26_170 = 2 ^ r25_170
          if r26_170 <= r21_170 then
            if not r15_170[r20_170][r26_170] then
              setWeaponProperty(r1_170, "pro", "flags", tonumber("0x" .. string.rep("0", 6 - r20_170) .. tostring(r26_170) .. string.rep("0", r20_170 - 1)))
            end
            r21_170 = r21_170 - r26_170
          elseif r15_170[r20_170][r26_170] then
            setWeaponProperty(r1_170, "pro", "flags", tonumber("0x" .. string.rep("0", 6 - r20_170) .. tostring(r26_170) .. string.rep("0", r20_170 - 1)))
          end
        end
      else
        if r15_170[r20_170][1] then
          setWeaponProperty(r1_170, "pro", "flags", tonumber("0x" .. string.rep("0", 6 - r20_170) .. "1" .. string.rep("0", r20_170 - 1)))
        end
        if r15_170[r20_170][2] then
          setWeaponProperty(r1_170, "pro", "flags", tonumber("0x" .. string.rep("0", 6 - r20_170) .. "2" .. string.rep("0", r20_170 - 1)))
        end
        if r15_170[r20_170][3] then
          setWeaponProperty(r1_170, "pro", "flags", tonumber("0x" .. string.rep("0", 6 - r20_170) .. "4" .. string.rep("0", r20_170 - 1)))
        end
        if r15_170[r20_170][4] then
          setWeaponProperty(r1_170, "pro", "flags", tonumber("0x" .. string.rep("0", 6 - r20_170) .. "8" .. string.rep("0", r20_170 - 1)))
        end
      end
    end
    return callClientFunction(r0_170, "refreshWeaponProperties")
  end
  function resetWeaponProperty(r0_171, r1_171)
    -- line: [1911, 1972] id: 171
    if not hasObjectPermissionTo(r0_171, "general.tactics_shooting", false) then
      return outputLangString(r0_171, "you_have_not_permissions")
    end
    setWeaponProperty(r1_171, "pro", "weapon_range", getOriginalWeaponProperty(r1_171, "pro", "weapon_range"))
    setWeaponProperty(r1_171, "pro", "target_range", getOriginalWeaponProperty(r1_171, "pro", "target_range"))
    setWeaponProperty(r1_171, "pro", "accuracy", getOriginalWeaponProperty(r1_171, "pro", "accuracy"))
    setWeaponProperty(r1_171, "pro", "damage", getOriginalWeaponProperty(r1_171, "pro", "damage"))
    setWeaponProperty(r1_171, "pro", "maximum_clip_ammo", getOriginalWeaponProperty(r1_171, "pro", "maximum_clip_ammo"))
    setWeaponProperty(r1_171, "pro", "move_speed", getOriginalWeaponProperty(r1_171, "pro", "move_speed"))
    setWeaponProperty(r1_171, "pro", "anim_loop_start", getOriginalWeaponProperty(r1_171, "pro", "anim_loop_start"))
    setWeaponProperty(r1_171, "pro", "anim_loop_stop", getOriginalWeaponProperty(r1_171, "pro", "anim_loop_stop"))
    setWeaponProperty(r1_171, "pro", "anim_loop_bullet_fire", getOriginalWeaponProperty(r1_171, "pro", "anim_loop_bullet_fire"))
    setWeaponProperty(r1_171, "pro", "anim2_loop_start", getOriginalWeaponProperty(r1_171, "pro", "anim2_loop_start"))
    setWeaponProperty(r1_171, "pro", "anim2_loop_stop", getOriginalWeaponProperty(r1_171, "pro", "anim2_loop_stop"))
    setWeaponProperty(r1_171, "pro", "anim2_loop_bullet_fire", getOriginalWeaponProperty(r1_171, "pro", "anim2_loop_bullet_fire"))
    setWeaponProperty(r1_171, "pro", "anim_breakout_time", getOriginalWeaponProperty(r1_171, "pro", "anim_breakout_time"))
    local r2_171 = string.reverse(string.format("%04X", getOriginalWeaponProperty(r1_171, "pro", "flags")))
    local r3_171 = string.reverse(string.format("%04X", getWeaponProperty(r1_171, "pro", "flags")))
    local r4_171 = {
      {},
      {},
      {},
      {},
      {}
    }
    for r8_171 = 1, 4, 1 do
      local r9_171 = tonumber(string.sub(r2_171, r8_171, r8_171), 16)
      if r9_171 then
        for r13_171 = 3, 0, -1 do
          local r14_171 = 2 ^ r13_171
          if r14_171 <= r9_171 then
            r4_171[r8_171][r14_171] = true
            r9_171 = r9_171 - r14_171
          else
            r4_171[r8_171][r14_171] = false
          end
        end
      else
        r4_171[r8_171][1] = false
        r4_171[r8_171][2] = false
        r4_171[r8_171][4] = false
        r4_171[r8_171][8] = false
      end
    end
    for r8_171 = 1, 4, 1 do
      local r9_171 = tonumber(string.sub(r3_171, r8_171, r8_171), 16)
      if r9_171 then
        for r13_171 = 3, 0, -1 do
          local r14_171 = 2 ^ r13_171
          if r14_171 <= r9_171 then
            if not r4_171[r8_171][r14_171] then
              setWeaponProperty(r1_171, "pro", "flags", tonumber("0x" .. string.rep("0", 6 - r8_171) .. tostring(r14_171) .. string.rep("0", r8_171 - 1)))
            end
            r9_171 = r9_171 - r14_171
          elseif r4_171[r8_171][r14_171] then
            setWeaponProperty(r1_171, "pro", "flags", tonumber("0x" .. string.rep("0", 6 - r8_171) .. tostring(r14_171) .. string.rep("0", r8_171 - 1)))
          end
        end
      else
        if r4_171[r8_171][8] then
          setWeaponProperty(r1_171, "pro", "flags", tonumber("0x" .. string.rep("0", 6 - r8_171) .. "8" .. string.rep("0", r8_171 - 1)))
        end
        if r4_171[r8_171][4] then
          setWeaponProperty(r1_171, "pro", "flags", tonumber("0x" .. string.rep("0", 6 - r8_171) .. "4" .. string.rep("0", r8_171 - 1)))
        end
        if r4_171[r8_171][2] then
          setWeaponProperty(r1_171, "pro", "flags", tonumber("0x" .. string.rep("0", 6 - r8_171) .. "2" .. string.rep("0", r8_171 - 1)))
        end
        if r4_171[r8_171][1] then
          setWeaponProperty(r1_171, "pro", "flags", tonumber("0x" .. string.rep("0", 6 - r8_171) .. "1" .. string.rep("0", r8_171 - 1)))
        end
      end
    end
    return callClientFunction(r0_171, "refreshWeaponProperties")
  end
  function addAnticheatModsearch(r0_172, r1_172, r2_172)
    -- line: [1973, 1977] id: 172
    local r3_172 = getTacticsData("anticheat", "modslist") or {}
    table.insert(r3_172, {
      name = r0_172,
      search = r1_172,
      type = r2_172,
    })
    setTacticsData(r3_172, "anticheat", "modslist")
  end
  function setAnticheatModsearch(r0_173, r1_173, r2_173, r3_173)
    -- line: [1978, 1983] id: 173
    local r4_173 = getTacticsData("anticheat", "modslist") or {}
    if not r4_173[(r0_173 + 1)] then
      return 
    end
    r4_173[r0_173 + 1] = {
      name = r1_173,
      search = r2_173,
      type = r3_173,
    }
    setTacticsData(r4_173, "anticheat", "modslist")
  end
  function removeAnticheatModsearch(r0_174)
    -- line: [1984, 1988] id: 174
    local r1_174 = getTacticsData("anticheat", "modslist") or {}
    table.remove(r1_174, r0_174 + 1)
    setTacticsData(r1_174, "anticheat", "modslist")
  end
  function changeVehicleHandling(r0_175, r1_175, r2_175)
    -- line: [1989, 2025] id: 175
    if not hasObjectPermissionTo(r0_175, "general.tactics_handling", false) then
      return outputLangString(r0_175, "you_have_not_permissions")
    end
    local r3_175 = getTacticsData("handlings") or {}
    if not r3_175[r1_175] then
      r3_175[r1_175] = {
        nil
      }
    end
    local r4_175 = getOriginalHandling(r1_175)
    for r8_175, r9_175 in pairs(r2_175) do
      if type(r9_175) == "boolean" and r4_175[r8_175] == r9_175 then
        r3_175[r1_175][r8_175] = nil
      elseif r8_175 == "sirens" then
        if r9_175.count == 0 then
          r3_175[r1_175][r8_175] = nil
        else
          r3_175[r1_175][r8_175] = r9_175
        end
      elseif type(r9_175) == "table" and string.format("%.3f", r4_175[r8_175][1]) == string.format("%.3f", r9_175[1]) and string.format("%.3f", r4_175[r8_175][2]) == string.format("%.3f", r9_175[2]) and string.format("%.3f", r4_175[r8_175][3]) == string.format("%.3f", r9_175[3]) then
        r3_175[r1_175][r8_175] = nil
      elseif type(r9_175) == "number" and string.format("%.3f", r4_175[r8_175]) == string.format("%.3f", r9_175) then
        r3_175[r1_175][r8_175] = nil
      elseif type(r9_175) == "string" and (r8_175 == "modelFlags" or r8_175 == "handlingFlags") and string.format("0x%08X", r4_175[r8_175]) == r9_175 then
        r3_175[r1_175][r8_175] = nil
      elseif type(r9_175) == "string" and r4_175[r8_175] == r9_175 then
        r3_175[r1_175][r8_175] = nil
      elseif r9_175 ~= nil then
        r3_175[r1_175][r8_175] = r9_175
      end
    end
    setTacticsData(r3_175, "handlings")
  end
  function resetVehicleHandling(r0_176, r1_176)
    -- line: [2026, 2033] id: 176
    if not hasObjectPermissionTo(r0_176, "general.tactics_handling", false) then
      return outputLangString(r0_176, "you_have_not_permissions")
    end
    local r2_176 = getTacticsData("handlings") or {}
    r2_176[r1_176] = nil
    setTacticsData(r2_176, "handlings")
  end
  function onPlayerScreenShot(r0_177, r1_177, r2_177, r3_177, r4_177)
    -- line: [2034, 2048] id: 177
    if r0_177 ~= getThisResource() and r0_177 ~= "disabled" then
      return 
    end
    local r5_177 = getRealTime()
    local r6_177, r7_177, r8_177, r9_177 = unpack(split(r4_177, " "))
    local r10_177 = string.format("%s_%04i-%02i-%02i_%02i-%02i-%02i", getPlayerName(source):gsub("[\\/:*?\"<>|]", "-"):gsub("-+", "-"):gsub("-$", ""):gsub("^-", ""), r5_177.year + 1900, r5_177.month + 1, r5_177.monthday, r5_177.hour, r5_177.minute, r5_177.second)
    local r11_177 = getPlayerFromName(r6_177)
    if not r11_177 then
      return 
    end
    if r1_177 == "disabled" then
      outputDebugString("takeDisabledScreenShot")
      triggerClientEvent(source, "takeDisabledScreenShot", source, r4_177)
      return 
    end
    outputDebugString("2 = " .. #r2_177)
    triggerClientEvent(r11_177, "onClientPlayerScreenShot", source, r1_177, r2_177, r7_177, r8_177, r10_177)
  end
  function connectPlayers(r0_178, r1_178, r2_178, r3_178, r4_178)
    -- line: [2049, 2061] id: 178
    if not hasObjectPermissionTo(getThisResource(), "function.redirectPlayer", false) then
      return outputLangString(r0_178, "resource_have_not_permissions", getResourceName(getThisResource()), "function.redirectPlayer")
    end
    if r2_178 and r3_178 then
      for r8_178, r9_178 in ipairs(r1_178) do
        redirectPlayer(r9_178, tostring(r2_178), tonumber(r3_178), r4_178)
      end
    end
  end
  addEvent("onPlayerDisabledScreenShot", true)
  addCommandHandler("exe", executeRuncode, false, false)
  addCommandHandler("exestop", stopRuncode, false, false)
  addCommandHandler("end", onRoundStop, false, false)
  addCommandHandler("add", addPlayer, false, false)
  addCommandHandler("remove", removePlayer, false, false)
  addCommandHandler("restore", restorePlayer, false, false)
  addCommandHandler("balance", balanceTeams, false, false)
  addCommandHandler("Adminsay", onPlayerAdminchat, false, false)
  addCommandHandler("asay", sayFromAdmin, false, false)
  addCommandHandler("next", nextCyclerMap, false, false)
  addCommandHandler("prev", previousCyclerMap, false, false)
  addCommandHandler("previous", previousCyclerMap, false, false)
  addEventHandler("onResourceStart", resourceRoot, onResourceStart)
  addEventHandler("onPlayerJoin", root, onPlayerJoin)
  addEventHandler("onPlayerLogin", root, onPlayerLogin)
  addEventHandler("onElementDataChange", root, onElementDataChange)
  addEventHandler("onTacticsChange", root, onTacticsChange)
  addEventHandler("onPlayerScreenShot", root, onPlayerScreenShot)
  addEventHandler("onPlayerDisabledScreenShot", root, onPlayerScreenShot)
end)()
(function(...)
  -- line: [0, 0] id: 179
  function onTacticsChange(r0_180, r1_180)
    -- line: [7, 25] id: 180
    if r0_180[1] == "anticheat" then
      if r0_180[2] == "mods" then
        if getTacticsData("anticheat", "mods") == "true" then
          addEventHandler("onPlayerModInfo", root, modifications_onPlayerModInfo)
          for r5_180, r6_180 in ipairs(getElementsByType("player")) do
            resendPlayerModInfo(r6_180)
          end
        else
          removeEventHandler("onPlayerModInfo", root, modifications_onPlayerModInfo)
        end
      end
      if r0_180[2] == "modslist" and getTacticsData("anticheat", "mods") == "true" then
        for r5_180, r6_180 in ipairs(getElementsByType("player")) do
          resendPlayerModInfo(r6_180)
        end
      end
    end
  end
  addEventHandler("onTacticsChange", root, onTacticsChange)
  function modifications_onPlayerModInfo(r0_181, r1_181)
    -- line: [27, 54] id: 181
    local r2_181 = getTacticsData("anticheat", "modslist")
    local r3_181 = {}
    local r4_181 = {}
    local r5_181 = {}
    for r9_181, r10_181 in ipairs(r2_181) do
      table.insert(r3_181, {
        search = r10_181.search:gsub("*", ".+"),
        type = r10_181.type,
      })
      table.insert(r4_181, 0)
      table.insert(r5_181, "")
    end
    local r6_181 = false
    for r10_181, r11_181 in ipairs(r1_181) do
      for r15_181, r16_181 in ipairs(r3_181) do
        if string.match(r11_181[r16_181.type], r16_181.search) then
          r6_181 = true
          r4_181[r15_181] = r4_181[r15_181] + 1
          r5_181[r15_181] = r11_181.name
        end
      end
    end
    if r6_181 then
      local r7_181 = ""
      for r11_181 in ipairs(r3_181) do
        if r4_181[r11_181] > 0 then
          r7_181 = r7_181 .. string.format(" %i/%s", r4_181[r11_181], r5_181[r11_181])
        end
      end
      doPunishment(source, "Mods" .. r7_181)
    end
  end
  function doPunishment(r0_182, r1_182)
    -- line: [55, 76] id: 182
    local r2_182 = getTacticsData("anticheat", "action_detection")
    if r2_182 == "chat" then
      outputLangString(root, "player_cheat_detected", getPlayerName(r0_182), r1_182)
    elseif r2_182 == "adminchat" then
      for r6_182, r7_182 in ipairs(getElementsByType("player")) do
        if hasObjectPermissionTo(r7_182, "general.tactics_adminchat", false) then
          outputLangString(r7_182, "player_cheat_detected", getPlayerName(r0_182), r1_182)
        end
      end
    elseif r2_182 == "kick" then
      if hasObjectPermissionTo(getThisResource(), "function.kickPlayer", false) then
        kickPlayer(r0_182, r1_182)
      else
        for r6_182, r7_182 in ipairs(getElementsByType("player")) do
          if hasObjectPermissionTo(r7_182, "general.tactics_adminchat", false) then
            outputLangString(r7_182, "resource_have_not_permissions", getResourceName(getThisResource()), "function.kickPlayer")
          end
        end
      end
    end
  end
end)()
(function(...)
  -- line: [0, 0] id: 183
  function pickupWeapon(r0_184, r1_184)
    -- line: [7, 17] id: 184
    if not isElement(r1_184) then
      return 
    end
    if triggerEvent("onWeaponPickup", r0_184, r1_184) == false then
      return 
    end
    local r2_184 = getPickupWeapon(r1_184)
    local r3_184 = getPickupAmmo(r1_184)
    local r4_184 = getElementData(r1_184, "Clip")
    destroyElement(r1_184)
    giveWeapon(r0_184, r2_184, r3_184, true)
    if r4_184 then
      setWeaponAmmo(r0_184, r2_184, r3_184, r4_184)
    end
  end
  function replaceWeapon(r0_185, r1_185, r2_185)
    -- line: [18, 40] id: 185
    if not isElement(r1_185) then
      return 
    end
    if triggerEvent("onWeaponPickup", r0_185, r1_185) == false then
      return 
    end
    local r3_185 = getPedWeapon(r0_185, r2_185)
    local r4_185 = getPedTotalAmmo(r0_185, r2_185)
    local r5_185 = getPedAmmoInClip(r0_185, r2_185)
    if r3_185 > 0 then
      local r6_185 = createWeaponUnderPlayer(r0_185, r3_185, r4_185, r5_185)
      if triggerEvent("onWeaponDrop", r0_185, r6_185) == false then
        if isElement(r6_185) then
          destroyElement(r6_185)
        end
        return 
      else
        takeWeapon(r0_185, r3_185)
      end
    end
    local r6_185 = getPickupWeapon(r1_185)
    local r7_185 = getPickupAmmo(r1_185)
    local r8_185 = getElementData(r1_185, "Clip")
    destroyElement(r1_185)
    giveWeapon(r0_185, r6_185, r7_185, true)
    if r8_185 then
      setWeaponAmmo(r0_185, r6_185, r7_185, r8_185)
    end
  end
  function dropWeapon(r0_186, r1_186)
    -- line: [41, 54] id: 186
    local r2_186 = getPedWeapon(r0_186, r1_186)
    local r3_186 = getPedTotalAmmo(r0_186, r1_186)
    local r4_186 = getPedAmmoInClip(r0_186, r1_186)
    if r2_186 > 0 then
      local r5_186 = createWeaponUnderPlayer(r0_186, r2_186, r3_186, r4_186)
      if triggerEvent("onWeaponDrop", r0_186, r5_186) == false then
        if isElement(r5_186) then
          destroyElement(r5_186)
        end
      else
        takeWeapon(r0_186, r2_186)
      end
    end
  end
  function createWeaponUnderPlayer(r0_187, r1_187, r2_187, r3_187)
    -- line: [55, 66] id: 187
    if 0 < r1_187 and 0 < r2_187 and r3_187 then
      local r4_187, r5_187, r6_187 = getElementPosition(r0_187)
      local r7_187 = createPickup(r4_187 + 0.2 * math.random(-5, 5), r5_187 + 0.2 * math.random(-5, 5), r6_187 - 0.5, 2, r1_187, 0, r2_187)
      setElementParent(r7_187, getRoundMapDynamicRoot())
      setElementData(r7_187, "Clip", r3_187)
      setElementInterior(r7_187, getElementInterior(r0_187))
      setElementDimension(r7_187, getElementDimension(r0_187))
      return r7_187
    end
    return false
  end
  function onPlayerWasted(r0_188, r1_188, r2_188, r3_188, r4_188)
    -- line: [67, 69] id: 188
    dropWeapon(source)
  end
  function onPickupUse(r0_189)
    -- line: [70, 72] id: 189
    cancelEvent()
  end
  addEvent("onWeaponDrop")
  addEvent("onWeaponPickup")
  addEventHandler("onPlayerWasted", root, onPlayerWasted)
  addEventHandler("onPickupUse", root, onPickupUse)
end)()
(function(...)
  -- line: [0, 0] id: 190
  local r0_190 = {}
  function setTabboardColumns(r0_191)
    -- line: [8, 12] id: 191
    if not r0_191 then
      r0_191 = {}
    end
    r0_190 = r0_191
    triggerClientEvent(root, "onClientTabboardChange", root, r0_191)
  end
  function onPlayerDownloadComplete()
    -- line: [13, 15] id: 192
    triggerClientEvent(source, "onClientTabboardChange", root, r0_190, getServerName(), getMaxPlayers(), getVersion())
  end
  function getElementStat(r0_193, r1_193)
    -- line: [16, 22] id: 193
    if not isElement(r0_193) or getElementType(r0_193) ~= "player" and getElementType(r0_193) ~= "team" then
      return false
    end
    local r2_193 = getElementData(r0_193, r1_193)
    if type(r2_193) == "nil" then
      r2_193 = 0
    end
    if type(r2_193) ~= "number" then
      return false
    end
    return r2_193
  end
  function setElementStat(r0_194, r1_194, r2_194)
    -- line: [23, 29] id: 194
    if not isElement(r0_194) or getElementType(r0_194) ~= "player" and getElementType(r0_194) ~= "team" then
      return false
    end
    local r3_194 = getElementData(r0_194, r1_194)
    if type(r3_194) == "nil" then
      r3_194 = 0
    end
    if type(r3_194) ~= "number" then
      return false
    end
    return setElementData(r0_194, r3_194, r2_194)
  end
  function giveElementStat(r0_195, r1_195, r2_195)
    -- line: [30, 36] id: 195
    if not isElement(r0_195) or getElementType(r0_195) ~= "player" and getElementType(r0_195) ~= "team" then
      return false
    end
    local r3_195 = getElementData(r0_195, r1_195)
    if type(r3_195) == "nil" then
      r3_195 = 0
    end
    if type(r3_195) ~= "number" then
      return false
    end
    return setElementData(r0_195, r3_195, r3_195 + r2_195)
  end
  addEventHandler("onPlayerDownloadComplete", root, onPlayerDownloadComplete)
end)()
(function(...)
  -- line: [0, 0] id: 196
  local r0_196 = {
    invulnerable = true,
    invisible = true,
    freezable = true,
    flammable = true,
    movespeed = true,
    regenerable = true,
    wallhack = true,
  }
  function setPlayerProperty(r0_197, r1_197, r2_197)
    -- line: [14, 23] id: 197
    if not r0_196[r1_197] then
      return false
    end
    local r3_197 = getElementData(r0_197, "Properties") or {}
    if r2_197 ~= nil and r2_197 ~= false then
      r3_197[r1_197] = r2_197
    else
      r3_197[r1_197] = nil
    end
    return setElementData(r0_197, "Properties", r3_197)
  end
  function givePlayerProperty(r0_198, r1_198, r2_198, r3_198)
    -- line: [24, 33] id: 198
    if not r0_196[r1_198] then
      return false
    end
    local r4_198 = getElementData(r0_198, "Properties") or {}
    if r2_198 ~= nil and r2_198 ~= false then
      r4_198[r1_198] = {
        r2_198,
        r3_198
      }
    else
      r4_198[r1_198] = nil
    end
    return setElementData(r0_198, "Properties", r4_198)
  end
  function getPlayerProperty(r0_199, r1_199)
    -- line: [34, 41] id: 199
    if not r0_199 or not isElement(r0_199) or not r0_196[r1_199] then
      return false
    end
    local r2_199 = getElementData(r0_199, "Properties") or {}
    if type(r2_199[r1_199]) == "table" then
      return unpack(r2_199[r1_199])
    end
    return r2_199[r1_199]
  end
end)()
(function(...)
  -- line: [0, 0] id: 200
  local r0_200 = nil	-- notice: implicit variable refs by block#[0]
  local r1_200 = {}
  local function r2_200(r0_201)
    -- line: [9, 24] id: 201
    local r1_201 = getResourceFromName(r0_201.resname)
    if r1_201 then
      setTacticsData(nil, "voting")
      if getTacticsData("Map") == "lobby" then
        startMap(r1_201, "vote")
      elseif getTacticsData("automatics") == "voting" and winTimer == "voting" then
        startMap(r1_201, "vote")
      else
        setTacticsData(r0_201.resname, "ResourceNext")
        outputLangString(root, "map_set_next", r0_201.label)
      end
      return true
    end
    return false
  end
  function createVoting(r0_202, r1_202)
    -- line: [25, 44] id: 202
    local r2_202 = getTacticsData("voting")
    if r2_202 and r2_202.finish and r2_202.finish < getTickCount() then
      if isTimer(r0_200) then
        killTimer(r0_200)
      end
      setTacticsData(nil, "voting")
    elseif not r2_202 then
      local r3_202 = TimeToSec(getTacticsData("settings", "vote_duration") or "0:20")
      r1_200 = {}
      for r7_202 in ipairs(r0_202) do
        table.insert(r1_200, r0_202[r7_202].func)
        r0_202[r7_202].num = r7_202
      end
      r2_202 = {
        rows = r0_202,
        cancel = 0,
        finish = getTickCount() + r3_202 * 1000,
        name = r1_202,
      }
      if isTimer(r0_200) then
        killTimer(r0_200)
      end
      r0_200 = setTimer(onVotingFinish, r3_202 * 1000, 1, r1_202)
      setTacticsData(r2_202, "voting")
      return true
    end
    return false
  end
  function stopVoting(r0_203)
    -- line: [45, 52] id: 203
    if not getTacticsData("voting") or type(r0_203) == "userdata" and not hasObjectPermissionTo(r0_203, "general.tactics_maps", false) then
      return false
    end
    if type(r0_203) == "string" and r0_203 ~= getTacticsData("voting").name then
      return false
    end
    if isTimer(r0_200) then
      killTimer(r0_200)
    end
    setTacticsData(nil, "voting")
    outputLangString(root, "voting_canceled")
    return true
  end
  function getVotingInfo()
    -- line: [53, 55] id: 204
    return getTacticsData("voting") or {}
  end
  function onPlayerVote(r0_205, r1_205, r2_205)
    -- line: [56, 200] id: 205
    local r3_205 = getElementType(source)
    if r3_205 == "player" then
      r3_205 = getPlayerName(source)
      if not r3_205 then
        ::label_10::
        r3_205 = getElementType(source)
        if r3_205 == "team" then
          r3_205 = getTeamName(source) or "Console"
        else
          goto label_20	-- block#4 is visited secondly
        end
      end
    else
      goto label_10	-- block#2 is visited secondly
    end
    local r4_205 = getTacticsData("voting")
    if r2_205 ~= nil and r4_205 and r2_205 ~= r4_205.name then
      return 
    end
    if r4_205 and r4_205.finish and r4_205.finish < getTickCount() then
      if isTimer(r0_200) then
        killTimer(r0_200)
      end
      return setTacticsData(nil, "voting")
    end
    if not r0_205 then
      r4_205 = getTacticsData("voting")
      if r4_205 and r4_205.rows and 0 < #r4_205.rows and r4_205.cancel then
        if r1_205 and 0 < r1_205 then
          r4_205.rows[r1_205].votes = r4_205.rows[r1_205].votes - 1
        end
        if r1_205 == 0 then
          r4_205.cancel = r4_205.cancel - 1
        end
        return setTacticsData(r4_205, "voting")
      end
    elseif type(r0_205) == "table" then
      r4_205 = getTacticsData("voting")
      local r5_205 = TimeToSec(getTacticsData("settings", "vote_duration") or "0:20")
      local r6_205 = ""
      local r7_205 = getTacticsData("map_disabled") or {}
      for r11_205, r12_205 in ipairs(r0_205) do
        local r13_205, r14_205 = unpack(r12_205)
        local r15_205 = ""
        local r16_205 = ""
        if string.find(r13_205, "_") ~= nil then
          r16_205 = string.lower(string.sub(r13_205, 1, string.find(r13_205, "_") - 1))
        end
        local r17_205 = getResourceFromName(r13_205)
        if r17_205 and 0 < #r16_205 and getTacticsData("modes", r16_205, "enable") ~= "false" and not r7_205[r13_205] then
          r15_205 = getResourceInfo(r17_205, "name")
          if not r15_205 then
            r15_205 = string.sub(string.gsub(getResourceName(r17_205), "_", " "), #r16_205 + 2)
            if #r15_205 > 1 then
              r15_205 = string.upper(string.sub(r15_205, 1, 1)) .. string.sub(r15_205, 2)
            end
          end
          r15_205 = string.upper(string.sub(r16_205, 1, 1)) .. string.sub(r16_205, 2) .. ": " .. r15_205
        elseif r3_205 ~= "Console" then
          outputLangString(source, "voting_notexist")
          return 
        end
        if r4_205 and r4_205.rows and 0 < #r4_205.rows and r4_205.cancel then
          if #r4_205.rows > 8 then
            return 
          end
          for r21_205, r22_205 in ipairs(r4_205.rows) do
            if r22_205[1] == r13_205 then
              return 
            end
          end
          table.insert(r1_200, r2_200)
          table.insert(r4_205.rows, {
            resname = r13_205,
            votes = 0,
            cteator = r3_205,
            label = r15_205,
            num = #r1_200,
          })
        else
          if getElementType(source) == "player" then
            if getTacticsData("automatics") == "lobby" and getTacticsData("Map") ~= "lobby" then
              outputLangString(source, "voting_disabled")
              return 
            end
            if getTacticsData("settings", "vote") == "false" then
              outputLangString(source, "voting_disabled")
              return 
            end
          end
          r4_205 = {
            rows = {
              {
                resname = r13_205,
                votes = 0,
                creator = r3_205,
                label = r15_205,
                num = 1,
              }
            },
            cancel = 0,
            start = getTickCount() + r5_205 * 1000,
            name = r2_205,
          }
          r1_200 = {
            r2_200
          }
        end
        if #r6_205 == 0 then
          r6_205 = r15_205
        else
          r6_205 = r6_205 .. ", " .. r15_205
        end
      end
      if isTimer(r0_200) then
        killTimer(r0_200)
      end
      r0_200 = setTimer(onVotingFinish, r5_205 * 1000, 1)
      if r3_205 ~= "Console" then
        outputLangString(root, "voting_start", r3_205, r6_205)
      end
      return setTacticsData(r4_205, "voting")
    elseif type(r0_205) == "string" then
      r4_205 = getTacticsData("voting")
      local r5_205 = ""
      local r6_205 = ""
      if string.find(r0_205, "_") ~= nil then
        r6_205 = string.lower(string.sub(r0_205, 1, string.find(r0_205, "_") - 1))
      end
      local r7_205 = getTacticsData("map_disabled") or {}
      local r8_205 = getResourceFromName(r0_205)
      if r8_205 and 0 < #r6_205 and getTacticsData("modes", r6_205, "enable") ~= "false" and not r7_205[r0_205] then
        r5_205 = getResourceInfo(r8_205, "name")
        if not r5_205 then
          r5_205 = string.sub(string.gsub(getResourceName(r8_205), "_", " "), #r6_205 + 2)
          if #r5_205 > 1 then
            r5_205 = string.upper(string.sub(r5_205, 1, 1)) .. string.sub(r5_205, 2)
          end
        end
        r5_205 = string.upper(string.sub(r6_205, 1, 1)) .. string.sub(r6_205, 2) .. ": " .. r5_205
      elseif r3_205 ~= "Console" then
        outputLangString(source, "voting_notexist")
        return 
      end
      if r4_205 and r4_205.rows and 0 < #r4_205.rows and r4_205.cancel then
        if #r4_205.rows > 8 then
          return 
        end
        for r12_205, r13_205 in ipairs(r4_205.rows) do
          if r13_205[1] == r0_205 then
            return 
          end
        end
        table.insert(r1_200, r2_200)
        table.insert(r4_205.rows, {
          resname = r0_205,
          votes = 0,
          creator = r3_205,
          label = r5_205,
          num = #r1_200,
        })
        if r3_205 ~= "Console" then
          outputLangString(root, "voting_start", r3_205, r5_205)
        end
      else
        if getElementType(source) == "player" then
          if getTacticsData("automatics") == "lobby" and getTacticsData("Map") ~= "lobby" then
            outputLangString(source, "voting_disabled")
            return 
          end
          if getTacticsData("settings", "vote") == "false" then
            outputLangString(source, "voting_disabled")
            return 
          end
        end
        local r9_205 = TimeToSec(getTacticsData("settings", "vote_duration") or "0:20")
        r4_205 = {
          rows = {
            {
              resname = r0_205,
              votes = 0,
              creator = r3_205,
              label = r5_205,
              num = 1,
            }
          },
          cancel = 0,
          start = getTickCount() + r9_205 * 1000,
          name = r2_205,
        }
        r1_200 = {
          r2_200
        }
        if isTimer(r0_200) then
          killTimer(r0_200)
        end
        r0_200 = setTimer(onVotingFinish, r9_205 * 1000, 1)
        if r3_205 ~= "Console" then
          outputLangString(root, "voting_start", r3_205, r5_205)
        end
      end
      return setTacticsData(r4_205, "voting")
    elseif type(r0_205) == "number" then
      r4_205 = getTacticsData("voting")
      if r4_205 and r4_205.rows and 0 < #r4_205.rows and r4_205.cancel and r0_205 <= #r4_205.rows then
        if r1_205 and 0 < r1_205 then
          r4_205.rows[r1_205].votes = r4_205.rows[r1_205].votes - 1
        end
        if r1_205 == 0 then
          r4_205.cancel = r4_205.cancel - 1
        end
        if r0_205 > 0 then
          r4_205.rows[r0_205].votes = r4_205.rows[r0_205].votes + 1
          if 0.5 * getPlayerCount() < r4_205.rows[r0_205].votes then
            setTacticsData(r4_205, "voting")
            onVotingFinish()
            return 
          end
        else
          r4_205.cancel = r4_205.cancel + 1
          if 0.5 * getPlayerCount() < r4_205.cancel then
            setTacticsData(r4_205, "voting")
            onVotingFinish()
            return 
          end
        end
        return setTacticsData(r4_205, "voting")
      end
    end
  end
  function onVotingFinish()
    -- line: [201, 221] id: 206
    if isTimer(r0_200) then
      killTimer(r0_200)
    end
    local r0_206 = getTacticsData("voting")
    if r0_206 and 0 < #r0_206.rows and r0_206.cancel then
      if #r0_206.rows > 1 then
        table.sort(r0_206.rows, function(r0_207, r1_207)
          -- line: [206, 206] id: 207
          return r1_207.votes < r0_207.votes
        end)
      end
      local r1_206 = r0_206.rows[1]
      if 0 < r1_206.votes and r0_206.cancel < r1_206.votes and type(r1_200[r1_206.num]) == "function" then
        triggerEvent("onVotingResult", root, r1_206)
        if r1_200[r1_206.num](r1_206) then
          return 
        end
      end
    end
    outputLangString(root, "voting_falied")
    setTacticsData(nil, "voting")
    if getTacticsData("automatics") == "voting" and winTimer then
      nextMap()
    end
  end
  function onPlayerPreview(r0_208)
    -- line: [222, 247] id: 208
    if not hasObjectPermissionTo(getThisResource(), "general.ModifyOtherObjects", false) then
      triggerClientEvent(source, "onClientPreviewMapLoading", root, false, {})
      outputLangString(source, "resource_have_not_permissions", getResourceName(getThisResource()), "general.ModifyOtherObjects")
      return 
    end
    local r1_208 = {}
    local r2_208 = xmlLoadFile(":" .. r0_208 .. "/meta.xml")
    for r6_208, r7_208 in ipairs(xmlNodeGetChildren(r2_208)) do
      if xmlNodeGetName(r7_208) == "map" then
        local r8_208 = xmlLoadFile(":" .. r0_208 .. "/" .. xmlNodeGetAttribute(r7_208, "src"))
        for r12_208, r13_208 in ipairs(xmlNodeGetChildren(r8_208)) do
          table.insert(r1_208, {
            xmlNodeGetName(r13_208),
            xmlNodeGetAttributes(r13_208)
          })
        end
        xmlUnloadFile(r8_208)
      end
    end
    xmlUnloadFile(r2_208)
    local r3_208 = false
    for r7_208 in pairs(getTacticsData("modes_defined") or {}) do
      if string.find(r0_208, r7_208) == 1 then
        r3_208 = r7_208
      end
    end
    triggerClientEvent(source, "onClientPreviewMapLoading", root, r3_208, r1_208)
  end
  addCommandHandler("endvote", stopVoting, false, false)
  addEvent("onPlayerVote", true)
  addEvent("onPlayerPreview", true)
  addEvent("onVotingResult")
  addEventHandler("onPlayerVote", root, onPlayerVote)
  addEventHandler("onPlayerPreview", root, onPlayerPreview)
end)()
(function(...)
  -- line: [0, 0] id: 209
  local r0_209 = {}
  local r1_209 = {}
  local r2_209 = ""
  local r3_209 = ""
  local r4_209 = ""
  local r5_209 = ""
  local r6_209 = {
    Damage = true,
    Kills = true,
    Deaths = true,
  }
  local r7_209 = {}
  function setRoundStatisticData(...)
    -- line: [15, 25] id: 210
    r6_209 = {}
    for r4_210, r5_210 in ipairs({
      ...
    }) do
      if type(r5_210) == "string" then
        r6_209[r5_210] = true
      end
    end
    triggerClientEvent(root, "onClientStatisticChange", root, ...)
    return true
  end
  function onMapStarting(r0_211)
    -- line: [26, 50] id: 211
    r0_209 = {}
    r2_209 = ""
    r7_209 = {}
    r4_209 = r0_211.name
    table.remove(getElementsByType("team"), 1)
    local r2_211 = getTacticsData("Teamsides")
    local r3_211 = getTacticsData("SideNames")
    local r4_211 = getTacticsData("LogoLink") or "http://gta-rating.ru/forum/images/rml/"
    for r8_211, r9_211 in ipairs(r1_211) do
      local r10_211, r11_211, r12_211 = getTeamColor(r9_211)
      table.insert(r0_209, {
        name = getTeamName(r9_211),
        score = tonumber(getElementData(r9_211, "Score")),
        side = r3_211[2 - r2_211[r9_211] % 2],
        r = r10_211,
        g = r11_211,
        b = r12_211,
        players = {},
        image = nil,
      })
      r7_209[r9_211] = #r0_209
      fetchRemote(r4_211 .. getTeamName(r9_211) .. ".png", onStatisticImageLoad, "", false, r9_211)
    end
  end
  function onStatisticImageLoad(r0_212, r1_212, r2_212)
    -- line: [51, 54] id: 212
    if r1_212 ~= 0 or not r7_209[r2_212] then
      return 
    end
    r0_209[r7_209[r2_212]].image = r0_212
  end
  function outputRoundLog(r0_213, r1_213)
    -- line: [55, 67] id: 213
    r2_209 = r2_209 .. "\n"
    if not r1_213 then
      local r2_213 = 0
      local r3_213 = getTacticsData("timestart")
      if r3_213 then
        local r4_213 = math.max
        local r5_213 = 0
        local r6_213 = isRoundPaused()
        if r6_213 then
          r6_213 = r3_213 or getTickCount() - r3_213
        else
          goto label_21	-- block#4 is visited secondly
        end
        r2_213 = r4_213(r5_213, r6_213)
      end
      r2_209 = r2_209 .. string.format("[%s] ", MSecToTime(r2_213, 0))
    end
    r2_209 = r2_209 .. removeColorCoding(r0_213)
  end
  function onRoundStart()
    -- line: [68, 89] id: 214
    local r0_214 = getRealTime()
    r2_209 = string.format("[%02i:%02i - %i.%02i.%04i] Round start", r0_214.hour, r0_214.minute, r0_214.monthday, r0_214.month + 1, r0_214.year + 1900)
    for r4_214, r5_214 in ipairs(getTacticsData("Sides")) do
      local r6_214 = ""
      for r10_214, r11_214 in ipairs(getPlayersInTeam(r5_214)) do
        if getPlayerGameStatus(r11_214) == "Play" then
          if not r7_209[r11_214] then
            local r12_214 = {
              name = removeColorCoding(getPlayerName(r11_214)),
            }
            for r16_214 in pairs(r6_209) do
              r12_214[r16_214] = 0
            end
            table.insert(r0_209[r7_209[r5_214]].players, r12_214)
            r7_209[r11_214] = #r0_209[r7_209[r5_214]].players
          end
          r6_214 = r6_214 .. ", " .. removeColorCoding(getPlayerName(r11_214))
        end
      end
      local r7_214 = outputRoundLog
      local r8_214 = getTeamName(r5_214)
      local r9_214 = ": "
      local r10_214 = #r6_214
      if r10_214 > 0 then
        r10_214 = string.sub(r6_214, 3) or ""
      else
        goto label_92	-- block#12 is visited secondly
      end
      r7_214(r8_214 .. r9_214 .. r10_214, true)
    end
    outputRoundLog("", true)
  end
  function onRoundFinish(r0_215, r1_215, r2_215)
    -- line: [90, 136] id: 215
    if r0_215 then
      local r3_215 = ""
      local r4_215 = ""
      if type(r0_215) == "table" then
        if type(r0_215[1]) == "string" then
          local r5_215 = r0_215
          r3_215 = string.format(getString(tostring(table.remove(r5_215, 1))), unpack(r5_215))
        else
          local r5_215 = r0_215[4]
          local r6_215 = r0_215
          table.remove(r6_215, 1)
          table.remove(r6_215, 1)
          table.remove(r6_215, 1)
          table.remove(r6_215, 1)
          r3_215 = string.format(getString(tostring(r5_215)), unpack(r6_215))
        end
      elseif type(r0_215) == "string" then
        r3_215 = getString(r0_215)
        if #r3_215 == 0 then
          r3_215 = tostring(r0_215)
        end
      else
        r3_215 = tostring(r0_215)
      end
      if r1_215 then
        if type(r1_215) == "table" then
          local r5_215 = r1_215
          r4_215 = string.format(getString(tostring(table.remove(r5_215, 1))), unpack(r5_215))
        elseif type(r1_215) == "string" then
          r4_215 = getString(r1_215)
          if #r4_215 == 0 then
            r4_215 = tostring(r1_215)
          end
        else
          r4_215 = tostring(r1_215)
        end
        r4_215 = " (" .. r4_215 .. ")"
      end
      outputRoundLog(r3_215 .. r4_215)
    end
    local r3_215 = getElementsByType("team")
    table.remove(r3_215, 1)
    for r7_215, r8_215 in ipairs(r3_215) do
      if r7_209[r8_215] then
        r0_209[r7_209[r8_215]].score = tonumber(getElementData(r8_215, "Score"))
      end
    end
    setTimer(callClientFunction, 1000, 1, root, "updateRoundStatistic", r4_209, r0_209, r2_209)
    r5_209 = r4_209
    r1_209 = {
      unpack(r0_209)
    }
    r3_209 = r2_209
  end
  function onPlayerDownloadComplete()
    -- line: [137, 139] id: 216
    callClientFunction(source, "updateRoundStatistic", r5_209, r1_209, r3_209, true)
  end
  function onElementDataChange(r0_217, r1_217)
    -- line: [140, 166] id: 217
    local r2_217 = getElementType(source)
    if r2_217 == "player" and r0_217 == "Status" and getElementData(source, r0_217) == "Play" and not r7_209[source] then
      local r3_217 = getPlayerTeam(source)
      if not r7_209[r3_217] then
        return 
      end
      local r4_217 = {
        name = removeColorCoding(getPlayerName(source)),
      }
      for r8_217 in pairs(r6_209) do
        r4_217[r8_217] = 0
      end
      table.insert(r0_209[r7_209[r3_217]].players, r4_217)
      r7_209[source] = #r0_209[r7_209[r3_217]].players
    end
    if (r2_217 == "player" or r2_217 == "team") and r6_209[r0_217] and r7_209[source] then
      local r3_217 = tonumber(getElementData(source, r0_217))
      if type(r3_217) == "number" and type(r1_217) == "number" then
        r3_217 = r3_217 - r1_217
      else
        r3_217 = 0
      end
      if r2_217 == "team" then
        r0_209[r7_209[source]][r0_217] = r0_209[r7_209[source]][r0_217] + r3_217
      else
        local r4_217 = getPlayerTeam(source)
        if r7_209[r4_217] then
          r0_209[r7_209[r4_217]].players[r7_209[source]][r0_217] = r0_209[r7_209[r4_217]].players[r7_209[source]][r0_217] + r3_217
        end
      end
    end
  end
  function onPlayerWasted(r0_218, r1_218, r2_218, r3_218)
    -- line: [167, 196] id: 218
    local r4_218 = nil	-- notice: implicit variable refs by block#[10, 13, 14]
    if r1_218 then
      if r1_218 ~= source then
        local r5_218 = getElementType(r1_218)
        if r5_218 == "player" then
          r4_218 = getPlayerName(r1_218) .. " killed " .. getPlayerName(source)
        elseif r5_218 == "vehicle" then
          r4_218 = getPlayerName(getVehicleController(r1_218)) .. " killed " .. getPlayerName(source) .. " (" .. getVehicleName(r1_218) .. ")"
        end
      else
        r4_218 = getPlayerName(source) .. " committed suicide"
      end
    else
      r4_218 = getPlayerName(source) .. " died"
    end
    if r2_218 then
      local r5_218 = getWeaponNameFromID(r2_218)
      if r5_218 then
        r4_218 = r4_218 .. " (" .. r5_218 .. ")"
      end
    end
    if r3_218 and getBodyPartName(r3_218) then
      r4_218 = r4_218 .. " (" .. getBodyPartName(r3_218) .. ")"
    end
    outputRoundLog(removeColorCoding(r4_218))
  end
  function onPauseToggle(r0_219, r1_219)
    -- line: [197, 204] id: 219
    if r0_219 then
      outputRoundLog("Game paused")
    else
      outputRoundLog(string.format("[+%s] Game unpaused", MSecToTime(r1_219, 0)), true)
    end
  end
  addEventHandler("onMapStarting", root, onMapStarting)
  addEventHandler("onRoundStart", root, onRoundStart)
  addEventHandler("onRoundFinish", root, onRoundFinish)
  addEventHandler("onPlayerDownloadComplete", root, onPlayerDownloadComplete)
  addEventHandler("onElementDataChange", root, onElementDataChange)
  addEventHandler("onPlayerWasted", root, onPlayerWasted)
  addEventHandler("onPauseToggle", root, onPauseToggle)
end)()
