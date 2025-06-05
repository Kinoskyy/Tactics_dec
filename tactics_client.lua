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
  addTickCount = 0
  helpme = {}
  helpmeArrow = {}
  local r0_53 = false
  weaponSave = {}
  weaponMemory = false
  function fixTickCount(r0_54)
    -- line: [13, 15] id: 54
    addTickCount = r0_54 - getTickCount()
  end
  function showCountdown(r0_55)
    -- line: [16, 28] id: 55
    if r0_55 == 0 then
      dxDrawAnimatedImage("images/count_go.png", 2)
      if not playVoice("audio/count_go.mp3") then
        playSoundFrontEnd(45)
      end
    elseif r0_55 <= 3 then
      dxDrawAnimatedImage("images/count_" .. r0_55 .. ".png", 1)
      if not playVoice(("audio/count_" .. r0_55 .. ".mp3")) then
        playSoundFrontEnd(44)
      end
    end
  end
  function onClientResourceStart(r0_56)
    -- line: [29, 130] id: 56
    fontTactics = guiCreateFont("verdana.ttf", 20) or "sa-header"
    r0_53 = false
    label_version = guiCreateLabel(0, yscreen - 30, xscreen - 5, 30, "", false)
    guiSetEnabled(label_version, false)
    guiLabelSetHorizontalAlign(label_version, "right", false)
    guiSetAlpha(label_version, 0.5)
    mapstring = guiCreateLabel(5, yscreen - 15, xscreen, 15, tostring(getTacticsData("MapName", false)), false)
    guiSetEnabled(mapstring, false)
    guiSetAlpha(mapstring, 0.5)
    for r4_56, r5_56 in ipairs(getElementsByType("player")) do
      if r5_56 ~= localPlayer then
        local r6_56 = createBlipAttachedTo(r5_56, 0, 2, 0, 0, 0, 0)
        setElementData(r5_56, "Blip", r6_56, false)
        setElementParent(r6_56, r5_56)
      end
    end
    for r4_56, r5_56 in ipairs(getElementsByType("vehicle")) do
      local r6_56 = createBlipAttachedTo(r5_56, 0, 0, 0, 0, 0, 0, -1)
      setElementData(r5_56, "Blip", r6_56, false)
      setElementParent(r6_56, r5_56)
    end
    credits_window = guiCreateWindow(xscreen * 0.5 - 280, yscreen * 0.5 - 150, 560, 300, "", false)
    guiWindowSetSizable(credits_window, false)
    guiSetVisible(credits_window, false)
    credits_content = {}
    credits_height = 300
    local function r1_56(r0_57, r1_57)
      -- line: [58, 69] id: 57
      local r2_57 = guiCreateLabel(0, credits_height, 560, 1000, r0_57, false, credits_window)
      if not r1_57 then
        r1_57 = 0
      end
      if r1_57 == 1 then
        guiSetFont(r2_57, "default-bold-small")
      end
      if r1_57 == 2 then
        guiSetFont(r2_57, fontTactics)
      end
      guiSetEnabled(r2_57, false)
      guiLabelSetHorizontalAlign(r2_57, "center", false)
      table.insert(credits_content, {
        r2_57,
        credits_height
      })
      credits_height = credits_height + string.count(r0_57, "\n") * guiLabelGetFontHeight(r2_57) + ({
        [0] = 50,
        [1] = 20,
        [2] = 80,
      })[r1_57]
      return r2_57
    end
    credits_version = r1_56("", 2)
    r1_56("Author, Scripting & Idea", 1)
    r1_56("Alexander \"Lex128\"")
    r1_56("Interface Design", 1)
    r1_56("Alexander \"Lex128\"\nDenis \"spitfire\"\nDenis \"Den\"\nand unknown creator of countdown images")
    r1_56("Speech Synthesis", 1)
    r1_56("SitePal.com")
    r1_56("Mapping", 1)
    r1_56("Maxim \"Saint\"\nAlexander \"Lex128\"\nStar \"Easterdie\"")
    r1_56("Language Support", 1)
    r1_56("Osamah \"iComm2a\"\nEddy \"Dorega\"\nLaith \"C4neeL\"\nViktor \"Rubik\"\nAlexander \"Zaibatsu\"\nJoseph \"Randy\"\nAdrian \"vnm\"\nLukas \"Lukis\"\nNikolas \"Dante\"")
    r1_56("Special Thanks", 1)
    r1_56("Nikita \"Vincent\"\nSemen \"DJ_Semen\"\nSergey \"3ap\"")
    credits_ending = {
      guiCreateLabel(0, credits_height, 560, 20, "Lex128, 2009-" .. tostring(1900 + getRealTime().year), false, credits_window),
      credits_height
    }
    guiLabelSetHorizontalAlign(credits_ending[1], "center", false)
    guiSetEnabled(credits_ending[1], false)
    credits_close = guiCreateButton(431, 270, 112, 21, "OK", false, credits_window)
    guiSetFont(credits_close, "default-bold-small")
    team_window = guiCreateWindow(xscreen * 0.5 - 130, yscreen * 0.5 - 120, 260, 240, "Teams", false)
    guiWindowSetSizable(team_window, false)
    guiSetVisible(team_window, false)
    team_button = {}
    team_specskinbtn = guiCreateButton(135, 27, 120, 20, "    Spectate Skin", false, team_window)
    guiSetFont(team_specskinbtn, "default-bold-small")
    team_specskin = guiCreateCheckBox(5, 2, 16, 16, "", false, false, team_specskinbtn)
    team_joining = guiCreateButton(135, 49, 120, 20, "Go to Joining", false, team_window)
    guiSetFont(team_joining, "default-bold-small")
    team_close = guiCreateButton(135, 71, 120, 20, "Close", false, team_window)
    guiSetFont(team_close, "default-bold-small")
    guiSetInputEnabled(false)
    setInteriorSoundsEnabled(false)
    setAmbientSoundEnabled("gunfire", false)
    setTrafficLightsLocked(true)
    setTrafficLightState("yellow", "yellow")
    addEventHandler("onClientGUIMouseDown", root, function()
      -- line: [121, 127] id: 58
      if (getElementType(source) == "gui-edit" or getElementType(source) == "gui-memo") and guiGetProperty(source, "ReadOnly") ~= "True" then
        guiSetInputEnabled(true)
      elseif guiGetInputEnabled() then
        guiSetInputEnabled(false)
      end
    end)
    setTimer(triggerServerEvent, 150, 1, "onPlayerDownloadComplete", localPlayer)
    setTimer(triggerEvent, 150, 1, "onDownloadComplete", root)
  end
  function onClientResourceStop()
    -- line: [131, 149] id: 59
    for r3_59, r4_59 in ipairs(currentPed) do
      if isElement(r4_59) then
        destroyElement(r4_59)
      end
    end
    currentPed = {}
    setElementData(localPlayer, "Status", nil)
    setTrafficLightState("auto")
    resetAmbientSounds()
    resetHeatHaze()
    resetSkyGradient()
    resetWindVelocity()
    resetRainLevel()
    resetSunSize()
    resetSunColor()
    resetFarClipDistance()
    resetFogDistance()
    resetWaterColor()
    resetWaterLevel()
  end
  function createVehicleManager()
    -- line: [150, 170] id: 60
    vehicle_window = guiCreateWindow(xscreen * 0.5 - 130, yscreen * 0.5 - 225, 260, 450, "Vehicle Manager", false)
    guiWindowSetSizable(vehicle_window, false)
    vehicle_search = guiCreateEdit(0.04, 0.05, 0.63, 0.05, "", true, vehicle_window)
    guiSetEnabled(guiCreateStaticImage(0.88, 0.1, 0.11, 0.8, "images/search.png", true, vehicle_search), false)
    vehicle_list = guiCreateGridList(0.04, 0.11, 0.63, 0.81, true, vehicle_window)
    guiGridListSetSortingEnabled(vehicle_list, false)
    guiGridListAddColumn(vehicle_list, "Name", 0.8)
    vehicle_car = guiCreateCheckBox(0.7, 0.11, 0.28, 0.05, "Cars", true, true, vehicle_window)
    vehicle_bike = guiCreateCheckBox(0.7, 0.16999999999999998, 0.28, 0.05, "Bikes", true, true, vehicle_window)
    vehicle_plane = guiCreateCheckBox(0.7, 0.22999999999999998, 0.28, 0.05, "Planes", true, true, vehicle_window)
    vehicle_heli = guiCreateCheckBox(0.7, 0.29, 0.28, 0.05, "Helis", true, true, vehicle_window)
    vehicle_boat = guiCreateCheckBox(0.7, 0.35, 0.28, 0.05, "Boats", true, true, vehicle_window)
    vehicle_getvehicle = guiCreateButton(0.04, 0.93, 0.44, 0.05, "Get vehicle", true, vehicle_window)
    guiSetFont(vehicle_getvehicle, "default-bold-small")
    guiSetProperty(vehicle_getvehicle, "NormalTextColour", "C000FF00")
    vehicle_close = guiCreateButton(0.52, 0.93, 0.44, 0.05, "Cancel", true, vehicle_window)
    guiSetFont(vehicle_close, "default-bold-small")
    updateVehicleList()
    return vehicle_window
  end
  function createWeaponManager()
    -- line: [171, 190] id: 61
    weapon_window = guiCreateWindow(xscreen * 0.5 - 310, yscreen * 0.5 - 160, 620, 320, "Weapon Manager", false)
    guiWindowSetSizable(weapon_window, false)
    weapon_properties = guiCreateLabel(435, 28, 185, 230, "", false, weapon_window)
    local r0_61 = getTacticsData("weapon_slots") or 0
    local r1_61 = guiCreateLabel
    local r2_61 = 435
    local r3_61 = 244
    local r4_61 = 185
    local r5_61 = 22
    local r6_61 = "You can choice "
    local r7_61 = nil	-- notice: implicit variable refs by block#[5]
    if r0_61 > 0 then
      r7_61 = r0_61
      if r7_61 then
        ::label_43::
        r7_61 = "any"
      end
    else
      goto label_43	-- block#4 is visited secondly
    end
    weapon_slots = r1_61(r2_61, r3_61, r4_61, r5_61, r6_61 .. r7_61 .. " weapons", false, weapon_window)
    guiLabelSetHorizontalAlign(weapon_slots, "center", false)
    guiSetFont(weapon_slots, "default-bold-small")
    weapon_scrollerbg = guiCreateGridList(5, 25, 420, 290, false, weapon_window)
    weapon_scroller = guiCreateScrollPane(3, 3, 416, 285, false, weapon_scrollerbg)
    weapon_items = {}
    weapon_memory = guiCreateCheckBox(433, 266, 100, 22, "Save Selected", false, false, weapon_window)
    weapon_accept = guiCreateButton(433, 288, 86, 22, "Get weapons", false, weapon_window)
    guiSetFont(weapon_accept, "default-bold-small")
    guiSetProperty(weapon_accept, "NormalTextColour", "C000FF00")
    weapon_close = guiCreateButton(524, 288, 86, 22, "Close", false, weapon_window)
    guiSetFont(weapon_close, "default-bold-small")
    remakeWeaponsPack()
    return weapon_window
  end
  function onClientOtherResourceStart(r0_62)
    -- line: [191, 204] id: 62
    if getThisResource() ~= r0_62 and getResourceName(r0_62) == getTacticsData("MapResName") and getElementData(localPlayer, "Status") then
      local r1_62 = {
        modename = getTacticsData("Map"),
        name = getTacticsData("MapName", false) or "unnamed",
        author = getTacticsData("MapAuthor", false),
        resname = getResourceName(r0_62),
        resource = r0_62,
      }
      if r1_62.modename then
        triggerServerEvent("onPlayerMapLoad", localPlayer)
        triggerEvent("onClientMapStarting", root, r1_62)
      end
    end
  end
  function updateTeamManager()
    -- line: [205, 234] id: 63
    -- notice: unreachable block#14
    local r0_63 = getElementsByType("team")
    table.insert(r0_63, r0_63[1])
    table.remove(r0_63, 1)
    for r4_63, r5_63 in ipairs(r0_63) do
      if r5_63 == getPlayerTeam(localPlayer) then
        table.remove(r0_63, r4_63)
        break
      end
    end
    local r1_63 = 1
    for r5_63 = 1, math.max(#r0_63, #team_button), 1 do
      if r5_63 <= #r0_63 then
        if #team_button < r5_63 then
          team_button[r5_63] = guiCreateButton(5, 5 + 22 * r5_63, 120, 20, "", false, team_window)
          guiSetFont(team_button[r5_63], "default-bold-small")
        end
        guiSetText(team_button[r5_63], getTeamName(r0_63[r5_63]))
        guiSetProperty(team_button[r5_63], "NormalTextColour", string.format("FF%02X%02X%02X", getTeamColor(r0_63[r5_63])))
        guiBringToFront(team_button[r5_63])
      else
        destroyElement(team_button[r5_63])
        table.remove(team_button)
      end
    end
    local r2_63 = guiCheckBoxSetSelected
    local r3_63 = team_specskin
    local r4_63 = getElementData(localPlayer, "spectateskin")
    if r4_63 then
      r4_63 = true
    else
      r4_63 = false
    end
    r2_63(r3_63, r4_63)
    guiSetSize(team_window, 260, 5 + 22 * math.max(3, #r0_63) + 22 + 8, false)
    guiSetPosition(team_joining, 135, 5 + 22 * math.max(2, (#r0_63 - 1)), false)
    guiSetPosition(team_close, 135, 5 + 22 * math.max(3, #r0_63), false)
  end
  function createRadarPolyline(r0_64, r1_64, r2_64, r3_64, r4_64, r5_64, r6_64, r7_64)
    -- line: [235, 266] id: 64
    if type(r0_64) ~= "table" and type(r0_64) ~= "userdata" then
      return 
    end
    if not r1_64 then
      r1_64 = 128
    end
    if not r2_64 then
      r2_64 = 0
    end
    if not r3_64 then
      r3_64 = 0
    end
    if not r4_64 then
      r4_64 = 255
    end
    if not r6_64 then
      r6_64 = 12
    end
    if not r7_64 then
      r7_64 = getRoundMapDynamicRoot()
    end
    for r11_64, r12_64 in ipairs(r0_64) do
      local r13_64 = 0
      local r14_64 = 0
      local r15_64 = 0
      local r16_64 = 0
      if isElement(r12_64) then
        local r17_64 = tonumber(getElementData(r12_64, "posX"))
        r14_64 = tonumber(getElementData(r12_64, "posY"))
        r13_64 = r17_64
      else
        r13_64, r14_64 = unpack(r12_64)
      end
      local r17_64 = #r0_64
      if r11_64 < r17_64 then
        r17_64 = r0_64[r11_64 + 1] or r5_64 and r0_64[1]
      else
        goto label_71	-- block#21 is visited secondly
      end
      if r17_64 then
        if isElement(r17_64) then
          local r18_64 = tonumber(getElementData(r17_64, "posX"))
          r16_64 = tonumber(getElementData(r17_64, "posY"))
          r15_64 = r18_64
        else
          r15_64, r16_64 = unpack(r17_64)
        end
        local r18_64 = math.floor(getDistanceBetweenPoints2D(r13_64, r14_64, r15_64, r16_64) / 0.4 * r6_64)
        local r19_64 = (r15_64 - r13_64) / r18_64
        local r20_64 = (r16_64 - r14_64) / r18_64
        for r24_64 = 0, r18_64, 1 do
          setElementParent(createRadarArea(r13_64 - r6_64 * 0.5 + r19_64 * r24_64, r14_64 - r6_64 * 0.5 + r20_64 * r24_64, r6_64, r6_64, r1_64, r2_64, r3_64, r4_64), r7_64)
        end
      end
    end
  end
  function onClientMapStarting(r0_65)
    -- line: [267, 306] id: 65
    local r1_65 = {}
    for r5_65, r6_65 in ipairs(getElementsByType("Anti_Rush_Point")) do
      table.insert(r1_65, {
        tonumber(getElementData(r6_65, "posX")),
        tonumber(getElementData(r6_65, "posY"))
      })
    end
    if #r1_65 > 0 then
      if #r1_65 == 2 then
        r1_65 = {
          {
            math.min(r1_65[1][1], r1_65[2][1]),
            math.min(r1_65[1][2], r1_65[2][2])
          },
          {
            math.max(r1_65[1][1], r1_65[2][1]),
            math.min(r1_65[1][2], r1_65[2][2])
          },
          {
            math.max(r1_65[1][1], r1_65[2][1]),
            math.max(r1_65[1][2], r1_65[2][2])
          },
          {
            math.min(r1_65[1][1], r1_65[2][1]),
            math.max(r1_65[1][2], r1_65[2][2])
          }
        }
      end
      if #r1_65 > 1 then
        local r2_65 = getRoundMapDynamicRoot()
        local r3_65 = {}
        local r4_65 = getElementsByType("Central_Marker")[1]
        table.insert(r3_65, tonumber(getElementData(r4_65, "posX")))
        table.insert(r3_65, tonumber(getElementData(r4_65, "posY")))
        for r8_65, r9_65 in ipairs(r1_65) do
          table.insert(r3_65, r9_65[1])
          table.insert(r3_65, r9_65[2])
        end
        createRadarPolyline(r1_65, 128, 0, 0, 255, true, 12, r2_65)
        local r5_65 = createColPolygon(unpack(r3_65))
        setElementParent(r5_65, r2_65)
        setElementData(r5_65, "Boundings", true, false)
      end
    end
    if getElementData(localPlayer, "Loading") and type(notreadyCounter) ~= "number" then
      local r2_65 = getElementsByType("Central_Marker")[1] or getElementsByType("spawnpoint")[1]
      local r3_65 = tonumber(getElementData(r2_65, "posX"))
      local r4_65 = tonumber(getElementData(r2_65, "posY"))
      local r5_65 = tonumber(getElementData(r2_65, "posZ"))
      if not r3_65 or not r4_65 or not r5_65 then
        r3_65, r4_65, r5_65 = getElementPosition(r2_65)
      end
      setCameraMatrix(r3_65, r4_65, r5_65 + 1, r3_65, r4_65, r5_65)
    end
  end
  function onClientPlayerJoin()
    -- line: [307, 311] id: 66
    local r0_66 = createBlipAttachedTo(source, 0, 2, 0, 0, 0, 0)
    setElementData(source, "Blip", r0_66, false)
    setElementParent(r0_66, source)
  end
  function onClientPlayerQuit(r0_67)
    -- line: [312, 315] id: 67
    local r1_67 = getElementData(source, "Blip")
    if r1_67 then
      destroyElement(r1_67)
    end
  end
  function onClientPlayerDamage(r0_68, r1_68, r2_68, r3_68)
    -- line: [316, 328] id: 68
    if isElement(r0_68) and localPlayer ~= r0_68 then
      if getElementType(r0_68) == "vehicle" then
        r0_68 = getVehicleController(r0_68)
      end
      if getElementType(r0_68) ~= "player" then
        return 
      end
      local r4_68 = getPlayerTeam(r0_68)
      local r5_68 = getPlayerTeam(localPlayer)
      if r5_68 and r4_68 and r4_68 ~= r5_68 and getElementData(r5_68, "Side") == getElementData(r4_68, "Side") then
        cancelEvent()
      end
    end
  end
  function onClientPlayerSpawn(r0_69)
    -- line: [329, 331] id: 69
    if source ~= localPlayer then
      setElementCollisionsEnabled(source, true)
    else
      setElementRotation(localPlayer, 0, 0, getPedRotation(localPlayer))
    end
  end
  function onClientPlayerWasted(r0_70, r1_70, r2_70)
    -- line: [332, 343] id: 70
    if source == localPlayer then
      if r1_70 == 16 or r1_70 == 19 or r1_70 == 35 or r1_70 == 36 or r1_70 == 37 or r1_70 == 39 or r1_70 == 51 or r1_70 == 59 then
        playVoice("audio/toasted.mp3")
      else
        playVoice("audio/wasted.mp3")
      end
      setCameraMatrix(getCameraMatrix())
    else
      setElementCollisionsEnabled(source, false)
    end
  end
  function onClientRespawnCountdown(r0_71)
    -- line: [344, 348] id: 71
    if respawn_countdown then
      return 
    end
    addEventHandler("onClientPreRender", root, onClientRespawnRender)
    respawn_countdown = r0_71
  end
  function onClientRespawnRender(r0_72)
    -- line: [349, 365] id: 72
    respawn_countdown = respawn_countdown - r0_72 * getGameSpeed()
    local r1_72 = tonumber(getRoundModeSettings("respawn_lives") or getTacticsData("settings", "respawn_lives") or tonumber(0))
    local r2_72 = getElementData(localPlayer, "RespawnLives")
    if r2_72 and 0 < r1_72 then
      dxDrawText(tostring(r2_72), xscreen * 0.502, yscreen * 0.352, xscreen * 0.502, yscreen * 0.352, 4278190080, getFont(2), "default-bold", "center", "bottom")
      dxDrawText(tostring(r2_72), xscreen * 0.5, yscreen * 0.35, xscreen * 0.5, yscreen * 0.35, tocolor(255, 255, 128), getFont(2), "default-bold", "center", "bottom")
    end
    dxDrawText(string.format(getLanguageString("respawn_in"), math.max(respawn_countdown, 0) / 1000), xscreen * 0.502, yscreen * 0.352, xscreen * 0.502, yscreen * 0.352, tocolor(0, 0, 0), getFont(1), "default", "center", "top")
    dxDrawText(string.format(getLanguageString("respawn_in"), math.max(respawn_countdown, 0) / 1000), xscreen * 0.5, yscreen * 0.35, xscreen * 0.5, yscreen * 0.35, tocolor(255, 255, 255), getFont(1), "default", "center", "top")
    if respawn_countdown <= 0 then
      removeEventHandler("onClientPreRender", root, onClientRespawnRender)
      respawn_countdown = nil
      fadeCamera(false, 0)
      triggerServerEvent("onPlayerRoundRespawn", localPlayer)
    end
  end
  local r1_53 = nil
  local r2_53 = nil
  function onClientRoundCountdownStarted(r0_73)
    -- line: [368, 376] id: 73
    local r1_73, r2_73, r3_73 = getElementPosition(localPlayer)
    local r4_73 = math.rad(getPedRotation(localPlayer))
    local r5_73 = math.rad(2.86431884766)
    local r6_73 = 0
    local r7_73 = 0
    local r8_73 = 0.6
    if isPedDucked(localPlayer) then
      r8_73 = -0.1
    end
    r2_53 = {
      getTickCount(),
      r0_73,
      3.5 * math.sin(r4_73) * math.cos(r5_73) + r1_73,
      -3.5 * math.cos(r4_73) * math.cos(r5_73) + r2_73,
      3.5 * math.sin(r5_73) + r8_73 + r3_73,
      r6_73 + r1_73,
      r7_73 + r2_73,
      r8_73 + r3_73
    }
  end
  function onClientPrepairRender()
    -- line: [377, 398] id: 74
    local r0_74 = getElementData(localPlayer, "Prepair")
    if r0_74 and not getCameraTarget() then
      local r1_74, r2_74, r3_74, r4_74 = unpack(r0_74)
      local r5_74, r6_74, r7_74 = getCameraMatrix()
      r1_53 = (r1_53 or getAngleBetweenPoints2D(r1_74, r2_74, r5_74, r6_74)) + 1
      local r8_74 = math.rad(r1_53)
      r7_74 = r3_74 + 0.5 * r4_74
      r6_74 = r2_74 + r4_74 * math.cos(r8_74)
      r5_74 = r1_74 - r4_74 * math.sin(r8_74)
      if r2_53 == nil or getElementData(localPlayer, "Status") ~= "Play" then
        setCameraMatrix(r5_74, r6_74, r7_74, r1_74, r2_74, r3_74)
      elseif type(r2_53) == "table" then
        local r9_74, r10_74, r11_74, r12_74, r13_74, r14_74, r15_74, r16_74 = unpack(r2_53)
        local r17_74 = getEasingValue(math.max(0, math.min(1, (getTickCount() - r9_74) / r10_74)), "InOutQuad")
        r1_53 = r1_53 - r17_74
        setCameraMatrix(r5_74 + r17_74 * (r11_74 - r5_74), r6_74 + r17_74 * (r12_74 - r6_74), r7_74 + r17_74 * (r13_74 - r7_74), r1_74 + r17_74 * (r14_74 - r1_74), r2_74 + r17_74 * (r15_74 - r2_74), r3_74 + r17_74 * (r16_74 - r3_74))
        if r17_74 == 1 then
          stopCameraPrepair()
        end
      end
    elseif r0_74 then
      stopCameraPrepair()
    end
  end
  function onDownloadCompleteingRender()
    -- line: [399, 420] id: 75
    if type(notreadyCounter) ~= "number" or notreadyCounter < 3000 then
      dxDrawImage(xscreen * 0.5 - 32, yscreen * 0.5 - 32, 64, 64, "images/loading.png", 30 * math.floor(getTickCount() % 1000 * 0.012))
    end
    if type(notreadyCounter) == "number" then
      if notreadyCounter < 3000 and 3000 <= notreadyCounter + getGameSpeed() * 20 then
        fadeCamera(true, 2)
      end
      notreadyCounter = notreadyCounter + getGameSpeed() * 20
      if notreadyCounter >= 5000 then
        notreadyCounter = nil
        setElementData(localPlayer, "Loading", nil)
        triggerServerEvent("onPlayerMapReady", localPlayer)
      end
    else
      local r0_75, r1_75 = getCameraMatrix()
      if not isLineOfSightClear(r0_75, r1_75, 1500, r0_75, r1_75, -100) or testLineAgainstWater(r0_75, r1_75, 1500, r0_75, r1_75, -100) then
        notreadyCounter = 0
      end
    end
  end
  function onDownloadComplete()
    -- line: [421, 441] id: 76
    local r0_76 = getRoundMapInfo()
    if r0_76.modename then
      triggerServerEvent("onPlayerMapLoad", localPlayer)
      triggerEvent("onClientMapStarting", root, r0_76)
    end
    local r1_76 = getTacticsData("weaponspack") or {}
    local r3_76 = fromJSON(xmlNodeGetAttribute(xmlFindChild(_client, "weaponpack", 0) or xmlCreateChild(_client, "weaponpack"), "selected") or "[ [ ] ]")
    weaponSave = {}
    local r4_76 = getTacticsData("weapon_slots") or 0
    local r5_76 = 0
    for r9_76, r10_76 in ipairs(r3_76) do
      if r1_76[r10_76] and (r4_76 == 0 or r5_76 < r4_76) then
        weaponSave[r10_76] = true
        r5_76 = r5_76 + 1
      end
    end
    remakeWeaponsPack()
  end
  local r3_53 = {}
  function onClientPauseRender()
    -- line: [443, 477] id: 77
    dxDrawRectangle(0, 0, xscreen, yscreen, tocolor(0, 0, 0, 96))
    dxDrawText(getLanguageString("pause"), xscreen * 0.502, yscreen * 0.352, xscreen * 0.502, yscreen * 0.352, tocolor(0, 0, 0), getFont(2), "default-bold", "center", "bottom")
    dxDrawText(getLanguageString("pause"), xscreen * 0.5, yscreen * 0.35, xscreen * 0.5, yscreen * 0.35, tocolor(0, 128, 255), getFont(2), "default-bold", "center", "bottom")
    local r0_77 = getTacticsData("Unpause")
    if r0_77 then
      local r1_77 = r0_77 - getTickCount() + addTickCount
      dxDrawText(string.format(getLanguageString("unpausing_in"), r1_77 / 1000), xscreen * 0.502, yscreen * 0.352, xscreen * 0.502, yscreen * 0.352, tocolor(0, 0, 0), getFont(1), "default", "center", "top")
      dxDrawText(string.format(getLanguageString("unpausing_in"), r1_77 / 1000), xscreen * 0.5, yscreen * 0.35, xscreen * 0.5, yscreen * 0.35, tocolor(255, 255, 255), getFont(1), "default", "center", "top")
    end
    local r1_77 = getPedTask(localPlayer, "primary", 1)
    local r2_77 = getPedTask(localPlayer, "primary", 3)
    local r3_77 = getPedTask(localPlayer, "primary", 4)
    for r7_77, r8_77 in ipairs(getElementsByType("projectile", root, true)) do
      if r3_53[r8_77] then
        local r9_77, r10_77, r11_77, r12_77, r13_77, r14_77 = unpack(r3_53[r8_77])
        setElementPosition(r8_77, r9_77, r10_77, r11_77, false)
        setElementVelocity(r8_77, r12_77, r13_77, r14_77)
      else
        local r9_77, r10_77, r11_77 = getElementPosition(r8_77)
        local r12_77, r13_77, r14_77 = getElementVelocity(r8_77)
        r3_53[r8_77] = {
          r9_77,
          r10_77,
          r11_77,
          r12_77,
          r13_77,
          r14_77
        }
      end
    end
    if getElementData(localPlayer, "Status") == "Play" and r3_77 == "TASK_SIMPLE_PLAYER_ON_FOOT" and r1_77 ~= "TASK_COMPLEX_IN_AIR_AND_LAND" and r2_77 ~= "TASK_COMPLEX_JUMP" then
      if not xpause then
        xpause, ypause, zpause = getElementPosition(localPlayer)
        rpause = getPedRotation(localPlayer)
      end
      setElementPosition(localPlayer, xpause, ypause, zpause, false)
      setPedRotation(localPlayer, rpause)
    elseif xpause then
      xpause = nil
    end
  end
  local r4_53 = ""
  local r5_53 = ""
  local r6_53 = 4294967295
  local r7_53 = 4278190080
  local r8_53 = xscreen * 0.5
  local r9_53 = yscreen * 0.35
  local r10_53 = xscreen * 0.502
  local r11_53 = yscreen * 0.352
  local r12_53 = getFont(2)
  local r13_53 = getFont(1)
  function onClientMessageRender()
    -- line: [486, 491] id: 78
    dxDrawText(r4_53, r10_53, r11_53, r10_53, r11_53, r7_53, r12_53, "default-bold", "center", "bottom")
    dxDrawText(r4_53, r8_53, r9_53, r8_53, r9_53, r6_53, r12_53, "default-bold", "center", "bottom")
    dxDrawText(r5_53, r10_53, r11_53, r10_53, r11_53, r7_53, r13_53, "default", "center", "top")
    dxDrawText(r5_53, r8_53, r9_53, r8_53, r9_53, 4294967295, r13_53, "default", "center", "top")
  end
  function onClientPlayerTarget(r0_79)
    -- line: [492, 497] id: 79
    if r0_79 and not r0_53 then
      r0_53 = true
      addEventHandler("onClientRender", root, onClientVehicleNametagRender)
    end
  end
  local r14_53 = yscreen * 0.011
  local r15_53 = xscreen * 0.06
  local r16_53 = yscreen * 0.025
  local r17_53 = xscreen * 0.003
  function onClientVehicleNametagRender()
    -- line: [502, 521] id: 80
    local r0_80 = getPedTarget(localPlayer)
    if r0_80 and getElementType(r0_80) == "vehicle" then
      local r1_80, r2_80, r3_80 = getElementPosition(r0_80)
      local r4_80, r5_80 = getScreenFromWorldPosition(r1_80, r2_80, r3_80)
      if r4_80 then
        local r6_80 = (getElementHealth(r0_80) - 250) / 750
        if r6_80 < 0 then
          r6_80 = 0
        end
        local r7_80 = math.floor(512 * (1 - r6_80))
        local r8_80 = math.floor(512 * r6_80)
        r7_80 = math.min(math.max(r7_80, 0), 255)
        r8_80 = math.min(math.max(r8_80, 0), 255)
        dxDrawRectangle(r4_80 - 0.5 * r15_53 - r17_53, r5_80 - 0.5 * r14_53 - r17_53 + r16_53, r15_53 + 2 * r17_53, r14_53 + 2 * r17_53, tocolor(0, 0, 0, 180))
        dxDrawRectangle(r4_80 - 0.5 * r15_53 + r15_53 * r6_80, r5_80 - 0.5 * r14_53 + r16_53, (1 - r6_80) * r15_53, r14_53, tocolor(math.floor(0.33 * r7_80), math.floor(0.33 * r8_80), 0, 180))
        dxDrawRectangle(r4_80 - 0.5 * r15_53, r5_80 - 0.5 * r14_53 + r16_53, r15_53 * r6_80, r14_53, tocolor(r7_80, r8_80, 0, 180))
      end
    else
      r0_53 = false
      removeEventHandler("onClientRender", root, onClientVehicleNametagRender)
    end
  end
  function forcedChangeTeam()
    -- line: [522, 552] id: 81
    if guiGetInputEnabled() then
      return 
    end
    if getElementData(localPlayer, "Status") == "Joining" then
      return 
    end
    if getTacticsData("Map") == "lobby" then
      if guiGetVisible(team_window) then
        guiSetVisible(team_window, false)
        if isAllGuiHidden() then
          showCursor(false)
        end
      else
        updateTeamManager()
        guiBringToFront(team_window)
        guiSetVisible(team_window, true)
        showCursor(true)
      end
    elseif not getElementData(localPlayer, "ChangeTeam") then
      setElementData(localPlayer, "ChangeTeam", true)
      outputChatBox(getLanguageString("team_change_set"), 255, 100, 100)
    else
      setElementData(localPlayer, "ChangeTeam", nil)
      outputChatBox(getLanguageString("team_change_cancel"), 255, 100, 100)
    end
  end
  function onClientWeaponDisable()
    -- line: [553, 555] id: 82
    setElementData(localPlayer, "Weapons", nil)
  end
  function onClientElementDataChange(r0_83, r1_83)
    -- line: [556, 618] id: 83
    if r0_83 == "Status" and getElementType(source) == "player" then
      triggerEvent("onClientPlayerGameStatusChange", source, r1_83)
      triggerEvent("onClientPlayerBlipUpdate", source)
    end
    if source == localPlayer then
      if r0_83 == "Prepair" then
        if getElementData(localPlayer, "Prepair") and not r1_83 then
          r1_53 = nil
          r2_53 = nil
          addEventHandler("onClientPreRender", root, onClientPrepairRender)
        elseif not getElementData(localPlayer, "Prepair") and r1_83 then
          removeEventHandler("onClientPreRender", root, onClientPrepairRender)
          r1_53 = nil
          r2_53 = nil
        end
      end
      if r0_83 == "Weapons" then
        if getElementData(localPlayer, "Weapons") == true then
          addEventHandler("onClientPlayerWeaponFire", localPlayer, onClientWeaponDisable)
        else
          removeEventHandler("onClientPlayerWeaponFire", localPlayer, onClientWeaponDisable)
        end
      end
      if r0_83 == "Loading" then
        if getElementData(localPlayer, "Loading") and not r1_83 then
          notreadyCounter = nil
          fadeCamera(false, 0)
          addEventHandler("onClientRender", root, onDownloadCompleteingRender)
        elseif not getElementData(localPlayer, "Loading") and r1_83 then
          removeEventHandler("onClientRender", root, onDownloadCompleteingRender)
          fadeCamera(true, 0)
        end
      end
    end
    if r0_83 == "Helpme" and source ~= localPlayer then
      local r2_83 = getElementData(source, r0_83)
      local r3_83 = getPlayerTeam(localPlayer)
      local r4_83 = getPlayerTeam(source)
      if r2_83 and r3_83 and (r3_83 == getElementsByType("team")[1] or r3_83 == r4_83) then
        if isTimer(helpme[source]) then
          killTimer(helpme[source])
        end
        helpme[source] = setTimer(function(r0_84)
          -- line: [597, 611] id: 84
          if not isElement(r0_84) or not getElementData(r0_84, "Helpme") then
            killTimer(helpme[r0_84])
          end
          if isElement(helpmeArrow[r0_84]) then
            destroyElement(helpmeArrow[r0_84])
          else
            helpmeArrow[r0_84] = createMarker(0, 0, 0, "arrow", 0.5, 255, 255, 0, 128)
            attachElements(helpmeArrow[r0_84], r0_84, 0, 0, 2)
            setElementInterior(helpmeArrow[r0_84], getElementInterior(r0_84))
            setElementParent(helpmeArrow[r0_84], r0_84)
            setElementParent(createBlipAttachedTo(helpmeArrow[r0_84], 0, 2, 255, 255, 0, 255, 1), helpmeArrow[r0_84])
          end
        end, 250, 0, source)
        outputChatBox(string.format(getLanguageString("help_me"), getPlayerName(source)), 255, 100, 100, true)
      else
        if isTimer(helpme[source]) then
          killTimer(helpme[source])
        end
        if isElement(helpmeArrow[source]) then
          destroyElement(helpmeArrow[source])
        end
      end
    end
  end
  function onClientTacticsChange(r0_85, r1_85)
    -- line: [619, 830] id: 85
    if r0_85[1] == "version" then
      local r2_85 = getTacticsData("version")
      guiSetText(label_version, "Tactics " .. tostring(r2_85))
      guiSetText(credits_window, "Tactics " .. tostring(r2_85))
      guiSetText(credits_version, "Tactics " .. tostring(r2_85))
    end
    if r0_85[1] == "message" then
      local r2_85 = getTacticsData("message")
      if r2_85 then
        r4_53 = ""
        r5_53 = ""
        r6_53 = 4294967295
        if type(r2_85[1]) == "table" then
          if type(r2_85[1][1]) == "string" then
            local r3_85 = r2_85[1][1]
            local r4_85 = r2_85[1]
            table.remove(r4_85, 1)
            if #r4_85 > 0 then
              r4_53 = string.format(getLanguageString(r3_85), unpack(r4_85))
            elseif r3_85 then
              r4_53 = getLanguageString(r3_85)
            end
            if #r4_53 == 0 then
              r4_53 = tostring(r3_85)
            end
          elseif type(r2_85[1][4]) == "string" then
            local r3_85 = tonumber(r2_85[1][1])
            local r4_85 = tonumber(r2_85[1][2])
            local r5_85 = tonumber(r2_85[1][3])
            local r6_85 = r2_85[1][4]
            local r7_85 = r2_85[1]
            r6_53 = tocolor(r3_85, r4_85, r5_85)
            if #r7_85 > 4 then
              table.remove(r7_85, 4)
              table.remove(r7_85, 3)
              table.remove(r7_85, 2)
              table.remove(r7_85, 1)
              r4_53 = string.format(getLanguageString(r6_85), unpack(r7_85))
            elseif r6_85 then
              r4_53 = getLanguageString(r6_85)
            end
            if #r4_53 == 0 then
              r4_53 = tostring(r6_85)
            end
          end
        elseif type(r2_85[1]) == "string" then
          r4_53 = getLanguageString(r2_85[1])
          if #r4_53 == 0 then
            r4_53 = tostring(r2_85[1])
          end
        else
          r4_53 = tostring(r2_85[1])
        end
        if type(r2_85[2]) == "table" then
          local r3_85 = r2_85[2][1]
          local r4_85 = r2_85[2]
          table.remove(r4_85, 1)
          r5_53 = string.format(getLanguageString(tostring(r3_85)), unpack(r4_85))
        elseif type(r2_85[2]) == "string" then
          r5_53 = getLanguageString(r2_85[2])
          if #r5_53 == 0 then
            r5_53 = tostring(r2_85[2])
          end
        else
          r5_53 = tostring(r2_85[2])
        end
        r4_53 = removeColorCoding(r4_53)
        r5_53 = removeColorCoding(r5_53)
      end
      if r2_85 and not r1_85 then
        addEventHandler("onClientRender", root, onClientMessageRender)
      elseif not r2_85 and r1_85 then
        removeEventHandler("onClientRender", root, onClientMessageRender)
      end
    end
    if r0_85[1] == "Pause" then
      local r2_85 = getTacticsData("Pause")
      if r2_85 and not r1_85 then
        addEventHandler("onClientRender", root, onClientPauseRender)
      elseif not r2_85 and r1_85 then
        removeEventHandler("onClientRender", root, onClientPauseRender)
        xpause = nil
      end
    end
    if r0_85[1] == "weaponspack" or r0_85[1] == "weapon_balance" or r0_85[1] == "weapon_cost" then
      remakeWeaponsPack()
    end
    if r0_85[1] == "weapon_slots" then
      local r2_85 = getTacticsData("weapon_slots") or 0
      if r2_85 > 0 then
        local r3_85 = 0
        if isElement(weapon_window) then
          guiSetText(weapon_slots, "You can choice " .. r2_85 .. " weapons")
          for r7_85, r8_85 in ipairs(weapon_items) do
            if guiGetProperty(r8_85.gui, "ImageColours") == "tl:80FFFFFF tr:80FFFFFF bl:80FFFFFF br:80FFFFFF" then
              r3_85 = r3_85 + 1
              if r2_85 < r3_85 then
                guiSetProperty(r8_85.gui, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
                weaponSave[guiGetText(r8_85.name)] = nil
              end
            end
          end
        else
          for r7_85 in pairs(weaponSave) do
            r3_85 = r3_85 + 1
            if r2_85 < r3_85 then
              weaponSave[r7_85] = nil
            end
          end
        end
        if r2_85 < r3_85 then
          updateSaveWeapons()
        end
      elseif isElement(weapon_window) then
        guiSetText(weapon_slots, "You can choice any weapons")
      end
    end
    if r0_85[1] == "settings" then
      if r0_85[2] == "ghostmode" then
        local r2_85 = getTacticsData("settings", "ghostmode")
        if r2_85 == "all" or r2_85 == "team" then
          setCameraClip(true, false)
        else
          setCameraClip(true, true)
        end
        for r6_85, r7_85 in ipairs(getElementsByType("player", root, true)) do
          for r11_85, r12_85 in ipairs(getElementsByType("player", root, true)) do
            if r2_85 == "all" then
              setElementCollidableWith(r7_85, r12_85, false)
            elseif r2_85 == "team" and getPlayerTeam(r7_85) == getPlayerTeam(r12_85) then
              setElementCollidableWith(r7_85, r12_85, false)
            else
              setElementCollidableWith(r7_85, r12_85, true)
            end
          end
        end
        for r6_85, r7_85 in ipairs(getElementsByType("vehicle", root, true)) do
          for r11_85, r12_85 in ipairs(getElementsByType("vehicle", root, true)) do
            if r2_85 == "all" then
              setElementCollidableWith(r7_85, r12_85, false)
            elseif r2_85 == "team" and getVehicleController(r7_85) and getVehicleController(r12_85) and getPlayerTeam(getVehicleController(r7_85)) == getPlayerTeam(getVehicleController(r12_85)) then
              setElementCollidableWith(r7_85, r12_85, false)
            else
              setElementCollidableWith(r7_85, r12_85, true)
            end
          end
        end
      end
      if r0_85[2] == "time" then
        updateWeather()
      end
      if r0_85[2] == "time_minuteduration" then
        updateWeather()
      end
      if r0_85[2] == "gravity" then
        setGravity(tonumber(getTacticsData("settings", "gravity")))
      end
      if r0_85[2] == "player_radarblip" or r0_85[2] == "player_nametag" then
        triggerEvent("onClientPlayerBlipUpdate", localPlayer)
      end
      if r0_85[2] == "blurlevel" then
        setBlurLevel(tonumber(getTacticsData("settings", "blurlevel")) or 36)
      end
      if r0_85[2] == "heli_killing" then
        if getTacticsData("settings", "heli_killing") == "false" then
          addEventHandler("onClientPlayerHeliKilled", root, cancelEvent)
          addEventHandler("onClientPedHeliKilled", root, cancelEvent)
        else
          removeEventHandler("onClientPlayerHeliKilled", root, cancelEvent)
          removeEventHandler("onClientPedHeliKilled", root, cancelEvent)
        end
      end
      if r0_85[2] == "stealth_killing" then
        if getTacticsData("settings", "stealth_killing") == "false" then
          addEventHandler("onClientPlayerStealthKill", localPlayer, cancelEvent)
        else
          removeEventHandler("onClientPlayerStealthKill", localPlayer, cancelEvent)
        end
      end
      if r0_85[2] == "vehicle_radarblip" then
        local r2_85 = getTacticsData("settings", "vehicle_radarblip")
        for r6_85, r7_85 in ipairs(getElementsByType("vehicle")) do
          local r8_85 = getElementData(r7_85, "Blip")
          if r8_85 then
            local r9_85 = 0
            local r10_85 = 0
            local r11_85 = 0
            local r12_85 = 0
            if r2_85 == "always" then
              r12_85 = 128
              r11_85 = 128
              r10_85 = 128
              r9_85 = 128
            elseif r2_85 == "unoccupied" then
              local r13_85 = false
              local r14_85 = getVehicleOccupants(r7_85)
              for r19_85 = 0, getVehicleMaxPassengers(r7_85), 1 do
                if r14_85[r19_85] then
                  r13_85 = true
                  break
                end
              end
              if not r13_85 and not getVehicleController(r7_85) then
                r12_85 = 128
                r11_85 = 128
                r10_85 = 128
                r9_85 = 128
              end
            end
            setBlipColor(r8_85, r9_85, r10_85, r11_85, r12_85)
          end
        end
      end
      if r0_85[2] == "vehicle_nametag" then
        if getTacticsData("settings", "vehicle_nametag") == "true" then
          addEventHandler("onClientPlayerTarget", localPlayer, onClientPlayerTarget)
        else
          if r0_53 then
            r0_53 = false
            removeEventHandler("onClientRender", root, onClientVehicleNametagRender)
          end
          removeEventHandler("onClientPlayerTarget", localPlayer, onClientPlayerTarget)
        end
      end
    end
    if r0_85[1] == "MapName" then
      guiSetText(mapstring, tostring(getTacticsData("MapName", false)))
    end
    if r0_85[1] == "Weather" then
      updateWeatherBlend()
      updateWeather(true)
    end
  end
  function onClientElementStreamIn()
    -- line: [831, 887] id: 86
    -- notice: unreachable block#37
    if getElementType(source) == "player" then
      local r0_86 = getTacticsData("settings", "ghostmode")
      for r4_86, r5_86 in ipairs(getElementsByType("player", root, true)) do
        if r0_86 == "all" then
          setElementCollidableWith(r5_86, source, false)
          setElementCollidableWith(source, r5_86, false)
        elseif r0_86 == "team" and getPlayerTeam(r5_86) == getPlayerTeam(source) then
          setElementCollidableWith(r5_86, source, false)
          setElementCollidableWith(source, r5_86, false)
        else
          setElementCollidableWith(r5_86, source, true)
          setElementCollidableWith(source, r5_86, true)
        end
      end
    end
    if getElementType(source) == "vehicle" then
      local r0_86 = getTacticsData("settings", "ghostmode")
      for r4_86, r5_86 in ipairs(getElementsByType("vehicle", root, true)) do
        if r0_86 == "all" then
          setElementCollidableWith(r5_86, source, false)
          setElementCollidableWith(source, r5_86, false)
        elseif r0_86 == "all" and getVehicleController(r5_86) and getVehicleController(source) and getElementType(getVehicleController(r5_86)) == "player" and getElementType(getVehicleController(source)) == "player" and getPlayerTeam(getVehicleController(r5_86)) == getPlayerTeam(getVehicleController(source)) then
          setElementCollidableWith(r5_86, source, false)
          setElementCollidableWith(source, r5_86, false)
        else
          setElementCollidableWith(r5_86, source, true)
          setElementCollidableWith(source, r5_86, true)
        end
      end
      if not getElementData(source, "Blip") then
        local r1_86 = getTacticsData("settings", "vehicle_radarblip")
        local r2_86 = 0
        local r3_86 = 0
        local r4_86 = 0
        local r5_86 = 0
        if r1_86 == "always" then
          r5_86 = 128
          r4_86 = 128
          r3_86 = 128
          r2_86 = 128
        elseif r1_86 == "unoccupied" then
          local r6_86 = false
          local r7_86 = getVehicleOccupants(source)
          for r12_86 = 0, getVehicleMaxPassengers(source), 1 do
            if r7_86[r12_86] then
              r6_86 = true
              break
            end
          end
          if not r6_86 and not getVehicleController(source) then
            r5_86 = 128
            r4_86 = 128
            r3_86 = 128
            r2_86 = 128
          end
        end
        local r6_86 = createBlipAttachedTo(source, 0, 0, r2_86, r3_86, r4_86, r5_86, -1)
        setElementData(source, "Blip", r6_86, false)
        setElementParent(r6_86, source)
      end
      local r1_86 = getTacticsData("settings", "vehicle_tank_explodable")
      if r1_86 == "true" then
        r1_86 = true
      else
        r1_86 = false
      end
      setVehicleFuelTankExplodable(source, r1_86)
    end
  end
  function onClientGUIClick(r0_87, r1_87, r2_87, r3_87)
    -- line: [888, 1025] id: 87
    if r0_87 ~= "left" then
      return 
    end
    if source == weapon_accept then
      guiSetVisible(weapon_window, false)
      if isAllGuiHidden() then
        showCursor(false)
      end
      if not getElementData(localPlayer, "Weapons") then
        if guiCheckBoxGetSelected(config_performance_weapmanager) then
          destroyElement(weapon_window)
        end
        return outputChatBox(getLanguageString("weapon_choice_disabled"), 255, 100, 100)
      end
      local r4_87 = {}
      local r5_87 = getTacticsData("weaponspack") or {}
      for r9_87 in pairs(weaponSave) do
        table.insert(r4_87, {
          id = convertWeaponNamesToID[r9_87],
          ammo = math.max(tonumber(r5_87[r9_87]) or 0, 1),
          name = r9_87,
        })
      end
      callServerFunction("onPlayerWeaponpackChose", localPlayer, r4_87)
      if guiCheckBoxGetSelected(config_performance_weapmanager) then
        destroyElement(weapon_window)
      end
    end
    if source == weapon_close then
      guiSetVisible(weapon_window, false)
      if isAllGuiHidden() then
        showCursor(false)
      end
      if guiCheckBoxGetSelected(config_performance_weapmanager) then
        destroyElement(weapon_window)
      end
    end
    if source == team_close then
      guiSetVisible(team_window, false)
      if isAllGuiHidden() then
        showCursor(false)
      end
    end
    if guiGetVisible(team_window) then
      for r7_87, r8_87 in ipairs(team_button) do
        if source == r8_87 then
          local r9_87 = getTeamFromName(tostring(guiGetText(source)))
          local r10_87 = getElementData(r9_87, "Skins")
          if not r10_87 then
            r10_87 = {}
            local r11_87 = 71
            -- setlist for #10 failed
          end
          triggerServerEvent("onPlayerTeamSelect", localPlayer, r9_87, r10_87[1])
          guiSetVisible(team_window, false)
          if isAllGuiHidden() then
            showCursor(false)
            break
          else
            break
          end
        end
      end
    end
    if source == team_specskinbtn then
      guiCheckBoxSetSelected(team_specskin, not guiCheckBoxGetSelected(team_specskin))
      setElementData(localPlayer, "spectateskin", guiCheckBoxGetSelected(team_specskin))
    end
    if source == team_specskin then
      setElementData(localPlayer, "spectateskin", guiCheckBoxGetSelected(team_specskin))
    end
    if source == team_joining then
      callServerFunction("warpPlayerToJoining", localPlayer)
      guiSetVisible(team_window, false)
      if isAllGuiHidden() then
        showCursor(false)
      end
    end
    if source == vehicle_car or source == vehicle_bike or source == vehicle_plane or source == vehicle_heli or source == vehicle_boat then
      updateVehicleList()
    end
    if source == vehicle_getvehicle then
      local r4_87 = guiGridListGetSelectedItem(vehicle_list)
      if r4_87 ~= -1 then
        local r5_87 = getVehicleModelFromName(guiGridListGetItemText(vehicle_list, r4_87, 1))
        if r5_87 then
          local r6_87 = nil
          local r7_87 = getPedOccupiedVehicle(localPlayer)
          if r7_87 then
            r6_87 = getElementDistanceFromCentreOfMassToBaseOfModel(r7_87)
          end
          callServerFunction("onPlayerVehicleSelect", localPlayer, r5_87, r6_87)
          guiSetVisible(vehicle_window, false)
          if isAllGuiHidden() then
            showCursor(false)
          end
          if guiCheckBoxGetSelected(config_performance_vehmanager) then
            destroyElement(vehicle_window)
          end
        end
      end
    end
    if source == vehicle_close then
      guiSetVisible(vehicle_window, false)
      if isAllGuiHidden() then
        showCursor(false)
      end
      if guiCheckBoxGetSelected(config_performance_vehmanager) then
        destroyElement(vehicle_window)
      end
    end
    if source == credits_close then
      guiSetVisible(credits_window, false)
      if isAllGuiHidden() then
        showCursor(false)
      end
    end
    if source == weapon_memory then
      if guiCheckBoxGetSelected(weapon_memory) then
        weaponMemory = true
        local r4_87 = {}
        for r8_87, r9_87 in ipairs(weapon_items) do
          if guiGetProperty(r9_87.gui, "ImageColours") == "tl:80FFFFFF tr:80FFFFFF bl:80FFFFFF br:80FFFFFF" then
            table.insert(r4_87, guiGetText(r9_87.name))
          end
        end
        if #r4_87 > 1 then
          table.sort(r4_87, function(r0_88, r1_88)
            -- line: [977, 977] id: 88
            return r0_88 < r1_88
          end)
        end
        xmlNodeSetAttribute(xmlFindChild(_client, "weaponpack", 0) or xmlCreateChild(_client, "weaponpack"), "selected", toJSON(r4_87))
      else
        weaponMemory = false
        local r4_87 = xmlFindChild(_client, "weaponpack", 0)
        if r4_87 then
          xmlDestroyNode(r4_87)
        end
      end
      xmlSaveFile(_client)
    end
    if isElement(weapon_window) and guiGetVisible(weapon_window) then
      local r4_87 = false
      for r8_87, r9_87 in ipairs(weapon_items) do
        if source == r9_87.gui then
          local r10_87 = getTacticsData("weapon_slot") or {}
          r4_87 = true
          local r11_87 = guiGetText(r9_87.name)
          if guiGetProperty(r9_87.gui, "ImageColours") ~= "tl:80FFFFFF tr:80FFFFFF bl:80FFFFFF br:80FFFFFF" then
            local r12_87 = convertWeaponNamesToID[r11_87]
            local r13_87 = tonumber(r10_87[r11_87])
            if not r13_87 then
              if r12_87 then
                r13_87 = getSlotFromWeapon(r12_87) or 13
              else
                goto label_459	-- block#88 is visited secondly
              end
            end
            for r17_87, r18_87 in ipairs(weapon_items) do
              if guiGetProperty(r18_87.gui, "ImageColours") == "tl:80FFFFFF tr:80FFFFFF bl:80FFFFFF br:80FFFFFF" then
                local r19_87 = guiGetText(r18_87.name)
                local r20_87 = convertWeaponNamesToID[r19_87]
                local r21_87 = tonumber(r10_87[r19_87])
                if not r21_87 then
                  if r20_87 then
                    r21_87 = getSlotFromWeapon(r20_87) or 13
                  else
                    goto label_487	-- block#94 is visited secondly
                  end
                end
                if r13_87 == r21_87 then
                  guiSetProperty(r18_87.gui, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
                  weaponSave[r19_87] = nil
                end
              end
            end
            local r14_87 = getTacticsData("weapon_slots") or 0
            local r15_87 = 0
            for r19_87 in pairs(weaponSave) do
              r15_87 = r15_87 + 1
            end
            if r14_87 == 0 or r15_87 < r14_87 then
              guiSetProperty(r9_87.gui, "ImageColours", "tl:80FFFFFF tr:80FFFFFF bl:80FFFFFF br:80FFFFFF")
              weaponSave[r11_87] = true
              break
            else
              break
            end
          elseif guiGetProperty(r9_87.gui, "ImageColours") == "tl:80FFFFFF tr:80FFFFFF bl:80FFFFFF br:80FFFFFF" then
            guiSetProperty(r9_87.gui, "ImageColours", "tl:20FFFFFF tr:20FFFFFF bl:20FFFFFF br:20FFFFFF")
            weaponSave[r11_87] = nil
            break
          else
            break
          end
        end
      end
      if r4_87 then
        updateSaveWeapons()
      end
    end
  end
  function updateSaveWeapons()
    -- line: [1026, 1047] id: 89
    local r1_89 = fromJSON(xmlNodeGetAttribute(xmlFindChild(_client, "weaponpack", 0) or xmlCreateChild(_client, "weaponpack"), "selected") or "[ [ ] ]")
    local r2_89 = {}
    for r6_89, r7_89 in pairs(weaponSave) do
      table.insert(r2_89, r6_89)
    end
    if #r2_89 > 1 then
      table.sort(r2_89, function(r0_90, r1_90)
        -- line: [1034, 1034] id: 90
        return r0_90 < r1_90
      end)
    end
    local r3_89 = true
    for r7_89, r8_89 in ipairs(r1_89) do
      if r8_89 ~= r2_89[r7_89] then
        r3_89 = false
        break
      end
    end
    if #r1_89 ~= #r2_89 or #r1_89 == 0 then
      r3_89 = false
    end
    weaponMemory = r3_89
    if isElement(weapon_window) then
      guiCheckBoxSetSelected(weapon_memory, r3_89)
    end
  end
  function onClientGUIDoubleClick(r0_91, r1_91, r2_91, r3_91)
    -- line: [1048, 1065] id: 91
    if r0_91 ~= "left" then
      return 
    end
    if source == vehicle_list then
      local r4_91 = guiGridListGetSelectedItem(vehicle_list)
      if r4_91 ~= -1 then
        local r5_91 = getVehicleModelFromName(guiGridListGetItemText(vehicle_list, r4_91, 1))
        if r5_91 then
          local r6_91 = nil
          local r7_91 = getPedOccupiedVehicle(localPlayer)
          if r7_91 then
            r6_91 = getElementDistanceFromCentreOfMassToBaseOfModel(r7_91)
          end
          callServerFunction("onPlayerVehicleSelect", localPlayer, r5_91, r6_91)
          guiSetVisible(vehicle_window, false)
          if isAllGuiHidden() then
            showCursor(false)
          end
          if guiCheckBoxGetSelected(config_performance_vehmanager) then
            destroyElement(vehicle_window)
          end
        end
      end
    end
  end
  function onClientGUIChanged(r0_92)
    -- line: [1066, 1070] id: 92
    if source == vehicle_search then
      updateVehicleList()
    end
  end
  function onClientMouseEnter(r0_93, r1_93)
    -- line: [1071, 1114] id: 93
    if isElement(weapon_window) and guiGetVisible(weapon_window) then
      for r5_93, r6_93 in ipairs(weapon_items) do
        if source == r6_93.gui then
          if guiGetProperty(r6_93.gui, "ImageColours") == "tl:00000000 tr:00000000 bl:00000000 br:00000000" then
            guiSetProperty(r6_93.gui, "ImageColours", "tl:20FFFFFF tr:20FFFFFF bl:20FFFFFF br:20FFFFFF")
          end
          local r7_93 = guiGetText(r6_93.name)
          local r8_93 = convertWeaponNamesToID[r7_93] or 0
          local r9_93 = "Name: " .. r7_93
          local r10_93 = "-"
          if r7_93 == "grenade" or r7_93 == "satchel" or r7_93 == "rocket" or r7_93 == "headseek" then
            r9_93 = r9_93 .. "\nDamage: explosion"
          elseif r7_93 == "teargas" or r7_93 == "spray" or r7_93 == "fireextinguisher" then
            r9_93 = r9_93 .. "\nDamage: gas"
          elseif r7_93 == "flame" or r7_93 == "molotov" then
            r9_93 = r9_93 .. "\nDamage: fire"
          elseif 22 <= r8_93 and r8_93 <= 39 and getWeaponProperty(r8_93, "pro", "damage") then
            if r7_93 == "shotgun" or r7_93 == "sawnoff" then
              r9_93 = r9_93 .. "\nDamage: " .. string.format("shot %.1f ~ %.1f hp", getWeaponProperty(r8_93, "pro", "damage") / 3, getWeaponProperty(r8_93, "pro", "damage") * 5)
            elseif r7_93 == "spas12" then
              r9_93 = r9_93 .. "\nDamage: " .. string.format("shot %.1f ~ %.1f hp", getWeaponProperty(r8_93, "pro", "damage") / 3, getWeaponProperty(r8_93, "pro", "damage") * 2.66)
            else
              r9_93 = r9_93 .. "\nDamage: " .. string.format("bullet %.1f hp", getWeaponProperty(r8_93, "pro", "damage") / 3)
            end
          else
            r9_93 = r9_93 .. "\nDamage: -"
          end
          if 22 <= r8_93 and r8_93 <= 39 then
            local r11_93 = getWeaponProperty(r8_93, "pro", "anim_loop_start")
            local r12_93 = getWeaponProperty(r8_93, "pro", "anim_loop_stop")
            if r11_93 and r12_93 then
              r9_93 = r9_93 .. "\nFire Rate: " .. math.floor(60 / (r12_93 - r11_93)) .. " r/min"
            end
            if getWeaponProperty(r8_93, "pro", "weapon_range") then
              r9_93 = r9_93 .. "\nRange: " .. math.floor(getWeaponProperty(r8_93, "pro", "weapon_range")) .. " m"
            end
          end
          guiSetText(weapon_properties, r9_93)
        end
      end
    end
  end
  function onClientMouseLeave(r0_94, r1_94)
    -- line: [1115, 1126] id: 94
    if isElement(weapon_window) and guiGetVisible(weapon_window) then
      for r5_94, r6_94 in ipairs(weapon_items) do
        if source == r6_94.gui then
          if guiGetProperty(r6_94.gui, "ImageColours") == "tl:20FFFFFF tr:20FFFFFF bl:20FFFFFF br:20FFFFFF" then
            guiSetProperty(r6_94.gui, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
          end
          guiSetText(weapon_properties, "")
        end
      end
    end
  end
  function toggleVehicleManager(r0_95, r1_95)
    -- line: [1127, 1169] id: 95
    if r1_95 then
      if getVehicleModelFromName(r1_95) then
        r1_95 = getVehicleModelFromName(r1_95)
      else
        r1_95 = math.floor(tonumber(r1_95))
      end
      if not ((getTacticsData("disabled_vehicles") or {}))[r1_95] and 400 <= r1_95 and r1_95 <= 611 then
        local r3_95 = nil
        local r4_95 = getPedOccupiedVehicle(localPlayer)
        if r4_95 then
          r3_95 = getElementDistanceFromCentreOfMassToBaseOfModel(r4_95)
        end
        callServerFunction("onPlayerVehicleSelect", localPlayer, r1_95, r3_95)
        if isElement(vehicle_window) and guiGetVisible(vehicle_window) then
          guiSetVisible(vehicle_window, false)
          if isAllGuiHidden() then
            showCursor(false)
          end
          if guiCheckBoxGetSelected(config_performance_vehmanager) then
            destroyElement(vehicle_window)
          end
        end
      elseif not isElement(vehicle_window) or not guiGetVisible(vehicle_window) then
        if not isElement(vehicle_window) then
          createVehicleManager()
        end
        guiBringToFront(vehicle_window)
        guiSetVisible(vehicle_window, true)
        showCursor(true)
      elseif isElement(vehicle_window) and guiGetVisible(vehicle_window) then
        guiSetVisible(vehicle_window, false)
        if isAllGuiHidden() then
          showCursor(false)
        end
        if guiCheckBoxGetSelected(config_performance_vehmanager) then
          destroyElement(vehicle_window)
        end
      end
    elseif not isElement(vehicle_window) or not guiGetVisible(vehicle_window) then
      if not isElement(vehicle_window) then
        createVehicleManager()
      end
      guiBringToFront(vehicle_window)
      guiSetVisible(vehicle_window, true)
      showCursor(true)
    elseif isElement(vehicle_window) and guiGetVisible(vehicle_window) then
      guiSetVisible(vehicle_window, false)
      if isAllGuiHidden() then
        showCursor(false)
      end
      if guiCheckBoxGetSelected(config_performance_vehmanager) then
        destroyElement(vehicle_window)
      end
    end
  end
  function updateVehicleList()
    -- line: [1170, 1212] id: 96
    local r0_96 = guiCheckBoxGetSelected(vehicle_car)
    local r1_96 = guiCheckBoxGetSelected(vehicle_bike)
    local r2_96 = guiCheckBoxGetSelected(vehicle_plane)
    local r3_96 = guiCheckBoxGetSelected(vehicle_heli)
    local r4_96 = guiCheckBoxGetSelected(vehicle_boat)
    local r5_96 = guiGetText(vehicle_search)
    local r6_96 = getTacticsData("disabled_vehicles") or {}
    local r7_96 = {}
    for r11_96 = 400, 611, 1 do
      local r12_96 = getVehicleNameFromModel(r11_96)
      if not r6_96[r11_96] and 0 < #r12_96 then
        local r13_96 = false
        local r14_96 = getVehicleType(r11_96)
        if r0_96 and (r14_96 == "Automobile" or r14_96 == "Monster Truck") then
          r13_96 = true
        end
        if r1_96 and (r14_96 == "Bike" or r14_96 == "BMX" or r14_96 == "Quad") then
          r13_96 = true
        end
        if r2_96 and r14_96 == "Plane" then
          r13_96 = true
        end
        if r3_96 and r14_96 == "Helicopter" then
          r13_96 = true
        end
        if r4_96 and r14_96 == "Boat" then
          r13_96 = true
        end
        if #r5_96 > 0 then
          for r18_96 in string.gmatch(r5_96, "[^ ]+") do
            if string.sub(r18_96, 1, 1) == "-" then
              r18_96 = string.sub(r18_96, 2, -1)
              if string.find(tostring(r11_96), r18_96) or string.find(string.lower(r12_96), string.lower(r18_96)) then
                r13_96 = false
              end
            elseif not string.find(tostring(r11_96), r18_96) and not string.find(string.lower(r12_96), string.lower(r18_96)) then
              r13_96 = false
            end
          end
        end
        if r13_96 then
          table.insert(r7_96, {
            r11_96,
            r12_96
          })
        end
      end
    end
    table.sort(r7_96, function(r0_97, r1_97)
      -- line: [1206, 1206] id: 97
      return r0_97[2] < r1_97[2]
    end)
    guiGridListClear(vehicle_list)
    for r11_96, r12_96 in ipairs(r7_96) do
      guiGridListSetItemText(vehicle_list, guiGridListAddRow(vehicle_list), 1, r12_96[2], false, false)
    end
  end
  function toggleWeaponManager(r0_98)
    -- line: [1213, 1251] id: 98
    if (not isElement(weapon_window) or not guiGetVisible(weapon_window)) and r0_98 ~= false or r0_98 == true then
      if isElement(weapon_window) and r0_98 == true and guiCheckBoxGetSelected(weapon_memory) and not guiGetVisible(weapon_window) then
        triggerEvent("onClientGUIClick", weapon_accept, "left", "up", 0, 0)
        return 
      end
      if not isElement(weapon_window) and r0_98 == true and weaponMemory then
        if not getElementData(localPlayer, "Weapons") then
          return outputChatBox(getLanguageString("weapon_choice_disabled"), 255, 100, 100)
        end
        local r1_98 = {}
        local r2_98 = getTacticsData("weaponspack") or {}
        for r6_98 in pairs(weaponSave) do
          table.insert(r1_98, {
            id = convertWeaponNamesToID[r6_98],
            ammo = math.max(tonumber(r2_98[r6_98]) or 0, 1),
            name = r6_98,
          })
        end
        callServerFunction("onPlayerWeaponpackChose", localPlayer, r1_98)
        return 
      end
      if isElement(weapon_window) then
        for r4_98, r5_98 in ipairs(weapon_items) do
          if guiGetProperty(r5_98.gui, "ImageColours") == "tl:20FFFFFF tr:20FFFFFF bl:20FFFFFF br:20FFFFFF" then
            guiSetProperty(r5_98.gui, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
          end
        end
        guiSetText(weapon_properties, "")
      else
        createWeaponManager()
      end
      guiBringToFront(weapon_window)
      guiSetVisible(weapon_window, true)
      showCursor(true)
    else
      guiSetVisible(weapon_window, false)
      if isAllGuiHidden() then
        showCursor(false)
      end
      if guiCheckBoxGetSelected(config_performance_weapmanager) then
        destroyElement(weapon_window)
      end
    end
  end
  function onClientPauseToggle(r0_99)
    -- line: [1252, 1293] id: 99
    for r4_99, r5_99 in ipairs(getElementsByType("sound")) do
      setSoundPaused(r5_99, r0_99)
    end
    if r0_99 then
      r3_53 = {}
      for r4_99, r5_99 in ipairs(getElementsByType("projectile")) do
        local r6_99, r7_99, r8_99 = getElementPosition(r5_99)
        local r9_99, r10_99, r11_99 = getElementVelocity(r5_99)
        r3_53[r5_99] = {
          r6_99,
          r7_99,
          r8_99,
          r9_99,
          r10_99,
          r11_99
        }
      end
    end
    if getElementData(localPlayer, "Status") == "Play" then
      local r1_99 = {
        "fire",
        "next_weapon",
        "previous_weapon",
        "forwards",
        "backwards",
        "left",
        "right",
        "zoom_in",
        "zoom_out",
        "change_camera",
        "jump",
        "sprint",
        "look_behind",
        "crouch",
        "action",
        "walk",
        "aim_weapon",
        "enter_exit",
        "vehicle_fire",
        "vehicle_secondary_fire",
        "vehicle_left",
        "vehicle_right",
        "steer_forward",
        "steer_back",
        "accelerate",
        "brake_reverse",
        "radio_next",
        "radio_previous",
        "radio_user_track_skip",
        "horn",
        "sub_mission",
        "handbrake",
        "vehicle_look_left",
        "vehicle_look_right",
        "vehicle_look_behind",
        "vehicle_mouse_look",
        "special_control_left",
        "special_control_right",
        "special_control_down",
        "special_control_up",
        "enter_passenger"
      }
      if r0_99 then
        local r2_99 = {}
        for r6_99, r7_99 in ipairs(r1_99) do
          local r8_99 = getControlState(r7_99)
          if r8_99 and r7_99 ~= "fire" and r7_99 ~= "vehicle_fire" and r7_99 ~= "vehicle_secondary_fire" and r7_99 ~= "enter_exit" then
            table.insert(r2_99, r7_99)
          end
        end
        toggleAllControls(false, true, false)
        toggleControl("enter_passenger", false)
        for r6_99, r7_99 in ipairs(r2_99) do
          setControlState(r7_99, true)
        end
      else
        toggleAllControls(true)
        for r5_99, r6_99 in ipairs(r1_99) do
          local r7_99 = getBoundKeys(r6_99) or {}
          local r8_99 = false
          local r9_99 = pairs
          local r10_99 = r7_99
          for r12_99, r13_99 in r9_99(r10_99) do
            local r14_99 = getKeyState(r12_99)
            if r14_99 then
              r8_99 = true
              break
            end
          end
          setControlState(r6_99, r8_99)
        end
      end
    end
  end
  function remakeWeaponsPack()
    -- line: [1294, 1372] id: 100
    if not isElement(weapon_window) then
      return 
    end
    local r0_100 = getTacticsData("weaponspack") or {}
    local r1_100 = getTacticsData("weapon_balance") or {}
    if not getTacticsData("weapon_cost") then
      local r2_100 = {}
    end
    local r3_100 = {}
    for r7_100 in pairs(r0_100) do
      if r7_100 ~= nil then
        table.insert(r3_100, r7_100)
      end
    end
    local r4_100 = {
      [2] = 1,
      [3] = 2,
      [4] = 2,
      [5] = 3,
      [6] = 3,
    }
    table.sort(r3_100, function(r0_101, r1_101)
      -- line: [1302, 1310] id: 101
      local r2_101 = convertWeaponNamesToID[r0_101] or 46
      local r3_101 = convertWeaponNamesToID[r1_101] or 46
      local r4_101 = getSlotFromWeapon(r2_101)
      local r5_101 = getSlotFromWeapon(r3_101)
      local r6_101 = r4_100[r4_101] or 4
      local r7_101 = r4_100[r5_101] or 4
      local r8_101 = nil	-- notice: implicit variable refs by block#[13]
      if r6_101 ~= r7_101 or r2_101 >= r3_101 then
        r8_101 = r6_101 < r7_101
      else
        goto label_33	-- block#12 is visited secondly
      end
      return r8_101
    end)
    local r5_100 = 0
    local r6_100 = 0
    for r10_100 = 1, math.max(#weapon_items, #r3_100), 1 do
      if r10_100 <= #r3_100 then
        local r11_100 = r3_100[r10_100]
        local r12_100 = 0
        local r13_100 = convertWeaponNamesToID[r11_100] or 16
        if 16 <= r13_100 and r13_100 <= 18 or 22 <= r13_100 and r13_100 <= 39 or 41 <= r13_100 and r13_100 <= 43 then
          r12_100 = tonumber(getWeaponProperty(r13_100, "pro", "maximum_clip_ammo")) or 1
        end
        local r14_100 = math.max(0, math.floor(tonumber(r0_100[r11_100]) - r12_100))
        local r17_100 = tonumber(r0_100[r11_100])
        r14_100 = r14_100 .. "-" .. math.min(r17_100, r12_100)
        if #weapon_items < r10_100 then
          local r15_100 = guiCreateStaticImage(r5_100, r6_100, 64, 84, "images/color_pixel.png", false, weapon_scroller)
          local r16_100 = guiCreateStaticImage(2, 5, 60, 64, "images/hud/fist.png", false, r15_100)
          guiSetEnabled(r16_100, false)
          r17_100 = guiCreateLabel
          local r18_100 = 1
          local r19_100 = 60
          local r20_100 = 62
          local r21_100 = 20
          local r22_100 = nil	-- notice: implicit variable refs by block#[30]
          if r12_100 > 1 then
            r22_100 = r14_100
            if r22_100 then
              ::label_148::
              if r12_100 == 1 then
                r22_100 = r0_100[r11_100]
                if not r22_100 then
                  ::label_153::
                  r22_100 = ""
                end
              else
                goto label_153	-- block#29 is visited secondly
              end
            end
          else
            goto label_148	-- block#27 is visited secondly
          end
          r17_100 = r17_100(r18_100, r19_100, r20_100, r21_100, r22_100, false, r15_100)
          guiLabelSetHorizontalAlign(r17_100, "center", false)
          guiLabelSetVerticalAlign(r17_100, "center")
          guiSetEnabled(r17_100, false)
          r18_100 = guiCreateLabel(1, 5, 62, 20, r11_100, false, r15_100)
          guiSetFont(r18_100, "default-small")
          guiSetEnabled(r18_100, false)
          r19_100 = guiCreateLabel
          r20_100 = 1
          r21_100 = 5
          r22_100 = 62
          local r23_100 = 20
          local r24_100 = r1_100[r11_100]
          if r24_100 then
            r24_100 = "x" .. r1_100[r11_100] or ""
          else
            goto label_200	-- block#32 is visited secondly
          end
          r19_100 = r19_100(r20_100, r21_100, r22_100, r23_100, r24_100, false, r15_100)
          guiLabelSetHorizontalAlign(r19_100, "right", false)
          guiLabelSetColor(r19_100, 255, 0, 0)
          guiSetEnabled(r19_100, false)
          r22_100 = {
            gui = r15_100,
            icon = r16_100,
            name = r18_100,
            ammo = r17_100,
            limit = r19_100,
          }
          table.insert(weapon_items, r22_100)
        else
          guiSetPosition(weapon_items[r10_100].gui, r5_100, r6_100, false)
          local r15_100 = guiSetText
          local r16_100 = weapon_items[r10_100].ammo
          if r12_100 > 1 then
            r17_100 = r14_100
            if r17_100 then
              ::label_246::
              if r12_100 == 1 then
                r17_100 = r0_100[r11_100] or ""
              else
                goto label_251	-- block#38 is visited secondly
              end
            end
          else
            goto label_246	-- block#36 is visited secondly
          end
          r15_100(r16_100, r17_100)
          guiSetText(weapon_items[r10_100].name, r11_100)
          r15_100 = guiSetText
          r16_100 = weapon_items[r10_100].limit
          r17_100 = r1_100[r11_100]
          if r17_100 then
            r17_100 = "x" .. r1_100[r11_100] or ""
          else
            goto label_271	-- block#41 is visited secondly
          end
          r15_100(r16_100, r17_100)
        end
        if fileExists("images/hud/" .. r11_100 .. ".png") then
          guiStaticImageLoadImage(weapon_items[r10_100].icon, "images/hud/" .. r11_100 .. ".png")
        else
          guiStaticImageLoadImage(weapon_items[r10_100].icon, "images/hud/fist.png")
        end
        if weaponSave[r11_100] then
          guiSetProperty(weapon_items[r10_100].gui, "ImageColours", "tl:80FFFFFF tr:80FFFFFF bl:80FFFFFF br:80FFFFFF")
        else
          guiSetProperty(weapon_items[r10_100].gui, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
        end
        if r5_100 + 66 > 330 then
          r5_100 = 0
          r6_100 = r6_100 + 86
        end
      else
        weaponSave[guiGetText(weapon_items[r10_100].name)] = nil
        destroyElement(weapon_items[r10_100].gui)
        weapon_items[r10_100] = nil
      end
    end
    updateSaveWeapons()
  end
  local r18_53 = 0
  function onClientColShapeLeave(r0_102, r1_102)
    -- line: [1380, 1402] id: 102
    if getElementData(source, "Boundings") and r0_102 == localPlayer and getElementData(localPlayer, "Status") == "Play" and getPlayerTeam(localPlayer) ~= getElementsByType("team")[1] then
      local r2_102 = getPedOccupiedVehicle(localPlayer)
      if not r2_102 then
        local r3_102, r4_102, r5_102 = getElementPosition(localPlayer)
        local r6_102, r7_102, r8_102 = getElementVelocity(localPlayer)
        setElementPosition(localPlayer, r3_102, r4_102, r5_102 + 0.1)
        setElementVelocity(localPlayer, -r6_102, -r7_102, -r8_102)
      elseif getVehicleOccupant(r2_102) == localPlayer then
        local r3_102, r4_102 = getElementRotation(r2_102)
        local r5_102, r6_102, r7_102 = getElementVelocity(r2_102)
        setElementRotation(r2_102, r3_102 + 180, r4_102 + 180)
        setElementVelocity(r2_102, -r5_102, -r6_102, -r7_102)
      end
      r18_53 = getTickCount() + 15000
      addEventHandler("onClientPreRender", root, showGoBack)
    end
  end
  function showGoBack()
    -- line: [1403, 1430] id: 103
    local r0_103 = true
    for r4_103, r5_103 in ipairs(getElementsByType("colshape")) do
      if getElementData(r5_103, "Boundings") and not isElementWithinColShape(localPlayer, r5_103) then
        r0_103 = false
      end
    end
    if r0_103 then
      return removeEventHandler("onClientPreRender", root, showGoBack)
    end
    if r18_53 < getTickCount() then
      callServerFunction("killPed", localPlayer)
      callServerFunction("callClientFunction", root, "outputLangString", "killed_for_out_bounding", getPlayerName(localPlayer))
      return removeEventHandler("onClientPreRender", root, showGoBack)
    end
    dxDrawRectangle(0, 0, xscreen, yscreen, 1610612736)
    dxDrawText(getLanguageString("go_back_to_bounds"), xscreen * 0.502, yscreen * 0.352, xscreen * 0.502, yscreen * 0.352, 4278190080, getFont(2), "default-bold", "center", "bottom")
    dxDrawText(getLanguageString("go_back_to_bounds"), xscreen * 0.5, yscreen * 0.35, xscreen * 0.5, yscreen * 0.35, 4294901760, getFont(2), "default-bold", "center", "bottom")
    local r1_103 = r18_53 - getTickCount()
    dxDrawText(string.format(getLanguageString("or_you_will_be_killed"), r1_103 / 1000), xscreen * 0.502, yscreen * 0.352, xscreen * 0.502, yscreen * 0.352, tocolor(0, 0, 0), getFont(1), "default", "center", "top")
    dxDrawText(string.format(getLanguageString("or_you_will_be_killed"), r1_103 / 1000), xscreen * 0.5, yscreen * 0.35, xscreen * 0.5, yscreen * 0.35, tocolor(255, 255, 255), getFont(1), "default", "center", "top")
  end
  function callHelpme()
    -- line: [1431, 1438] id: 104
    if not getElementData(localPlayer, "Helpme") and getElementData(localPlayer, "Status") == "Play" then
      setElementData(localPlayer, "Helpme", true)
      if isTimer(helpme[localPlayer]) then
        killTimer(helpme[localPlayer])
      end
      helpme[localPlayer] = setTimer(setElementData, 7000, 1, localPlayer, "Helpme", nil)
      outputChatBox(string.format(getLanguageString("help_me"), getPlayerName(localPlayer)), 255, 100, 100, true)
    end
  end
  local r19_53 = 0
  function forceRespawnPlayer()
    -- line: [1440, 1473] id: 105
    if r19_53 + 3000 < getTickCount() and getElementData(localPlayer, "Status") == "Play" and not isRoundPaused() and not isElementInWater(localPlayer) then
      local r0_105 = getPedTask(localPlayer, "primary", 0)
      local r1_105 = getPedTask(localPlayer, "secondary", 0)
      local r2_105 = getPedTask(localPlayer, "primary", 1)
      local r3_105 = getPedTask(localPlayer, "primary", 3)
      local r4_105 = getPedTask(localPlayer, "primary", 4)
      if r0_105 ~= "TASK_COMPLEX_FALL_AND_GET_UP" and r1_105 ~= "TASK_SIMPLE_THROW" and r1_105 ~= "TASK_SIMPLE_USE_GUN" and r2_105 ~= "TASK_COMPLEX_IN_AIR_AND_LAND" and r3_105 ~= "TASK_COMPLEX_LEAVE_CAR" and r3_105 ~= "TASK_COMPLEX_ENTER_CAR_AS_DRIVER" and r3_105 ~= "TASK_COMPLEX_ENTER_CAR_AS_PASSENGER" and r3_105 ~= "TASK_COMPLEX_JUMP" and r4_105 == "TASK_SIMPLE_PLAYER_ON_FOOT" then
        r19_53 = getTickCount() + 3000
        local r5_105 = {}
        for r9_105 = 0, 12, 1 do
          local r10_105 = getPedWeapon(localPlayer, r9_105)
          local r11_105 = getPedTotalAmmo(localPlayer, r9_105)
          local r12_105 = getPedAmmoInClip(localPlayer, r9_105)
          if 0 < r10_105 and 0 < r11_105 then
            if r9_105 == getPedWeaponSlot(localPlayer) then
              table.insert(r5_105, {
                r10_105,
                r11_105,
                r12_105,
                true
              })
            else
              table.insert(r5_105, {
                r10_105,
                r11_105,
                r12_105,
                false
              })
            end
          end
        end
        callServerFunction("forceRespawnPlayer", localPlayer, r5_105)
      end
    end
  end
  function onClientPlayerBlipUpdate()
    -- line: [1474, 1514] id: 106
    if source == localPlayer then
      for r3_106, r4_106 in ipairs(getElementsByType("player")) do
        if source ~= r4_106 then
          triggerEvent("onClientPlayerBlipUpdate", r4_106)
        end
      end
    elseif getElementType(source) == "player" then
      local r1_106 = getTacticsData("modes", getTacticsData("Map"), "player_radarblip") or getTacticsData("settings", "player_radarblip")
      local r2_106 = getPlayerTeam(localPlayer)
      local r3_106 = getPlayerTeam(source)
      local r4_106 = getElementData(source, "Blip")
      if r4_106 and isElement(r4_106) then
        local r5_106, r6_106, r7_106 = getPlayerNametagColor(source)
        if r3_106 then
          r5_106, r6_106, r7_106 = getTeamColor(r3_106)
        end
        if r1_106 ~= "none" and getElementData(source, "Status") == "Play" and (r1_106 == "all" or r3_106 and r2_106 == r3_106 or r2_106 == getElementsByType("team")[1]) then
          setBlipColor(r4_106, r5_106, r6_106, r7_106, 255)
          setBlipSize(r4_106, 1)
        elseif getElementData(source, "Status") == "Die" then
          setBlipColor(r4_106, r5_106 / 2, r6_106 / 2, r7_106 / 2, 128)
          setBlipSize(r4_106, 1)
        else
          setBlipColor(r4_106, 0, 0, 0, 0)
        end
      end
      if source ~= localPlayer then
        if r2_106 == getElementsByType("team")[1] then
          setPlayerNametagShowing(source, true)
        elseif getPlayerProperty(source, "invisible") and r2_106 ~= r3_106 then
          setPlayerNametagShowing(source, false)
        elseif getTacticsData("settings", "player_nametag") == "all" then
          setPlayerNametagShowing(source, true)
        elseif getTacticsData("settings", "player_nametag") == "team" and r2_106 == r3_106 then
          setPlayerNametagShowing(source, true)
        else
          setPlayerNametagShowing(source, false)
        end
      end
    end
  end
  function showCredits()
    -- line: [1515, 1530] id: 107
    local r0_107, r1_107 = guiGetPosition(credits_ending[1], false)
    guiSetPosition(credits_ending[1], r0_107, credits_ending[2], false)
    for r5_107, r6_107 in ipairs(credits_content) do
      r0_107, r1_107 = guiGetPosition(r6_107[1], false)
      guiSetPosition(r6_107[1], r0_107, r6_107[2], false)
    end
    guiBringToFront(credits_window)
    guiSetPosition(credits_window, xscreen * 0.5 - 280, yscreen * 0.5 - 150, false)
    guiBringToFront(credits_window)
    guiSetVisible(credits_window, true)
    showCursor(true)
    if credits_scrolling then
      return 
    end
    credits_scrolling = 0
    addEventHandler("onClientPreRender", root, scrollingCredits)
  end
  function scrollingCredits(r0_108)
    -- line: [1531, 1558] id: 108
    if not guiGetVisible(credits_window) then
      removeEventHandler("onClientPreRender", root, scrollingCredits)
      credits_scrolling = nil
      return 
    end
    credits_scrolling = credits_scrolling + r0_108
    if credits_scrolling < 30 then
      return 
    end
    credits_scrolling = credits_scrolling % 30
    local r1_108, r2_108 = guiGetPosition(credits_ending[1], false)
    if r2_108 > 0 then
      guiSetPosition(credits_ending[1], r1_108, r2_108 - 1, false)
      for r6_108, r7_108 in ipairs(credits_content) do
        r1_108, r2_108 = guiGetPosition(r7_108[1], false)
        if r2_108 > 0 then
          guiSetPosition(r7_108[1], r1_108, r2_108 - 1, false)
        else
          guiSetPosition(r7_108[1], r1_108, r2_108 - 1 - 1, false)
        end
      end
    else
      guiSetPosition(credits_ending[1], r1_108, r2_108 + credits_ending[2], false)
      for r6_108, r7_108 in ipairs(credits_content) do
        r1_108, r2_108 = guiGetPosition(r7_108[1], false)
        guiSetPosition(r7_108[1], r1_108, r2_108 + credits_ending[2], false)
      end
    end
  end
  function onClientMapStopping(r0_109)
    -- line: [1559, 1572] id: 109
    if isElement(weapon_window) and guiGetVisible(weapon_window) then
      guiSetVisible(weapon_window, false)
      if isAllGuiHidden() then
        showCursor(false)
      end
      if guiCheckBoxGetSelected(config_performance_weapmanager) then
        destroyElement(weapon_window)
      end
    end
    if isElement(vehicle_window) and guiGetVisible(vehicle_window) then
      guiSetVisible(vehicle_window, false)
      if isAllGuiHidden() then
        showCursor(false)
      end
      if guiCheckBoxGetSelected(config_performance_vehmanager) then
        destroyElement(vehicle_window)
      end
    end
    stopCameraPrepair()
    if isTimer(decelerationSpeed) then
      killTimer(decelerationSpeed)
    end
  end
  function onClientRoundStart()
    -- line: [1573, 1575] id: 110
    stopCameraPrepair()
  end
  function onClientRoundFinish(r0_111, r1_111)
    -- line: [1576, 1615] id: 111
    setGameSpeed(getGameSpeed() / 2)
    if not isTimer(decelerationSpeed) then
      decelerationSpeed = setTimer(function()
        -- line: [1579, 1585] id: 112
        if getGameSpeed() > 0 then
          setGameSpeed(math.max(0, getGameSpeed() - 0.02))
        else
          killTimer(decelerationSpeed)
        end
      end, 50, 0)
    end
    local r2_111 = getRoundMapInfo().name
    if r0_111 then
      local r3_111 = ""
      if type(r0_111) == "table" then
        if type(r0_111[1]) == "string" then
          local r4_111 = r0_111[1]
          local r5_111 = r0_111
          table.remove(r5_111, 1)
          r3_111 = string.format(getLanguageString(tostring(r4_111)), unpack(r5_111))
        else
          local r4_111 = r0_111[4]
          local r5_111 = r0_111
          table.remove(r5_111, 1)
          table.remove(r5_111, 1)
          table.remove(r5_111, 1)
          table.remove(r5_111, 1)
          r3_111 = string.format(getLanguageString(tostring(r4_111)), unpack(r5_111))
        end
      elseif type(r0_111) == "string" then
        r3_111 = getLanguageString(r0_111)
        if #r3_111 == 0 then
          r3_111 = tostring(r0_111)
        end
      else
        r3_111 = tostring(r0_111)
      end
      outputLangString("round_finish_result", r2_111, r3_111)
    else
      outputLangString("round_finish", r2_111)
    end
    playMusic("audio/music_gta3.mp3")
    if respawn_countdown then
      removeEventHandler("onClientPreRender", root, onClientRespawnRender)
    end
    respawn_countdown = nil
  end
  function onClientRoundTimesup()
    -- line: [1616, 1618] id: 113
    playVoice("audio/times_up.mp3")
  end
  function doReloadWeapon()
    -- line: [1619, 1623] id: 114
    if not getControlState("jump") and getPedTask(localPlayer, "primary", 4) == "TASK_SIMPLE_PLAYER_ON_FOOT" and getPedTask(localPlayer, "primary", 1) ~= "TASK_COMPLEX_IN_AIR_AND_LAND" and getPedTask(localPlayer, "primary", 3) ~= "TASK_COMPLEX_JUMP" then
      callServerFunction("reloadPedWeapon", localPlayer)
    end
  end
  function onClientVehicleEnter(r0_115, r1_115)
    -- line: [1624, 1643] id: 115
    local r2_115 = getElementData(source, "Blip")
    if r2_115 and getTacticsData("settings", "vehicle_radarblip") == "unoccupied" then
      setBlipColor(r2_115, 0, 0, 0, 0)
    end
    if r1_115 == 0 then
      local r3_115 = getTacticsData("settings", "ghostmode")
      for r7_115, r8_115 in ipairs(getElementsByType("vehicle", root, true)) do
        if r3_115 == "team" and getVehicleController(r8_115) and getPlayerTeam(getVehicleController(r8_115)) == getPlayerTeam(r0_115) then
          setElementCollidableWith(r8_115, source, false)
        elseif r3_115 == "all" then
          setElementCollidableWith(r8_115, source, false)
        else
          setElementCollidableWith(r8_115, source, true)
        end
      end
    end
  end
  function onClientVehicleStartExit(r0_116, r1_116, r2_116)
    -- line: [1644, 1663] id: 116
    local r3_116 = getElementData(source, "Blip")
    if r3_116 and getTacticsData("settings", "vehicle_radarblip") == "unoccupied" then
      local r4_116 = false
      local r5_116 = getVehicleOccupants(source)
      for r10_116 = 0, getVehicleMaxPassengers(source), 1 do
        if r5_116[r10_116] and r10_116 ~= r1_116 then
          r4_116 = true
          break
        end
      end
      local r7_116 = getVehicleController(source)
      if not r4_116 and (not r7_116 or r7_116 == r0_116) then
        setBlipColor(r3_116, 128, 128, 128, 128)
      end
    end
  end
  function onClientVehicleExit(r0_117, r1_117)
    -- line: [1664, 1689] id: 117
    local r2_117 = getElementData(source, "Blip")
    if r2_117 and getTacticsData("settings", "vehicle_radarblip") == "unoccupied" then
      local r3_117 = false
      local r4_117 = getVehicleOccupants(source)
      for r9_117 = 0, getVehicleMaxPassengers(source), 1 do
        if r4_117[r9_117] and r9_117 ~= r1_117 then
          r3_117 = true
          break
        end
      end
      local r6_117 = getVehicleController(source)
      if not r3_117 and (not r6_117 or r6_117 == r0_117) then
        setBlipColor(r2_117, 128, 128, 128, 128)
      end
    end
    if r1_117 == 0 and getTacticsData("settings", "ghostmode") == "team" then
      for r6_117, r7_117 in ipairs(getElementsByType("vehicle", root, true)) do
        setElementCollidableWith(r7_117, source, true)
        setElementCollidableWith(source, r7_117, true)
      end
    end
  end
  function onClientPlayerRoundSpawn()
    -- line: [1690, 1707] id: 118
    if not getElementData(localPlayer, "Loading") then
      fadeCamera(true, 2)
    end
    setTimer(function()
      -- line: [1692, 1706] id: 119
      if getElementData(localPlayer, "Status") ~= "Spectate" then
        return 
      end
      for r4_119, r5_119 in ipairs(getTacticsData("Restores") or {}) do
        if r5_119[1] == getPlayerName(localPlayer) then
          outputInfo(string.format(getLanguageString("help_restore"), "R"))
          return 
        end
      end
      if (getTacticsData("modes", getTacticsData("Map"), "respawn") or getTacticsData("settings", "respawn") or "false") == "true" then
        outputInfo(string.format(getLanguageString("help_restore"), "R"))
      end
    end, 1000, 1)
  end
  function onClientPlayerRoundRespawn()
    -- line: [1708, 1714] id: 120
    if not getElementData(localPlayer, "Loading") then
      fadeCamera(true, 2)
    end
    if respawn_countdown then
      removeEventHandler("onClientPreRender", root, onClientRespawnRender)
      respawn_countdown = nil
    end
  end
  local r20_53 = {}
  function updateWeatherBlend()
    -- line: [1716, 1762] id: 121
    r20_53 = {}
    local r0_121 = getTacticsData("Weather")
    local r1_121 = (getTime() + 1) % 24
    for r5_121 = r1_121, r1_121 + 22, 1 do
      local r6_121 = r5_121 % 24
      if r0_121[r6_121] then
        r20_53[2] = {
          hour = r6_121,
          wind = {
            x = r0_121[r6_121].wind[1],
            y = r0_121[r6_121].wind[2],
            z = r0_121[r6_121].wind[3],
          },
          rain = r0_121[r6_121].rain,
          far = r0_121[r6_121].far,
          fog = r0_121[r6_121].fog,
          sky = {
            rt = r0_121[r6_121].sky[1],
            gt = r0_121[r6_121].sky[2],
            bt = r0_121[r6_121].sky[3],
            rb = r0_121[r6_121].sky[4],
            gb = r0_121[r6_121].sky[5],
            bb = r0_121[r6_121].sky[6],
          },
          clouds = r0_121[r6_121].clouds,
          birds = r0_121[r6_121].birds,
          sun = {
            rc = r0_121[r6_121].sun[1],
            gc = r0_121[r6_121].sun[2],
            bc = r0_121[r6_121].sun[3],
            rs = r0_121[r6_121].sun[4],
            gs = r0_121[r6_121].sun[5],
            bs = r0_121[r6_121].sun[6],
            size = r0_121[r6_121].sunsize,
          },
          water = {
            r = r0_121[r6_121].water[1],
            g = r0_121[r6_121].water[2],
            b = r0_121[r6_121].water[3],
            a = r0_121[r6_121].water[4],
            lvl = r0_121[r6_121].level,
            wave = r0_121[r6_121].wave,
          },
          heat = r0_121[r6_121].heat,
          effect = r0_121[r6_121].effect,
        }
        break
      end
    end
    r1_121 = (r1_121 - 1) % 24
    for r5_121 = r1_121, r1_121 - 23, -1 do
      local r6_121 = r5_121 % 24
      if r0_121[r6_121] then
        r20_53[1] = {
          hour = r6_121,
          wind = {
            x = r0_121[r6_121].wind[1],
            y = r0_121[r6_121].wind[2],
            z = r0_121[r6_121].wind[3],
          },
          rain = r0_121[r6_121].rain,
          far = r0_121[r6_121].far,
          fog = r0_121[r6_121].fog,
          sky = {
            rt = r0_121[r6_121].sky[1],
            gt = r0_121[r6_121].sky[2],
            bt = r0_121[r6_121].sky[3],
            rb = r0_121[r6_121].sky[4],
            gb = r0_121[r6_121].sky[5],
            bb = r0_121[r6_121].sky[6],
          },
          clouds = r0_121[r6_121].clouds,
          birds = r0_121[r6_121].birds,
          sun = {
            rc = r0_121[r6_121].sun[1],
            gc = r0_121[r6_121].sun[2],
            bc = r0_121[r6_121].sun[3],
            rs = r0_121[r6_121].sun[4],
            gs = r0_121[r6_121].sun[5],
            bs = r0_121[r6_121].sun[6],
            size = r0_121[r6_121].sunsize,
          },
          water = {
            r = r0_121[r6_121].water[1],
            g = r0_121[r6_121].water[2],
            b = r0_121[r6_121].water[3],
            a = r0_121[r6_121].water[4],
            lvl = r0_121[r6_121].level,
            wave = r0_121[r6_121].wave,
          },
          heat = r0_121[r6_121].heat,
          effect = r0_121[r6_121].effect,
        }
        break
      end
    end
  end
  local r21_53 = 0
  local r22_53 = 0
  function updateWeather(r0_122)
    -- line: [1764, 1789] id: 122
    local r1_122, r2_122 = getTime()
    if r21_53 == r1_122 and r22_53 == r2_122 and not r0_122 then
      return 
    end
    r22_53 = r2_122
    r21_53 = r1_122
    if #r20_53 ~= 2 then
      updateWeatherBlend()
    end
    local r3_122 = r1_122 + r2_122 / 60 - r20_53[1].hour
    local r4_122 = r20_53[2].hour
    if r20_53[1].hour <= r4_122 then
      r4_122 = r20_53[2].hour or r20_53[2].hour + 24
    else
      goto label_39	-- block#8 is visited secondly
    end
    r3_122 = r3_122 / (r4_122 - r20_53[1].hour)
    if r3_122 < 0 or 1 <= r3_122 then
      updateWeatherBlend()
      r3_122 = (r1_122 + r2_122 / 60 - r20_53[1].hour) / (r20_53[2].hour - r20_53[1].hour)
    end
    function r4_122(r0_123, r1_123)
      -- line: [1774, 1774] id: 123
      return r0_123 + r3_122 * (r1_123 - r0_123)
    end
    setWeather(r20_53[1].effect or 0)
    setWindVelocity(r4_122(r20_53[1].wind.x, r20_53[2].wind.x), r4_122(r20_53[1].wind.y, r20_53[2].wind.y), 0)
    setRainLevel(r4_122(r20_53[1].rain, r20_53[2].rain))
    setFarClipDistance(r4_122(r20_53[1].far, r20_53[2].far))
    setFogDistance(r4_122(r20_53[1].fog, r20_53[2].fog))
    setSkyGradient(r4_122(r20_53[1].sky.rt, r20_53[2].sky.rt), r4_122(r20_53[1].sky.gt, r20_53[2].sky.gt), r4_122(r20_53[1].sky.bt, r20_53[2].sky.bt), r4_122(r20_53[1].sky.rb, r20_53[2].sky.rb), r4_122(r20_53[1].sky.gb, r20_53[2].sky.gb), r4_122(r20_53[1].sky.bb, r20_53[2].sky.bb))
    setCloudsEnabled(r20_53[1].clouds)
    setBirdsEnabled(r20_53[1].birds)
    setSunColor(r4_122(r20_53[1].sun.rc, r20_53[2].sun.rc), r4_122(r20_53[1].sun.gc, r20_53[2].sun.gc), r4_122(r20_53[1].sun.bc, r20_53[2].sun.bc), r4_122(r20_53[1].sun.rs, r20_53[2].sun.rs), r4_122(r20_53[1].sun.gs, r20_53[2].sun.gs), r4_122(r20_53[1].sun.bs, r20_53[2].sun.bs))
    setSunSize(r4_122(r20_53[1].sun.size, r20_53[2].sun.size))
    setWaterColor(r4_122(r20_53[1].water.r, r20_53[2].water.r), r4_122(r20_53[1].water.g, r20_53[2].water.g), r4_122(r20_53[1].water.b, r20_53[2].water.b), r4_122(r20_53[1].water.a, r20_53[2].water.a))
    setWaterLevel(r4_122(r20_53[1].water.lvl, r20_53[2].water.lvl), false, false)
    setWaveHeight(r4_122(r20_53[1].water.wave, r20_53[2].water.wave))
    setHeatHaze(r4_122(r20_53[1].heat, r20_53[2].heat), 0, 12, 18, 75, 80, 80, 85, true)
  end
  function onClientPlayerVehiclepackGot(r0_124, r1_124, r2_124)
    -- line: [1790, 1799] id: 124
    if getVehicleType(r0_124) == "Helicopter" then
      setHelicopterRotorSpeed(r0_124, 0.2)
    end
    if r2_124 then
      local r3_124 = getElementDistanceFromCentreOfMassToBaseOfModel(r0_124)
      local r4_124, r5_124, r6_124 = getElementPosition(r0_124)
      setElementPosition(r0_124, r4_124, r5_124, r6_124 + r3_124 - r2_124)
    end
  end
  function getRestoreCount()
    -- line: [1800, 1802] id: 125
    return #(getTacticsData("Restores") or {})
  end
  function getRestoreData(r0_126)
    -- line: [1803, 1825] id: 126
    local r1_126 = getTacticsData("Restores") or {}
    if not r1_126[r0_126] then
      return false
    end
    local r2_126, r3_126, r4_126, r5_126, r6_126, r7_126, r8_126, r9_126, r10_126, r11_126, r12_126, r13_126, r14_126, r15_126, r16_126, r17_126, r18_126, r19_126, r20_126 = unpack(r1_126[r0_126])
    return {
      name = r2_126,
      posX = r11_126,
      posY = r12_126,
      posZ = r13_126,
      rotation = r14_126,
      interior = r7_126,
      team = r3_126,
      skin = r4_126,
      health = r5_126,
      armour = r6_126,
      velocityX = r15_126,
      velocityY = r16_126,
      velocityZ = r17_126,
      onfire = r18_126,
      weapons = r8_126,
      weaponslot = r9_126,
      vehicle = r10_126,
      vehicleseat = r19_126,
    }
  end
  function onClientPlayerRPS()
    -- line: [1826, 1828] id: 127
    outputChatBox(string.format(getLanguageString("rsp_using"), getPlayerName(source)), 255, 100, 100, true)
  end
  addEvent("onClientMapStarting")
  addEvent("onClientMapStopping", true)
  addEvent("onClientRoundStart", true)
  addEvent("onClientRoundFinish", true)
  addEvent("onClientRoundTimesup", true)
  addEvent("onClientRoundCountdownStarted", true)
  addEvent("onClientPauseToggle", true)
  addEvent("onClientPlayerRoundSpawn", true)
  addEvent("onClientPlayerRoundRespawn", true)
  addEvent("onClientPlayerBlipUpdate", true)
  addEvent("onClientPlayerRPS", true)
  addEvent("onClientPlayerVehiclepackGot", true)
  addEvent("onClientPlayerWeaponpackGot", true)
  addEvent("onClientPlayerGameStatusChange")
  addEvent("onClientRespawnCountdown", true)
  addEventHandler("onClientResourceStart", resourceRoot, onClientResourceStart)
  addEventHandler("onClientResourceStop", resourceRoot, onClientResourceStop)
  addEventHandler("onClientResourceStart", root, onClientOtherResourceStart)
  addEventHandler("onClientPlayerJoin", root, onClientPlayerJoin)
  addEventHandler("onClientPlayerQuit", root, onClientPlayerQuit)
  addEventHandler("onClientPlayerDamage", localPlayer, onClientPlayerDamage)
  addEventHandler("onClientPlayerSpawn", root, onClientPlayerSpawn)
  addEventHandler("onClientPlayerWasted", root, onClientPlayerWasted)
  addEventHandler("onClientRespawnCountdown", root, onClientRespawnCountdown)
  addEventHandler("onClientElementDataChange", root, onClientElementDataChange)
  addEventHandler("onClientTacticsChange", root, onClientTacticsChange)
  addEventHandler("onClientElementStreamIn", root, onClientElementStreamIn)
  addEventHandler("onClientMapStarting", root, onClientMapStarting)
  addEventHandler("onClientGUIClick", root, onClientGUIClick)
  addEventHandler("onClientGUIDoubleClick", root, onClientGUIDoubleClick)
  addEventHandler("onClientGUIChanged", root, onClientGUIChanged)
  addEventHandler("onClientMouseEnter", root, onClientMouseEnter)
  addEventHandler("onClientMouseLeave", root, onClientMouseLeave)
  addEventHandler("onClientPauseToggle", root, onClientPauseToggle)
  addEventHandler("onClientColShapeLeave", root, onClientColShapeLeave)
  addEventHandler("onClientPlayerBlipUpdate", root, onClientPlayerBlipUpdate)
  addEventHandler("onClientMapStopping", root, onClientMapStopping)
  addEventHandler("onClientRoundStart", root, onClientRoundStart)
  addEventHandler("onClientRoundFinish", root, onClientRoundFinish)
  addEventHandler("onClientRoundTimesup", root, onClientRoundTimesup)
  addEventHandler("onClientVehicleEnter", root, onClientVehicleEnter)
  addEventHandler("onClientVehicleStartExit", root, onClientVehicleStartExit)
  addEventHandler("onClientVehicleExit", root, onClientVehicleExit)
  addEventHandler("onClientPlayerRoundSpawn", localPlayer, onClientPlayerRoundSpawn)
  addEventHandler("onClientPlayerRoundRespawn", localPlayer, onClientPlayerRoundRespawn)
  addEventHandler("onClientRoundCountdownStarted", root, onClientRoundCountdownStarted)
  addEventHandler("onClientPlayerVehiclepackGot", root, onClientPlayerVehiclepackGot)
  addEventHandler("onDownloadComplete", root, onDownloadComplete)
  addEventHandler("onClientRender", root, updateWeather)
  addEventHandler("onClientPlayerRPS", root, onClientPlayerRPS)
  addEventHandler("onClientRender", root, function()
    -- line: [1880, 1880] id: 128
    if isElementFrozen(localPlayer) then
      setElementVelocity(localPlayer, 0, 0, 0)
    end
  end)
  addCommandHandler("team_change", forcedChangeTeam, false)
  addCommandHandler("help_me", callHelpme, false)
  addCommandHandler("rsp", forceRespawnPlayer, false)
  addCommandHandler("credits", showCredits, false)
  addCommandHandler("reload", doReloadWeapon, false)
  bindKey("action", "down", function()
    -- line: [1886, 1886] id: 129
    setControlState("action", false)
  end)
end)()
(function(...)
  -- line: [0, 0] id: 130
  local r0_130 = 480
  local r1_130 = 480
  local r2_130 = false
  local r3_130 = {}
  sortWeaponNames = {}
  convertWeaponNamesToID = {
    golfclub = 2,
    nightstick = 3,
    knife = 4,
    bat = 5,
    shovel = 6,
    poolstick = 7,
    katana = 8,
    saw = 9,
    colt45 = 22,
    silenced = 23,
    deagle = 24,
    shotgun = 25,
    sawnoff = 26,
    spas12 = 27,
    uzi = 28,
    mp5 = 29,
    ak47 = 30,
    m4 = 31,
    tec9 = 32,
    rifle = 33,
    sniper = 34,
    rpg = 35,
    heatseek = 36,
    flame = 37,
    minigun = 38,
    grenade = 16,
    teargas = 17,
    molotov = 18,
    satchel = 39,
    spraycan = 41,
    fireextinguisher = 42,
    camera = 43,
    nightvision = 44,
    infrared = 45,
    parachute = 46,
  }
  convertWeaponIDToNames = {
    [2] = "golfclub",
    [3] = "nightstick",
    [4] = "knife",
    [5] = "bat",
    [6] = "shovel",
    [7] = "poolstick",
    [8] = "katana",
    [9] = "saw",
    [22] = "colt45",
    [23] = "silenced",
    [24] = "deagle",
    [25] = "shotgun",
    [26] = "sawnoff",
    [27] = "spas12",
    [28] = "uzi",
    [29] = "mp5",
    [30] = "ak47",
    [31] = "m4",
    [32] = "tec9",
    [33] = "rifle",
    [34] = "sniper",
    [35] = "rpg",
    [36] = "heatseek",
    [37] = "flame",
    [38] = "minigun",
    [16] = "grenade",
    [17] = "teargas",
    [18] = "molotov",
    [39] = "satchel",
    [41] = "spraycan",
    [42] = "fireextinguisher",
    [43] = "camera",
    [44] = "nightvision",
    [45] = "infrared",
    [46] = "parachute",
  }
  convertVehicleVariant = {
    [416] = {
      [0] = "37",
      [1] = "71",
    },
    [435] = {
      [0] = "Cok-o-Pops",
      [1] = "Munky Juice",
      [2] = "Hinterland",
      [3] = "Zip",
      [4] = "RS Haul",
      [5] = "Ranch",
    },
    [450] = {
      [0] = "Filled with gravel/coal/stone",
    },
    [485] = {
      [0] = "Earmuffs",
      [1] = "Small Case",
      [2] = "Large Case",
    },
    [433] = {
      [0] = "Opaque Fabric",
      [1] = "Camo Netting",
    },
    [499] = {
      [0] = "Shady Industries",
      [1] = "LSD",
      [2] = "The Uphill Gardener",
      [3] = "Discount Furniture",
    },
    [581] = {
      [0] = "Single Type1",
      [1] = "Single Type2",
      [2] = "Dual Type3",
      [3] = "Half-size",
      [4] = "Full-size",
    },
    [424] = {
      [0] = "Side Panels",
    },
    [504] = {
      [0] = "328/White",
      [1] = "464/Check",
      [2] = "172/Check",
      [3] = "100/White",
      [4] = "284/White",
      [5] = "505/Check",
    },
    [422] = {
      [0] = "Spare Tire",
      [1] = "Sprunk Cans",
    },
    [482] = {
      [0] = "Roof Lights + Spoiler",
    },
    [457] = {
      [0] = "Golfbag1",
      [1] = "Satchel1",
      [2] = "Golfbag2 Rear Cargo (Pass Side)",
      [3] = "Satchel2",
      [4] = "Golfbag3",
      [5] = "Golfbag4",
    },
    [483] = {
      [0] = "Open Curtains & Second Bench Seat",
      [1] = "Open Roof Vent, Closed Curtains, Bed in Back, Peace Sign",
    },
    [415] = {
      [0] = "Single, Placed High",
      [1] = "Dual, Placed Normally",
    },
    [437] = {
      [0] = "Big O Tours",
      [1] = "Bikini Line",
    },
    [472] = {
      [0] = "Items all Over",
      [1] = "Items Grouped in Back",
      [2] = "Items all Over + 2 Oars in Front",
    },
    [521] = {
      [0] = "Single Type1",
      [1] = "Dual Type1",
      [2] = "Dual Type2",
      [3] = "Half-size",
      [4] = "Full-size",
    },
    [407] = {
      [0] = "64",
      [1] = "16",
      [2] = "47",
    },
    [455] = {
      [0] = "64",
      [1] = "16",
      [2] = "47",
    },
    [434] = {
      [0] = "Partial Engine Cover",
    },
    [502] = {
      [0] = "96",
      [1] = "67",
      [2] = "73",
      [3] = "52",
      [4] = "45",
      [5] = "14",
    },
    [503] = {
      [0] = "82",
      [1] = "26",
      [2] = "65",
      [3] = "07",
      [4] = "36",
      [5] = "60",
    },
    [571] = {
      [0] = "Both Sides",
      [1] = "Steering Column",
    },
    [595] = {
      [0] = "Over passenger section",
      [1] = "Over driver section",
    },
    [484] = {
      [0] = "Windshield over Cabin Entrance",
    },
    [500] = {
      [0] = "Roof Over Back",
      [1] = "Roll Bar in Back",
    },
    [556] = {
      [0] = "Roof Spoiler",
      [1] = "Roof Lights",
      [2] = "Roll Bar with Lights",
    },
    [557] = {
      [0] = "Couldn\'t Determine 1 = Roof Lights",
    },
    [423] = {
      [0] = "Cherry Popping Good",
      [1] = "Slow Children Ahead",
    },
    [414] = {
      [0] = "Toy Corner",
      [1] = "Binco",
      [2] = "Semi",
      [3] = "Shafted Appliances",
    },
    [522] = {
      [0] = "Single Pair1",
      [1] = "Single Pair2",
      [2] = "Dual Pair2",
      [3] = "Smooth",
      [4] = "With Side Cutouts",
    },
    [470] = {
      [0] = "Low Cover",
      [1] = "Roof/High Cover",
      [2] = "Roll Bar",
    },
    [404] = {
      [0] = "Low Cover",
      [1] = "Roof/High Cover",
      [2] = "Roll Bar",
    },
    [600] = {
      [0] = "Planks",
      [1] = "Sprunk Cans",
    },
    [413] = {
      [0] = "Sound System in Back",
    },
    [453] = {
      [0] = "Boxes of Fish",
      [1] = "Bench",
    },
    [442] = {
      [0] = "Brown Style1",
      [1] = "Black Style2",
      [2] = "Brown Style3",
    },
    [440] = {
      [0] = "Cok-o-Pops",
      [1] = "Harry Plums",
      [2] = "Dick Goblin\'s",
      [3] = "Final Build",
      [4] = "Transfender",
      [5] = "Wheel Arch Angels",
    },
    [543] = {
      [0] = "Two Propane Tanks & Crate",
      [1] = "Two Barrels",
      [2] = "Sprunk Cans",
      [3] = "Open Crates",
    },
    [605] = {
      [0] = "Two Propane Tanks & Crate",
      [1] = "Two Barrels",
      [2] = "Sprunk Cans",
      [3] = "Open Crates",
    },
    [428] = {
      [0] = "Chuff",
      [1] = "Lock&Load",
    },
    [535] = {
      [0] = "Normal",
      [1] = "Chain (Default has none!)",
    },
    [439] = {
      [0] = "Hardtop",
      [1] = "Softtop (up)",
      [2] = "Softtop (folded)",
    },
    [506] = {
      [0] = "Full Roof",
    },
    [601] = {
      [0] = "1",
      [1] = "9",
      [2] = "6",
      [3] = "7",
    },
    [459] = {
      [0] = "Boxes of Toys in Back",
    },
    [408] = {
      [0] = "Some bits of trash sticking out of the back",
    },
    [583] = {
      [0] = "Red Case",
      [1] = "Green Case",
    },
    [552] = {
      [0] = "Cones, Barrel in back + Cone lying on passenger side rail",
      [1] = "Cones, Barrel in back + Cone lying on driver side rail",
    },
    [478] = {
      [0] = "Two Propane Tanks",
      [1] = "Open Crates",
      [2] = "Propane Tank and Barrel",
    },
    [555] = {
      [0] = "Roof",
    },
    [456] = {
      [0] = "Big Gas",
      [1] = "RS Haul",
      [2] = "Star Balls",
      [3] = "Flower Power",
    },
    [477] = {
      [0] = "Rear Spoiler",
    },
  }
  local r4_130 = {
    {
      name = "Extra Sunny LA",
      [r6_130] = {
        [r8_130] = {
          [r10_130] = {
            22,
            22,
            22
          },
          [r10_130] = {
            220,
            212,
            130
          },
          [r10_130] = {
            255,
            255,
            255
          },
          [r10_130] = {
            0,
            23,
            24,
            0,
            31,
            32
          },
          [r10_130] = {
            255,
            128,
            0,
            5,
            0,
            0,
            1
          },
          [r10_130] = {
            0.3,
            1
          },
          [r10_130] = {
            200,
            100,
            0
          },
          far = 400,
          fog = 100,
          ground = 1,
          [r10_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r10_130] = {
            85,
            85,
            65,
            240
          },
          [r10_130] = {
            87,
            87,
            87,
            127
          },
          [r10_130] = {
            60,
            121,
            122,
            127
          },
          [r10_130] = {
            0,
            90,
            0,
            1
          },
        },
        [r8_130] = {
          [r10_130] = {
            22,
            22,
            22
          },
          [r10_130] = {
            194,
            194,
            142
          },
          [r10_130] = {
            255,
            255,
            255
          },
          [r10_130] = {
            0,
            20,
            20,
            0,
            31,
            32
          },
          [r10_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            0
          },
          [r10_130] = {
            0.2,
            1
          },
          [r10_130] = {
            150,
            100,
            0
          },
          far = 400,
          fog = 100,
          ground = 1,
          [r10_130] = {
            35,
            9,
            10,
            27,
            30,
            36
          },
          [r10_130] = {
            53,
            104,
            104,
            240
          },
          [r10_130] = {
            80,
            80,
            80,
            127
          },
          [r10_130] = {
            60,
            190,
            190,
            127
          },
          [r10_130] = {
            0,
            90,
            0,
            1
          },
        },
        [r8_130] = {
          [r10_130] = {
            22,
            22,
            22
          },
          [r10_130] = {
            210,
            194,
            182
          },
          [r10_130] = {
            255,
            255,
            255
          },
          [r10_130] = {
            90,
            205,
            255,
            200,
            144,
            85
          },
          [r10_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            8.4
          },
          [r10_130] = {
            0.3,
            1
          },
          [r10_130] = {
            140,
            93,
            0
          },
          far = 800,
          fog = 100,
          ground = 0.8,
          [r10_130] = {
            100,
            34,
            25,
            120,
            92,
            88
          },
          [r10_130] = {
            90,
            170,
            170,
            240
          },
          [r10_130] = {
            86,
            86,
            86,
            127
          },
          [r10_130] = {
            149,
            94,
            0,
            127
          },
          [r10_130] = {
            25,
            120,
            0,
            1
          },
        },
        [r8_130] = {
          [r10_130] = {
            5,
            0,
            0
          },
          [r10_130] = {
            210,
            194,
            182
          },
          [r10_130] = {
            255,
            255,
            255
          },
          [r10_130] = {
            90,
            205,
            255,
            90,
            200,
            255
          },
          [r10_130] = {
            255,
            255,
            255,
            255,
            255,
            255,
            2.2
          },
          [r10_130] = {
            0.3,
            1
          },
          [r10_130] = {
            100,
            50,
            75
          },
          far = 800,
          fog = 100,
          ground = 0.5,
          [r10_130] = {
            120,
            40,
            40,
            159,
            142,
            106
          },
          [r10_130] = {
            145,
            170,
            170,
            240
          },
          [r10_130] = {
            133,
            106,
            70,
            111
          },
          [r10_130] = {
            96,
            61,
            15,
            127
          },
          [r10_130] = {
            25,
            180,
            0,
            1
          },
        },
        [r8_130] = {
          [r10_130] = {
            11,
            0,
            0
          },
          [r10_130] = {
            210,
            194,
            182
          },
          [r10_130] = {
            255,
            255,
            255
          },
          [r10_130] = {
            68,
            117,
            210,
            36,
            117,
            199
          },
          [r10_130] = {
            255,
            255,
            255,
            255,
            255,
            255,
            1.1
          },
          [r10_130] = {
            0,
            1
          },
          [r10_130] = {
            236,
            0,
            190
          },
          far = 800,
          fog = 10,
          ground = 0,
          [r10_130] = {
            44,
            34,
            23,
            145,
            164,
            183
          },
          [r10_130] = {
            90,
            170,
            170,
            240
          },
          [r10_130] = {
            66,
            66,
            48,
            127
          },
          [r10_130] = {
            166,
            129,
            60,
            127
          },
          [r10_130] = {
            25,
            180,
            0,
            1
          },
        },
        [r8_130] = {
          [r10_130] = {
            8,
            5,
            5
          },
          [r10_130] = {
            255,
            255,
            182
          },
          [r10_130] = {
            255,
            255,
            255
          },
          [r10_130] = {
            68,
            117,
            210,
            36,
            117,
            194
          },
          [r10_130] = {
            222,
            88,
            0,
            122,
            55,
            0,
            3.9
          },
          [r10_130] = {
            0,
            1
          },
          [r10_130] = {
            110,
            40,
            75
          },
          far = 800,
          fog = 10,
          ground = 0.8,
          [r10_130] = {
            120,
            40,
            40,
            200,
            123,
            96
          },
          [r10_130] = {
            50,
            97,
            97,
            240
          },
          [r10_130] = {
            124,
            124,
            107,
            106
          },
          [r10_130] = {
            86,
            50,
            10,
            127
          },
          [r10_130] = {
            25,
            180,
            0,
            1
          },
        },
        [r8_130] = {
          [r10_130] = {
            25,
            14,
            14
          },
          [r10_130] = {
            210,
            194,
            182
          },
          [r10_130] = {
            255,
            255,
            255
          },
          [r10_130] = {
            181,
            150,
            84,
            167,
            108,
            65
          },
          [r10_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            2
          },
          [r10_130] = {
            0.4,
            1
          },
          [r10_130] = {
            100,
            60,
            0
          },
          far = 800,
          fog = 10,
          ground = 1,
          [r10_130] = {
            120,
            40,
            40,
            72,
            107,
            159
          },
          [r10_130] = {
            67,
            67,
            67,
            240
          },
          [r10_130] = {
            81,
            85,
            40,
            127
          },
          [r10_130] = {
            66,
            27,
            0,
            127
          },
          [r10_130] = {
            25,
            140,
            0,
            1
          },
        },
        [r8_130] = {
          [r10_130] = {
            21,
            20,
            20
          },
          [r10_130] = {
            210,
            194,
            182
          },
          [r10_130] = {
            255,
            255,
            255
          },
          [r10_130] = {
            137,
            100,
            84,
            60,
            50,
            52
          },
          [r10_130] = {
            255,
            128,
            0,
            5,
            8,
            0,
            1
          },
          [r10_130] = {
            0.3,
            1
          },
          [r10_130] = {
            160,
            100,
            0
          },
          far = 600,
          fog = 10,
          ground = 1,
          [r10_130] = {
            70,
            27,
            10,
            15,
            11,
            34
          },
          [r10_130] = {
            67,
            67,
            62,
            240
          },
          [r10_130] = {
            209,
            143,
            84,
            127
          },
          [r10_130] = {
            76,
            51,
            0,
            127
          },
          [r10_130] = {
            25,
            90,
            0,
            1
          },
        },
      },
    },
    {
      name = "Sunny LA",
      [r7_130] = {
        [r9_130] = {
          [r11_130] = {
            0,
            20,
            20
          },
          [r11_130] = {
            210,
            194,
            182
          },
          [r11_130] = {
            255,
            255,
            255
          },
          [r11_130] = {
            5,
            12,
            15,
            12,
            14,
            13
          },
          [r11_130] = {
            255,
            128,
            0,
            5,
            0,
            0,
            1
          },
          [r11_130] = {
            0.4,
            0.4
          },
          [r11_130] = {
            200,
            100,
            0
          },
          far = 800,
          fog = 100,
          ground = 1,
          [r11_130] = {
            0,
            0,
            0,
            3,
            3,
            3
          },
          [r11_130] = {
            85,
            85,
            65,
            240
          },
          [r11_130] = {
            110,
            126,
            210,
            127
          },
          [r11_130] = {
            0,
            81,
            104,
            212
          },
          [r11_130] = {
            55,
            220,
            0,
            1
          },
        },
        [r9_130] = {
          [r11_130] = {
            6,
            20,
            20
          },
          [r11_130] = {
            210,
            194,
            182
          },
          [r11_130] = {
            255,
            255,
            255
          },
          [r11_130] = {
            0,
            0,
            7,
            19,
            39,
            37
          },
          [r11_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            0
          },
          [r11_130] = {
            0.8,
            0.3
          },
          [r11_130] = {
            150,
            100,
            0
          },
          far = 800,
          fog = 100,
          ground = 1,
          [r11_130] = {
            0,
            0,
            0,
            14,
            15,
            18
          },
          [r11_130] = {
            25,
            51,
            52,
            240
          },
          [r11_130] = {
            102,
            132,
            227,
            127
          },
          [r11_130] = {
            4,
            85,
            95,
            162
          },
          [r11_130] = {
            90,
            220,
            0,
            1
          },
        },
        [r9_130] = {
          [r11_130] = {
            22,
            17,
            8
          },
          [r11_130] = {
            210,
            194,
            182
          },
          [r11_130] = {
            255,
            255,
            255
          },
          [r11_130] = {
            90,
            205,
            255,
            200,
            144,
            85
          },
          [r11_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            1.2
          },
          [r11_130] = {
            0.2,
            0.5
          },
          [r11_130] = {
            140,
            93,
            0
          },
          far = 800,
          fog = 100,
          ground = 0.8,
          [r11_130] = {
            100,
            34,
            25,
            120,
            92,
            88
          },
          [r11_130] = {
            90,
            170,
            170,
            240
          },
          [r11_130] = {
            86,
            86,
            86,
            127
          },
          [r11_130] = {
            149,
            94,
            0,
            127
          },
          [r11_130] = {
            177,
            220,
            0,
            1
          },
        },
        [r9_130] = {
          [r11_130] = {
            12,
            4,
            0
          },
          [r11_130] = {
            210,
            194,
            182
          },
          [r11_130] = {
            255,
            255,
            255
          },
          [r11_130] = {
            63,
            205,
            255,
            62,
            200,
            255
          },
          [r11_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            2.2
          },
          [r11_130] = {
            0,
            1
          },
          [r11_130] = {
            211,
            0,
            149
          },
          far = 800,
          fog = 100,
          ground = 0.5,
          [r11_130] = {
            120,
            40,
            40,
            159,
            142,
            106
          },
          [r11_130] = {
            145,
            170,
            170,
            240
          },
          [r11_130] = {
            58,
            110,
            115,
            127
          },
          [r11_130] = {
            123,
            70,
            14,
            121
          },
          [r11_130] = {
            177,
            220,
            0,
            1
          },
        },
        [r9_130] = {
          [r11_130] = {
            12,
            10,
            0
          },
          [r11_130] = {
            210,
            194,
            182
          },
          [r11_130] = {
            255,
            255,
            255
          },
          [r11_130] = {
            30,
            117,
            210,
            53,
            162,
            227
          },
          [r11_130] = {
            189,
            175,
            0,
            168,
            98,
            14,
            1.7
          },
          [r11_130] = {
            0,
            1
          },
          [r11_130] = {
            236,
            0,
            190
          },
          far = 800,
          fog = 100,
          ground = 0,
          [r11_130] = {
            44,
            34,
            23,
            129,
            128,
            123
          },
          [r11_130] = {
            90,
            170,
            170,
            240
          },
          [r11_130] = {
            70,
            121,
            120,
            120
          },
          [r11_130] = {
            160,
            88,
            21,
            127
          },
          [r11_130] = {
            88,
            220,
            0,
            1
          },
        },
        [r9_130] = {
          [r11_130] = {
            16,
            10,
            0
          },
          [r11_130] = {
            210,
            194,
            182
          },
          [r11_130] = {
            255,
            255,
            255
          },
          [r11_130] = {
            74,
            156,
            208,
            67,
            144,
            182
          },
          [r11_130] = {
            198,
            128,
            0,
            255,
            128,
            0,
            7.5
          },
          [r11_130] = {
            0,
            1
          },
          [r11_130] = {
            110,
            40,
            75
          },
          far = 800,
          fog = 100,
          ground = 0.8,
          [r11_130] = {
            120,
            40,
            40,
            155,
            155,
            155
          },
          [r11_130] = {
            50,
            97,
            97,
            240
          },
          [r11_130] = {
            90,
            123,
            113,
            106
          },
          [r11_130] = {
            114,
            61,
            10,
            127
          },
          [r11_130] = {
            88,
            220,
            0,
            1
          },
        },
        [r9_130] = {
          [r11_130] = {
            12,
            10,
            4
          },
          [r11_130] = {
            210,
            194,
            182
          },
          [r11_130] = {
            255,
            255,
            255
          },
          [r11_130] = {
            181,
            150,
            84,
            167,
            118,
            65
          },
          [r11_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            2
          },
          [r11_130] = {
            0.2,
            1
          },
          [r11_130] = {
            100,
            60,
            0
          },
          far = 800,
          fog = 43,
          ground = 1,
          [r11_130] = {
            0,
            0,
            0,
            163,
            83,
            63
          },
          [r11_130] = {
            67,
            67,
            67,
            240
          },
          [r11_130] = {
            129,
            93,
            71,
            127
          },
          [r11_130] = {
            66,
            27,
            0,
            127
          },
          [r11_130] = {
            177,
            220,
            0,
            1
          },
        },
        [r9_130] = {
          [r11_130] = {
            22,
            20,
            10
          },
          [r11_130] = {
            210,
            194,
            182
          },
          [r11_130] = {
            255,
            255,
            255
          },
          [r11_130] = {
            172,
            143,
            88,
            167,
            118,
            65
          },
          [r11_130] = {
            255,
            128,
            0,
            5,
            8,
            0,
            1
          },
          [r11_130] = {
            0.4,
            0.4
          },
          [r11_130] = {
            160,
            100,
            0
          },
          far = 800,
          fog = 41,
          ground = 1,
          [r11_130] = {
            70,
            27,
            10,
            55,
            55,
            55
          },
          [r11_130] = {
            67,
            67,
            62,
            240
          },
          [r11_130] = {
            129,
            0,
            0,
            127
          },
          [r11_130] = {
            66,
            106,
            0,
            127
          },
          [r11_130] = {
            111,
            60,
            0,
            1
          },
        },
      },
    },
    {
      name = "Extra Sunny Smog LA",
      [r8_130] = {
        [r10_130] = {
          [r12_130] = {
            33,
            33,
            33
          },
          [r12_130] = {
            249,
            244,
            235
          },
          [r12_130] = {
            255,
            255,
            255
          },
          [r12_130] = {
            19,
            14,
            19,
            6,
            6,
            17
          },
          [r12_130] = {
            255,
            128,
            0,
            5,
            0,
            0,
            1
          },
          [r12_130] = {
            0.9,
            0.3
          },
          [r12_130] = {
            200,
            102,
            0
          },
          far = 800,
          fog = 100,
          ground = 1,
          [r12_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r12_130] = {
            85,
            85,
            65,
            240
          },
          [r12_130] = {
            50,
            61,
            114,
            127
          },
          [r12_130] = {
            14,
            46,
            55,
            127
          },
          [r12_130] = {
            25,
            80,
            0,
            1
          },
        },
        [r10_130] = {
          [r12_130] = {
            22,
            33,
            33
          },
          [r12_130] = {
            210,
            194,
            182
          },
          [r12_130] = {
            255,
            255,
            255
          },
          [r12_130] = {
            16,
            16,
            22,
            15,
            15,
            20
          },
          [r12_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            0
          },
          [r12_130] = {
            0.9,
            0.3
          },
          [r12_130] = {
            150,
            100,
            0
          },
          far = 800,
          fog = 50,
          ground = 1,
          [r12_130] = {
            35,
            9,
            10,
            27,
            30,
            36
          },
          [r12_130] = {
            53,
            104,
            104,
            240
          },
          [r12_130] = {
            93,
            90,
            114,
            127
          },
          [r12_130] = {
            34,
            40,
            30,
            127
          },
          [r12_130] = {
            25,
            80,
            0,
            1
          },
        },
        [r10_130] = {
          [r12_130] = {
            20,
            16,
            16
          },
          [r12_130] = {
            210,
            194,
            182
          },
          [r12_130] = {
            255,
            255,
            255
          },
          [r12_130] = {
            90,
            205,
            255,
            200,
            144,
            85
          },
          [r12_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            8.4
          },
          [r12_130] = {
            0.4,
            0.2
          },
          [r12_130] = {
            140,
            93,
            0
          },
          far = 800,
          fog = 50,
          ground = 0.8,
          [r12_130] = {
            100,
            34,
            25,
            120,
            92,
            88
          },
          [r12_130] = {
            90,
            170,
            170,
            240
          },
          [r12_130] = {
            86,
            86,
            86,
            127
          },
          [r12_130] = {
            149,
            94,
            0,
            127
          },
          [r12_130] = {
            25,
            120,
            0,
            1
          },
        },
        [r10_130] = {
          [r12_130] = {
            11,
            7,
            1
          },
          [r12_130] = {
            210,
            194,
            182
          },
          [r12_130] = {
            255,
            255,
            255
          },
          [r12_130] = {
            90,
            205,
            255,
            114,
            148,
            166
          },
          [r12_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            1.2
          },
          [r12_130] = {
            0.8,
            0.2
          },
          [r12_130] = {
            100,
            50,
            75
          },
          far = 800,
          fog = 10,
          ground = 0.5,
          [r12_130] = {
            120,
            40,
            40,
            159,
            142,
            106
          },
          [r12_130] = {
            145,
            170,
            170,
            240
          },
          [r12_130] = {
            106,
            107,
            84,
            127
          },
          [r12_130] = {
            96,
            61,
            15,
            127
          },
          [r12_130] = {
            25,
            120,
            0,
            1
          },
        },
        [r10_130] = {
          [r12_130] = {
            14,
            7,
            2
          },
          [r12_130] = {
            210,
            194,
            182
          },
          [r12_130] = {
            255,
            255,
            255
          },
          [r12_130] = {
            90,
            147,
            255,
            129,
            148,
            182
          },
          [r12_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            1
          },
          [r12_130] = {
            0.3,
            0.2
          },
          [r12_130] = {
            236,
            0,
            190
          },
          far = 800,
          fog = 10,
          ground = 0,
          [r12_130] = {
            44,
            34,
            23,
            145,
            164,
            183
          },
          [r12_130] = {
            90,
            170,
            170,
            240
          },
          [r12_130] = {
            82,
            80,
            43,
            127
          },
          [r12_130] = {
            125,
            94,
            40,
            127
          },
          [r12_130] = {
            25,
            50,
            0,
            1
          },
        },
        [r10_130] = {
          [r12_130] = {
            10,
            10,
            5
          },
          [r12_130] = {
            210,
            194,
            182
          },
          [r12_130] = {
            255,
            255,
            255
          },
          [r12_130] = {
            93,
            127,
            157,
            90,
            144,
            182
          },
          [r12_130] = {
            198,
            128,
            0,
            255,
            128,
            0,
            7.5
          },
          [r12_130] = {
            1,
            0.3
          },
          [r12_130] = {
            110,
            40,
            103
          },
          far = 800,
          fog = 10,
          ground = 0.8,
          [r12_130] = {
            120,
            40,
            40,
            200,
            123,
            96
          },
          [r12_130] = {
            50,
            97,
            97,
            240
          },
          [r12_130] = {
            124,
            93,
            67,
            106
          },
          [r12_130] = {
            86,
            50,
            10,
            127
          },
          [r12_130] = {
            25,
            150,
            0,
            1
          },
        },
        [r10_130] = {
          [r12_130] = {
            10,
            5,
            5
          },
          [r12_130] = {
            210,
            194,
            182
          },
          [r12_130] = {
            255,
            255,
            255
          },
          [r12_130] = {
            181,
            150,
            84,
            167,
            118,
            65
          },
          [r12_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            2
          },
          [r12_130] = {
            1,
            0.3
          },
          [r12_130] = {
            100,
            60,
            0
          },
          far = 800,
          fog = 10,
          ground = 1,
          [r12_130] = {
            120,
            40,
            40,
            72,
            107,
            159
          },
          [r12_130] = {
            67,
            67,
            67,
            240
          },
          [r12_130] = {
            121,
            102,
            80,
            127
          },
          [r12_130] = {
            44,
            24,
            0,
            127
          },
          [r12_130] = {
            25,
            150,
            0,
            1
          },
        },
        [r10_130] = {
          [r12_130] = {
            22,
            12,
            15
          },
          [r12_130] = {
            255,
            222,
            222
          },
          [r12_130] = {
            255,
            255,
            255
          },
          [r12_130] = {
            209,
            150,
            84,
            167,
            118,
            65
          },
          [r12_130] = {
            255,
            128,
            0,
            5,
            8,
            0,
            1
          },
          [r12_130] = {
            0.3,
            0.3
          },
          [r12_130] = {
            160,
            100,
            0
          },
          far = 800,
          fog = 10,
          ground = 1,
          [r12_130] = {
            70,
            27,
            10,
            15,
            11,
            34
          },
          [r12_130] = {
            67,
            67,
            62,
            240
          },
          [r12_130] = {
            124,
            124,
            124,
            127
          },
          [r12_130] = {
            44,
            24,
            0,
            127
          },
          [r12_130] = {
            25,
            80,
            0,
            1
          },
        },
      },
    },
    {
      name = "Sunny Smog LA",
      [r9_130] = {
        [r11_130] = {
          [r13_130] = {
            33,
            33,
            33
          },
          [r13_130] = {
            210,
            188,
            166
          },
          [r13_130] = {
            255,
            255,
            255
          },
          [r13_130] = {
            22,
            5,
            12,
            13,
            13,
            31
          },
          [r13_130] = {
            255,
            128,
            0,
            5,
            0,
            0,
            1
          },
          [r13_130] = {
            0.6,
            0.4
          },
          [r13_130] = {
            200,
            100,
            0
          },
          far = 800,
          fog = 155,
          ground = 1,
          [r13_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r13_130] = {
            85,
            85,
            65,
            240
          },
          [r13_130] = {
            57,
            87,
            87,
            127
          },
          [r13_130] = {
            21,
            27,
            88,
            127
          },
          [r13_130] = {
            122,
            90,
            0,
            1
          },
        },
        [r11_130] = {
          [r13_130] = {
            33,
            33,
            33
          },
          [r13_130] = {
            210,
            194,
            182
          },
          [r13_130] = {
            255,
            255,
            255
          },
          [r13_130] = {
            15,
            15,
            16,
            14,
            14,
            20
          },
          [r13_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            0
          },
          [r13_130] = {
            1,
            0.4
          },
          [r13_130] = {
            150,
            100,
            0
          },
          far = 800,
          fog = 155,
          ground = 1,
          [r13_130] = {
            35,
            9,
            10,
            27,
            30,
            36
          },
          [r13_130] = {
            53,
            104,
            104,
            240
          },
          [r13_130] = {
            50,
            78,
            114,
            127
          },
          [r13_130] = {
            34,
            40,
            30,
            127
          },
          [r13_130] = {
            122,
            90,
            0,
            1
          },
        },
        [r11_130] = {
          [r13_130] = {
            33,
            33,
            33
          },
          [r13_130] = {
            210,
            194,
            182
          },
          [r13_130] = {
            255,
            255,
            255
          },
          [r13_130] = {
            90,
            205,
            255,
            200,
            144,
            85
          },
          [r13_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            8.4
          },
          [r13_130] = {
            0.9,
            0.3
          },
          [r13_130] = {
            140,
            93,
            0
          },
          far = 800,
          fog = 100,
          ground = 0.8,
          [r13_130] = {
            100,
            34,
            25,
            120,
            92,
            88
          },
          [r13_130] = {
            90,
            170,
            170,
            240
          },
          [r13_130] = {
            86,
            86,
            86,
            127
          },
          [r13_130] = {
            149,
            94,
            0,
            127
          },
          [r13_130] = {
            122,
            120,
            0,
            1
          },
        },
        [r11_130] = {
          [r13_130] = {
            20,
            11,
            5
          },
          [r13_130] = {
            210,
            194,
            182
          },
          [r13_130] = {
            255,
            255,
            255
          },
          [r13_130] = {
            90,
            205,
            255,
            222,
            204,
            200
          },
          [r13_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            1.2
          },
          [r13_130] = {
            0.1,
            0.2
          },
          [r13_130] = {
            236,
            50,
            75
          },
          far = 800,
          fog = 100,
          ground = 0.5,
          [r13_130] = {
            120,
            40,
            40,
            159,
            142,
            106
          },
          [r13_130] = {
            145,
            170,
            170,
            240
          },
          [r13_130] = {
            106,
            106,
            106,
            127
          },
          [r13_130] = {
            96,
            61,
            15,
            127
          },
          [r13_130] = {
            122,
            180,
            0,
            1
          },
        },
        [r11_130] = {
          [r13_130] = {
            15,
            7,
            0
          },
          [r13_130] = {
            210,
            194,
            182
          },
          [r13_130] = {
            255,
            255,
            255
          },
          [r13_130] = {
            79,
            140,
            243,
            143,
            175,
            175
          },
          [r13_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            2.5
          },
          [r13_130] = {
            0.1,
            1
          },
          [r13_130] = {
            236,
            0,
            190
          },
          far = 800,
          fog = 80,
          ground = 0,
          [r13_130] = {
            44,
            34,
            23,
            145,
            164,
            183
          },
          [r13_130] = {
            90,
            170,
            170,
            240
          },
          [r13_130] = {
            127,
            123,
            110,
            127
          },
          [r13_130] = {
            99,
            74,
            10,
            127
          },
          [r13_130] = {
            122,
            180,
            0,
            1
          },
        },
        [r11_130] = {
          [r13_130] = {
            15,
            11,
            0
          },
          [r13_130] = {
            210,
            194,
            182
          },
          [r13_130] = {
            255,
            255,
            255
          },
          [r13_130] = {
            109,
            142,
            157,
            90,
            144,
            182
          },
          [r13_130] = {
            255,
            55,
            0,
            255,
            255,
            255,
            4.3
          },
          [r13_130] = {
            0.4,
            0.3
          },
          [r13_130] = {
            222,
            40,
            75
          },
          far = 800,
          fog = 10,
          ground = 0.8,
          [r13_130] = {
            120,
            40,
            40,
            200,
            123,
            96
          },
          [r13_130] = {
            50,
            97,
            97,
            240
          },
          [r13_130] = {
            124,
            124,
            107,
            106
          },
          [r13_130] = {
            86,
            50,
            10,
            127
          },
          [r13_130] = {
            122,
            180,
            0,
            1
          },
        },
        [r11_130] = {
          [r13_130] = {
            15,
            5,
            0
          },
          [r13_130] = {
            210,
            194,
            182
          },
          [r13_130] = {
            255,
            255,
            255
          },
          [r13_130] = {
            181,
            150,
            84,
            167,
            118,
            65
          },
          [r13_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            2
          },
          [r13_130] = {
            0.7,
            0.3
          },
          [r13_130] = {
            100,
            60,
            0
          },
          far = 800,
          fog = 10,
          ground = 1,
          [r13_130] = {
            120,
            40,
            40,
            72,
            107,
            159
          },
          [r13_130] = {
            67,
            67,
            67,
            240
          },
          [r13_130] = {
            121,
            93,
            71,
            127
          },
          [r13_130] = {
            44,
            24,
            0,
            127
          },
          [r13_130] = {
            122,
            120,
            0,
            1
          },
        },
        [r11_130] = {
          [r13_130] = {
            33,
            12,
            12
          },
          [r13_130] = {
            210,
            194,
            182
          },
          [r13_130] = {
            255,
            255,
            255
          },
          [r13_130] = {
            181,
            150,
            84,
            197,
            103,
            39
          },
          [r13_130] = {
            255,
            128,
            0,
            5,
            8,
            0,
            1
          },
          [r13_130] = {
            0.6,
            0.3
          },
          [r13_130] = {
            160,
            100,
            0
          },
          far = 800,
          fog = 10,
          ground = 1,
          [r13_130] = {
            70,
            27,
            10,
            15,
            11,
            34
          },
          [r13_130] = {
            67,
            67,
            62,
            240
          },
          [r13_130] = {
            117,
            124,
            83,
            127
          },
          [r13_130] = {
            66,
            27,
            0,
            127
          },
          [r13_130] = {
            122,
            90,
            0,
            1
          },
        },
      },
    },
    {
      name = "Cloudy LA",
      [r10_130] = {
        [r12_130] = {
          [r14_130] = {
            10,
            30,
            30
          },
          [r14_130] = {
            157,
            176,
            208
          },
          [r14_130] = {
            255,
            255,
            255
          },
          [r14_130] = {
            10,
            10,
            10,
            10,
            23,
            33
          },
          [r14_130] = {
            10,
            10,
            0,
            10,
            0,
            0,
            1
          },
          [r14_130] = {
            0.2,
            1
          },
          [r14_130] = {
            200,
            100,
            0
          },
          far = 700,
          fog = 79,
          ground = 1,
          [r14_130] = {
            30,
            20,
            0,
            23,
            28,
            30
          },
          [r14_130] = {
            55,
            55,
            66,
            240
          },
          [r14_130] = {
            124,
            124,
            124,
            127
          },
          [r14_130] = {
            45,
            49,
            32,
            127
          },
          [r14_130] = {
            155,
            51,
            0,
            1
          },
        },
        [r12_130] = {
          [r14_130] = {
            10,
            24,
            27
          },
          [r14_130] = {
            160,
            171,
            202
          },
          [r14_130] = {
            255,
            255,
            255
          },
          [r14_130] = {
            10,
            10,
            10,
            10,
            22,
            33
          },
          [r14_130] = {
            10,
            10,
            0,
            10,
            0,
            0,
            1
          },
          [r14_130] = {
            0.1,
            1
          },
          [r14_130] = {
            200,
            100,
            0
          },
          far = 700,
          fog = -22,
          ground = 1,
          [r14_130] = {
            70,
            27,
            10,
            23,
            28,
            30
          },
          [r14_130] = {
            55,
            55,
            66,
            240
          },
          [r14_130] = {
            80,
            85,
            91,
            127
          },
          [r14_130] = {
            98,
            120,
            120,
            127
          },
          [r14_130] = {
            155,
            100,
            0,
            1
          },
        },
        [r12_130] = {
          [r14_130] = {
            16,
            31,
            31
          },
          [r14_130] = {
            163,
            187,
            192
          },
          [r14_130] = {
            255,
            255,
            255
          },
          [r14_130] = {
            22,
            22,
            22,
            15,
            25,
            27
          },
          [r14_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            3.4
          },
          [r14_130] = {
            0.1,
            0.9
          },
          [r14_130] = {
            200,
            100,
            0
          },
          far = 700,
          fog = 90,
          ground = 0.8,
          [r14_130] = {
            100,
            34,
            25,
            23,
            28,
            30
          },
          [r14_130] = {
            77,
            77,
            88,
            240
          },
          [r14_130] = {
            63,
            80,
            80,
            127
          },
          [r14_130] = {
            122,
            122,
            90,
            127
          },
          [r14_130] = {
            155,
            180,
            0,
            1
          },
        },
        [r12_130] = {
          [r14_130] = {
            22,
            22,
            22
          },
          [r14_130] = {
            190,
            176,
            169
          },
          [r14_130] = {
            255,
            255,
            255
          },
          [r14_130] = {
            125,
            145,
            151,
            125,
            145,
            151
          },
          [r14_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            0
          },
          [r14_130] = {
            0.1,
            0.7
          },
          [r14_130] = {
            80,
            50,
            0
          },
          far = 700,
          fog = -22,
          ground = 0.5,
          [r14_130] = {
            120,
            40,
            40,
            92,
            116,
            125
          },
          [r14_130] = {
            77,
            77,
            88,
            240
          },
          [r14_130] = {
            124,
            124,
            124,
            127
          },
          [r14_130] = {
            45,
            28,
            12,
            127
          },
          [r14_130] = {
            155,
            180,
            0,
            1
          },
        },
        [r12_130] = {
          [r14_130] = {
            22,
            22,
            22
          },
          [r14_130] = {
            190,
            176,
            169
          },
          [r14_130] = {
            255,
            255,
            255
          },
          [r14_130] = {
            125,
            145,
            151,
            125,
            145,
            151
          },
          [r14_130] = {
            10,
            10,
            0,
            10,
            0,
            0,
            2.8
          },
          [r14_130] = {
            0.1,
            0.5
          },
          [r14_130] = {
            80,
            0,
            120
          },
          far = 700,
          fog = -22,
          ground = 0.3,
          [r14_130] = {
            120,
            100,
            100,
            92,
            116,
            123
          },
          [r14_130] = {
            125,
            125,
            125,
            240
          },
          [r14_130] = {
            80,
            80,
            80,
            127
          },
          [r14_130] = {
            122,
            122,
            122,
            127
          },
          [r14_130] = {
            155,
            180,
            0,
            1
          },
        },
        [r12_130] = {
          [r14_130] = {
            22,
            22,
            22
          },
          [r14_130] = {
            190,
            176,
            169
          },
          [r14_130] = {
            255,
            255,
            255
          },
          [r14_130] = {
            125,
            145,
            151,
            125,
            145,
            151
          },
          [r14_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            3.5
          },
          [r14_130] = {
            0.1,
            1
          },
          [r14_130] = {
            80,
            0,
            0
          },
          far = 700,
          fog = -22,
          ground = 0.8,
          [r14_130] = {
            120,
            100,
            100,
            92,
            116,
            123
          },
          [r14_130] = {
            123,
            128,
            134,
            240
          },
          [r14_130] = {
            44,
            44,
            44,
            127
          },
          [r14_130] = {
            122,
            122,
            122,
            127
          },
          [r14_130] = {
            155,
            180,
            0,
            1
          },
        },
        [r12_130] = {
          [r14_130] = {
            22,
            22,
            22
          },
          [r14_130] = {
            190,
            176,
            169
          },
          [r14_130] = {
            255,
            255,
            255
          },
          [r14_130] = {
            34,
            56,
            62,
            62,
            72,
            75
          },
          [r14_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            0
          },
          [r14_130] = {
            0.1,
            1
          },
          [r14_130] = {
            80,
            50,
            0
          },
          far = 700,
          fog = -22,
          ground = 1,
          [r14_130] = {
            120,
            100,
            100,
            46,
            58,
            61
          },
          [r14_130] = {
            122,
            126,
            134,
            240
          },
          [r14_130] = {
            90,
            90,
            90,
            127
          },
          [r14_130] = {
            90,
            122,
            122,
            127
          },
          [r14_130] = {
            155,
            180,
            0,
            1
          },
        },
        [r12_130] = {
          [r14_130] = {
            24,
            28,
            20
          },
          [r14_130] = {
            222,
            200,
            200
          },
          [r14_130] = {
            255,
            255,
            255
          },
          [r14_130] = {
            15,
            15,
            20,
            20,
            22,
            22
          },
          [r14_130] = {
            10,
            10,
            0,
            10,
            0,
            0,
            1
          },
          [r14_130] = {
            0.4,
            1
          },
          [r14_130] = {
            200,
            100,
            0
          },
          far = 700,
          fog = 111,
          ground = 1,
          [r14_130] = {
            70,
            27,
            10,
            23,
            28,
            30
          },
          [r14_130] = {
            10,
            70,
            60,
            240
          },
          [r14_130] = {
            64,
            64,
            100,
            127
          },
          [r14_130] = {
            69,
            70,
            87,
            127
          },
          [r14_130] = {
            155,
            20,
            0,
            1
          },
        },
      },
    },
    {
      name = "Sunny SF",
      [r11_130] = {
        [r13_130] = {
          [r15_130] = {
            20,
            30,
            30
          },
          [r15_130] = {
            133,
            133,
            133
          },
          [r15_130] = {
            255,
            255,
            255
          },
          [r15_130] = {
            0,
            8,
            12,
            10,
            36,
            65
          },
          [r15_130] = {
            255,
            128,
            0,
            5,
            0,
            0,
            1
          },
          [r15_130] = {
            0.4,
            0.5
          },
          [r15_130] = {
            200,
            100,
            0
          },
          far = 450,
          fog = 100,
          ground = 1,
          [r15_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r15_130] = {
            19,
            40,
            52,
            240
          },
          [r15_130] = {
            66,
            66,
            66,
            127
          },
          [r15_130] = {
            88,
            56,
            28,
            127
          },
          [r15_130] = {
            50,
            120,
            0,
            1
          },
        },
        [r13_130] = {
          [r15_130] = {
            20,
            30,
            30
          },
          [r15_130] = {
            143,
            143,
            143
          },
          [r15_130] = {
            255,
            255,
            255
          },
          [r15_130] = {
            15,
            22,
            32,
            4,
            32,
            66
          },
          [r15_130] = {
            255,
            128,
            0,
            255,
            0,
            0,
            0
          },
          [r15_130] = {
            1,
            0.3
          },
          [r15_130] = {
            150,
            100,
            0
          },
          far = 454,
          fog = 100,
          ground = 1,
          [r15_130] = {
            70,
            27,
            10,
            50,
            43,
            36
          },
          [r15_130] = {
            21,
            41,
            56,
            240
          },
          [r15_130] = {
            66,
            99,
            66,
            127
          },
          [r15_130] = {
            88,
            47,
            23,
            127
          },
          [r15_130] = {
            50,
            120,
            0,
            1
          },
        },
        [r13_130] = {
          [r15_130] = {
            30,
            30,
            30
          },
          [r15_130] = {
            188,
            188,
            188
          },
          [r15_130] = {
            255,
            255,
            255
          },
          [r15_130] = {
            90,
            205,
            255,
            200,
            144,
            85
          },
          [r15_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            3
          },
          [r15_130] = {
            0.9,
            0.2
          },
          [r15_130] = {
            140,
            100,
            0
          },
          far = 455,
          fog = 66,
          ground = 0.8,
          [r15_130] = {
            100,
            34,
            25,
            120,
            92,
            88
          },
          [r15_130] = {
            178,
            160,
            160,
            200
          },
          [r15_130] = {
            124,
            124,
            124,
            127
          },
          [r15_130] = {
            45,
            47,
            23,
            127
          },
          [r15_130] = {
            50,
            120,
            70,
            1
          },
        },
        [r13_130] = {
          [r15_130] = {
            24,
            26,
            30
          },
          [r15_130] = {
            188,
            188,
            188
          },
          [r15_130] = {
            255,
            255,
            255
          },
          [r15_130] = {
            90,
            205,
            255,
            187,
            146,
            116
          },
          [r15_130] = {
            255,
            128,
            0,
            255,
            0,
            0,
            3.3
          },
          [r15_130] = {
            0.1,
            1
          },
          [r15_130] = {
            100,
            50,
            0
          },
          far = 455,
          fog = 66,
          ground = 0.5,
          [r15_130] = {
            120,
            40,
            40,
            159,
            142,
            106
          },
          [r15_130] = {
            145,
            170,
            170,
            240
          },
          [r15_130] = {
            55,
            62,
            64,
            127
          },
          [r15_130] = {
            66,
            66,
            80,
            127
          },
          [r15_130] = {
            50,
            120,
            0,
            1
          },
        },
        [r13_130] = {
          [r15_130] = {
            30,
            30,
            30
          },
          [r15_130] = {
            188,
            188,
            188
          },
          [r15_130] = {
            255,
            255,
            255
          },
          [r15_130] = {
            90,
            180,
            255,
            90,
            200,
            255
          },
          [r15_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            2.5
          },
          [r15_130] = {
            0.1,
            1
          },
          [r15_130] = {
            150,
            0,
            150
          },
          far = 455,
          fog = 66,
          ground = 1,
          [r15_130] = {
            120,
            100,
            100,
            180,
            255,
            255
          },
          [r15_130] = {
            90,
            170,
            170,
            240
          },
          [r15_130] = {
            44,
            94,
            89,
            127
          },
          [r15_130] = {
            45,
            66,
            36,
            127
          },
          [r15_130] = {
            50,
            120,
            0,
            1
          },
        },
        [r13_130] = {
          [r15_130] = {
            30,
            30,
            30
          },
          [r15_130] = {
            163,
            163,
            163
          },
          [r15_130] = {
            255,
            255,
            255
          },
          [r15_130] = {
            109,
            142,
            157,
            111,
            155,
            155
          },
          [r15_130] = {
            255,
            0,
            0,
            255,
            0,
            0,
            3.3
          },
          [r15_130] = {
            0.2,
            1
          },
          [r15_130] = {
            110,
            40,
            0
          },
          far = 455,
          fog = 66,
          ground = 0.8,
          [r15_130] = {
            120,
            40,
            40,
            200,
            123,
            96
          },
          [r15_130] = {
            103,
            95,
            87,
            240
          },
          [r15_130] = {
            33,
            99,
            99,
            127
          },
          [r15_130] = {
            66,
            66,
            44,
            127
          },
          [r15_130] = {
            50,
            120,
            0,
            1
          },
        },
        [r13_130] = {
          [r15_130] = {
            30,
            30,
            30
          },
          [r15_130] = {
            163,
            163,
            163
          },
          [r15_130] = {
            255,
            255,
            255
          },
          [r15_130] = {
            109,
            142,
            189,
            165,
            155,
            130
          },
          [r15_130] = {
            255,
            128,
            0,
            155,
            0,
            0,
            2
          },
          [r15_130] = {
            0.3,
            0.6
          },
          [r15_130] = {
            100,
            60,
            0
          },
          far = 455,
          fog = 66,
          ground = 1,
          [r15_130] = {
            120,
            40,
            40,
            0,
            0,
            0
          },
          [r15_130] = {
            67,
            67,
            67,
            240
          },
          [r15_130] = {
            124,
            66,
            44,
            127
          },
          [r15_130] = {
            66,
            55,
            23,
            127
          },
          [r15_130] = {
            50,
            120,
            0,
            1
          },
        },
        [r13_130] = {
          [r15_130] = {
            13,
            13,
            30
          },
          [r15_130] = {
            143,
            143,
            143
          },
          [r15_130] = {
            255,
            255,
            255
          },
          [r15_130] = {
            20,
            15,
            45,
            13,
            44,
            65
          },
          [r15_130] = {
            255,
            5,
            8,
            5,
            8,
            0,
            1
          },
          [r15_130] = {
            0.5,
            0.5
          },
          [r15_130] = {
            160,
            100,
            0
          },
          far = 455,
          fog = 66,
          ground = 1,
          [r15_130] = {
            70,
            27,
            10,
            0,
            0,
            0
          },
          [r15_130] = {
            44,
            73,
            96,
            240
          },
          [r15_130] = {
            124,
            124,
            124,
            127
          },
          [r15_130] = {
            45,
            47,
            23,
            127
          },
          [r15_130] = {
            50,
            112,
            0,
            1
          },
        },
      },
    },
    {
      name = "Extra Sunny SF",
      [r12_130] = {
        [r14_130] = {
          [r16_130] = {
            20,
            30,
            30
          },
          [r16_130] = {
            133,
            133,
            133
          },
          [r16_130] = {
            255,
            255,
            255
          },
          [r16_130] = {
            10,
            36,
            65,
            10,
            36,
            65
          },
          [r16_130] = {
            255,
            128,
            0,
            5,
            0,
            0,
            1
          },
          [r16_130] = {
            0.4,
            0.5
          },
          [r16_130] = {
            200,
            100,
            0
          },
          far = 450,
          fog = 100,
          ground = 1,
          [r16_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r16_130] = {
            19,
            40,
            52,
            240
          },
          [r16_130] = {
            66,
            66,
            66,
            127
          },
          [r16_130] = {
            88,
            56,
            28,
            127
          },
          [r16_130] = {
            0,
            120,
            0,
            1
          },
        },
        [r14_130] = {
          [r16_130] = {
            20,
            30,
            30
          },
          [r16_130] = {
            143,
            143,
            143
          },
          [r16_130] = {
            255,
            255,
            255
          },
          [r16_130] = {
            4,
            32,
            66,
            4,
            32,
            66
          },
          [r16_130] = {
            255,
            128,
            0,
            255,
            0,
            0,
            0
          },
          [r16_130] = {
            1,
            0.3
          },
          [r16_130] = {
            150,
            100,
            0
          },
          far = 454,
          fog = 100,
          ground = 1,
          [r16_130] = {
            70,
            27,
            10,
            50,
            43,
            36
          },
          [r16_130] = {
            21,
            41,
            56,
            240
          },
          [r16_130] = {
            66,
            99,
            66,
            127
          },
          [r16_130] = {
            88,
            47,
            23,
            127
          },
          [r16_130] = {
            0,
            120,
            0,
            1
          },
        },
        [r14_130] = {
          [r16_130] = {
            16,
            20,
            27
          },
          [r16_130] = {
            188,
            188,
            188
          },
          [r16_130] = {
            255,
            255,
            255
          },
          [r16_130] = {
            155,
            155,
            155,
            198,
            124,
            85
          },
          [r16_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            2.7
          },
          [r16_130] = {
            0.2,
            0.2
          },
          [r16_130] = {
            140,
            100,
            0
          },
          far = 455,
          fog = 66,
          ground = 0.8,
          [r16_130] = {
            100,
            34,
            25,
            120,
            92,
            88
          },
          [r16_130] = {
            178,
            160,
            160,
            200
          },
          [r16_130] = {
            86,
            86,
            86,
            127
          },
          [r16_130] = {
            166,
            94,
            0,
            127
          },
          [r16_130] = {
            0,
            120,
            0,
            1
          },
        },
        [r14_130] = {
          [r16_130] = {
            12,
            0,
            0
          },
          [r16_130] = {
            188,
            188,
            188
          },
          [r16_130] = {
            255,
            255,
            255
          },
          [r16_130] = {
            155,
            155,
            155,
            198,
            124,
            85
          },
          [r16_130] = {
            255,
            128,
            0,
            255,
            0,
            0,
            1.7
          },
          [r16_130] = {
            0.1,
            1
          },
          [r16_130] = {
            100,
            50,
            0
          },
          far = 455,
          fog = 66,
          ground = 0.5,
          [r16_130] = {
            120,
            40,
            40,
            159,
            142,
            106
          },
          [r16_130] = {
            145,
            170,
            170,
            240
          },
          [r16_130] = {
            86,
            86,
            86,
            127
          },
          [r16_130] = {
            166,
            94,
            0,
            127
          },
          [r16_130] = {
            0,
            120,
            0,
            1
          },
        },
        [r14_130] = {
          [r16_130] = {
            30,
            30,
            30
          },
          [r16_130] = {
            188,
            188,
            188
          },
          [r16_130] = {
            255,
            255,
            255
          },
          [r16_130] = {
            90,
            180,
            255,
            90,
            200,
            255
          },
          [r16_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            2.5
          },
          [r16_130] = {
            0.1,
            1
          },
          [r16_130] = {
            150,
            0,
            150
          },
          far = 455,
          fog = 66,
          ground = 1,
          [r16_130] = {
            120,
            100,
            100,
            180,
            255,
            255
          },
          [r16_130] = {
            90,
            170,
            170,
            240
          },
          [r16_130] = {
            44,
            94,
            89,
            127
          },
          [r16_130] = {
            45,
            66,
            36,
            127
          },
          [r16_130] = {
            0,
            120,
            0,
            1
          },
        },
        [r14_130] = {
          [r16_130] = {
            30,
            30,
            30
          },
          [r16_130] = {
            163,
            163,
            163
          },
          [r16_130] = {
            255,
            255,
            255
          },
          [r16_130] = {
            109,
            142,
            157,
            111,
            155,
            155
          },
          [r16_130] = {
            255,
            0,
            0,
            255,
            0,
            0,
            3.3
          },
          [r16_130] = {
            0.2,
            1
          },
          [r16_130] = {
            110,
            40,
            0
          },
          far = 455,
          fog = 66,
          ground = 0.8,
          [r16_130] = {
            120,
            40,
            40,
            200,
            123,
            96
          },
          [r16_130] = {
            103,
            95,
            87,
            240
          },
          [r16_130] = {
            33,
            99,
            99,
            127
          },
          [r16_130] = {
            66,
            66,
            44,
            127
          },
          [r16_130] = {
            0,
            120,
            0,
            1
          },
        },
        [r14_130] = {
          [r16_130] = {
            30,
            30,
            30
          },
          [r16_130] = {
            163,
            163,
            163
          },
          [r16_130] = {
            255,
            255,
            255
          },
          [r16_130] = {
            109,
            142,
            189,
            165,
            155,
            130
          },
          [r16_130] = {
            255,
            128,
            0,
            155,
            0,
            0,
            2
          },
          [r16_130] = {
            0.3,
            0.6
          },
          [r16_130] = {
            100,
            60,
            0
          },
          far = 455,
          fog = 66,
          ground = 1,
          [r16_130] = {
            120,
            40,
            40,
            0,
            0,
            0
          },
          [r16_130] = {
            67,
            67,
            67,
            240
          },
          [r16_130] = {
            124,
            66,
            44,
            127
          },
          [r16_130] = {
            66,
            55,
            23,
            127
          },
          [r16_130] = {
            0,
            120,
            0,
            1
          },
        },
        [r14_130] = {
          [r16_130] = {
            13,
            13,
            30
          },
          [r16_130] = {
            141,
            141,
            141
          },
          [r16_130] = {
            255,
            255,
            255
          },
          [r16_130] = {
            5,
            25,
            45,
            13,
            44,
            65
          },
          [r16_130] = {
            255,
            5,
            8,
            5,
            8,
            0,
            1
          },
          [r16_130] = {
            0.5,
            0.5
          },
          [r16_130] = {
            160,
            100,
            0
          },
          far = 455,
          fog = 66,
          ground = 1,
          [r16_130] = {
            70,
            27,
            10,
            0,
            0,
            0
          },
          [r16_130] = {
            44,
            73,
            96,
            240
          },
          [r16_130] = {
            124,
            124,
            124,
            127
          },
          [r16_130] = {
            45,
            47,
            23,
            127
          },
          [r16_130] = {
            0,
            112,
            0,
            1
          },
        },
      },
    },
    {
      name = "Cloudy SF",
      [r13_130] = {
        [r15_130] = {
          [r17_130] = {
            30,
            30,
            30
          },
          [r17_130] = {
            108,
            108,
            101
          },
          [r17_130] = {
            255,
            255,
            255
          },
          [r17_130] = {
            11,
            11,
            11,
            11,
            11,
            11
          },
          [r17_130] = {
            10,
            10,
            0,
            10,
            0,
            0,
            1
          },
          [r17_130] = {
            1,
            1
          },
          [r17_130] = {
            200,
            100,
            0
          },
          far = 1150,
          fog = -22,
          ground = 1,
          [r17_130] = {
            30,
            20,
            0,
            23,
            28,
            30
          },
          [r17_130] = {
            55,
            55,
            66,
            240
          },
          [r17_130] = {
            64,
            64,
            12,
            127
          },
          [r17_130] = {
            88,
            66,
            66,
            127
          },
          [r17_130] = {
            155,
            0,
            0,
            1
          },
        },
        [r15_130] = {
          [r17_130] = {
            30,
            22,
            30
          },
          [r17_130] = {
            108,
            108,
            101
          },
          [r17_130] = {
            255,
            255,
            255
          },
          [r17_130] = {
            14,
            14,
            14,
            14,
            14,
            14
          },
          [r17_130] = {
            10,
            10,
            0,
            10,
            0,
            0,
            0
          },
          [r17_130] = {
            1,
            1
          },
          [r17_130] = {
            200,
            100,
            0
          },
          far = 1150,
          fog = -22,
          ground = 1,
          [r17_130] = {
            70,
            27,
            10,
            23,
            28,
            30
          },
          [r17_130] = {
            55,
            55,
            66,
            240
          },
          [r17_130] = {
            77,
            67,
            52,
            127
          },
          [r17_130] = {
            85,
            72,
            66,
            127
          },
          [r17_130] = {
            155,
            0,
            0,
            1
          },
        },
        [r15_130] = {
          [r17_130] = {
            30,
            30,
            30
          },
          [r17_130] = {
            153,
            153,
            153
          },
          [r17_130] = {
            255,
            255,
            255
          },
          [r17_130] = {
            41,
            46,
            47,
            31,
            36,
            37
          },
          [r17_130] = {
            10,
            10,
            0,
            10,
            0,
            0,
            3.4
          },
          [r17_130] = {
            0.9,
            0.9
          },
          [r17_130] = {
            200,
            100,
            0
          },
          far = 1150,
          fog = -22,
          ground = 0.8,
          [r17_130] = {
            100,
            34,
            25,
            23,
            28,
            30
          },
          [r17_130] = {
            77,
            77,
            88,
            240
          },
          [r17_130] = {
            64,
            64,
            64,
            127
          },
          [r17_130] = {
            77,
            77,
            77,
            127
          },
          [r17_130] = {
            155,
            0,
            100,
            1
          },
        },
        [r15_130] = {
          [r17_130] = {
            5,
            5,
            12
          },
          [r17_130] = {
            153,
            153,
            153
          },
          [r17_130] = {
            255,
            255,
            255
          },
          [r17_130] = {
            62,
            72,
            75,
            62,
            72,
            75
          },
          [r17_130] = {
            10,
            10,
            0,
            10,
            0,
            0,
            0
          },
          [r17_130] = {
            0.8,
            0.7
          },
          [r17_130] = {
            200,
            50,
            0
          },
          far = 1150,
          fog = -22,
          ground = 0.5,
          [r17_130] = {
            120,
            40,
            40,
            46,
            58,
            61
          },
          [r17_130] = {
            77,
            77,
            88,
            240
          },
          [r17_130] = {
            124,
            124,
            124,
            127
          },
          [r17_130] = {
            48,
            48,
            48,
            127
          },
          [r17_130] = {
            155,
            0,
            0,
            1
          },
        },
        [r15_130] = {
          [r17_130] = {
            5,
            5,
            12
          },
          [r17_130] = {
            122,
            123,
            123
          },
          [r17_130] = {
            255,
            255,
            255
          },
          [r17_130] = {
            125,
            145,
            151,
            125,
            145,
            151
          },
          [r17_130] = {
            10,
            10,
            0,
            10,
            0,
            0,
            2.8
          },
          [r17_130] = {
            0.7,
            0.5
          },
          [r17_130] = {
            80,
            0,
            120
          },
          far = 1150,
          fog = -22,
          ground = 0.3,
          [r17_130] = {
            120,
            100,
            100,
            92,
            116,
            123
          },
          [r17_130] = {
            125,
            125,
            125,
            240
          },
          [r17_130] = {
            124,
            124,
            124,
            127
          },
          [r17_130] = {
            48,
            48,
            48,
            127
          },
          [r17_130] = {
            155,
            0,
            0,
            1
          },
        },
        [r15_130] = {
          [r17_130] = {
            5,
            30,
            30
          },
          [r17_130] = {
            123,
            123,
            123
          },
          [r17_130] = {
            255,
            255,
            255
          },
          [r17_130] = {
            62,
            72,
            75,
            62,
            72,
            75
          },
          [r17_130] = {
            10,
            10,
            0,
            10,
            0,
            0,
            3.5
          },
          [r17_130] = {
            1,
            1
          },
          [r17_130] = {
            80,
            0,
            0
          },
          far = 1150,
          fog = -22,
          ground = 0.8,
          [r17_130] = {
            120,
            100,
            100,
            46,
            58,
            61
          },
          [r17_130] = {
            123,
            128,
            134,
            240
          },
          [r17_130] = {
            124,
            124,
            124,
            127
          },
          [r17_130] = {
            48,
            48,
            48,
            127
          },
          [r17_130] = {
            155,
            0,
            0,
            1
          },
        },
        [r15_130] = {
          [r17_130] = {
            30,
            30,
            30
          },
          [r17_130] = {
            108,
            108,
            108
          },
          [r17_130] = {
            255,
            255,
            255
          },
          [r17_130] = {
            62,
            72,
            75,
            62,
            72,
            75
          },
          [r17_130] = {
            10,
            10,
            0,
            10,
            0,
            0,
            2
          },
          [r17_130] = {
            1,
            1
          },
          [r17_130] = {
            80,
            50,
            0
          },
          far = 1150,
          fog = -22,
          ground = 1,
          [r17_130] = {
            120,
            100,
            100,
            46,
            58,
            61
          },
          [r17_130] = {
            122,
            126,
            134,
            240
          },
          [r17_130] = {
            64,
            64,
            55,
            127
          },
          [r17_130] = {
            48,
            48,
            48,
            127
          },
          [r17_130] = {
            155,
            0,
            0,
            1
          },
        },
        [r15_130] = {
          [r17_130] = {
            30,
            30,
            30
          },
          [r17_130] = {
            108,
            108,
            108
          },
          [r17_130] = {
            255,
            255,
            255
          },
          [r17_130] = {
            41,
            46,
            47,
            31,
            36,
            37
          },
          [r17_130] = {
            10,
            10,
            0,
            10,
            0,
            0,
            1
          },
          [r17_130] = {
            1,
            1
          },
          [r17_130] = {
            200,
            100,
            0
          },
          far = 1150,
          fog = -22,
          ground = 1,
          [r17_130] = {
            70,
            27,
            10,
            23,
            28,
            30
          },
          [r17_130] = {
            77,
            77,
            88,
            240
          },
          [r17_130] = {
            64,
            64,
            12,
            127
          },
          [r17_130] = {
            48,
            48,
            48,
            127
          },
          [r17_130] = {
            155,
            0,
            0,
            1
          },
        },
      },
    },
    {
      name = "Rainy SF",
      [r14_130] = {
        [r16_130] = {
          [r18_130] = {
            20,
            30,
            30
          },
          [r18_130] = {
            135,
            173,
            197
          },
          [r18_130] = {
            255,
            255,
            255
          },
          [r18_130] = {
            10,
            10,
            10,
            20,
            20,
            20
          },
          [r18_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            1
          },
          [r18_130] = {
            0.5,
            1
          },
          [r18_130] = {
            200,
            100,
            0
          },
          far = 650,
          fog = 5,
          ground = 1,
          [r18_130] = {
            30,
            20,
            0,
            0,
            0,
            0
          },
          [r18_130] = {
            59,
            68,
            77,
            240
          },
          [r18_130] = {
            124,
            124,
            124,
            127
          },
          [r18_130] = {
            16,
            48,
            10,
            127
          },
          [r18_130] = {
            155,
            0,
            0,
            1
          },
          rain = 0.8,
        },
        [r16_130] = {
          [r18_130] = {
            20,
            30,
            30
          },
          [r18_130] = {
            135,
            173,
            197
          },
          [r18_130] = {
            255,
            255,
            255
          },
          [r18_130] = {
            10,
            10,
            10,
            20,
            20,
            20
          },
          [r18_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            0
          },
          [r18_130] = {
            0.6,
            1
          },
          [r18_130] = {
            200,
            100,
            0
          },
          far = 650,
          fog = 5,
          ground = 1,
          [r18_130] = {
            70,
            27,
            10,
            0,
            0,
            0
          },
          [r18_130] = {
            59,
            68,
            77,
            240
          },
          [r18_130] = {
            124,
            124,
            124,
            127
          },
          [r18_130] = {
            0,
            48,
            20,
            127
          },
          [r18_130] = {
            155,
            0,
            0,
            1
          },
          rain = 0.8,
        },
        [r16_130] = {
          [r18_130] = {
            20,
            30,
            30
          },
          [r18_130] = {
            135,
            173,
            197
          },
          [r18_130] = {
            255,
            255,
            255
          },
          [r18_130] = {
            10,
            10,
            10,
            20,
            20,
            20
          },
          [r18_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            3.4
          },
          [r18_130] = {
            0.4,
            0.9
          },
          [r18_130] = {
            200,
            100,
            0
          },
          far = 650,
          fog = 5,
          ground = 0.9,
          [r18_130] = {
            100,
            34,
            25,
            0,
            0,
            0
          },
          [r18_130] = {
            62,
            72,
            77,
            240
          },
          [r18_130] = {
            124,
            124,
            124,
            127
          },
          [r18_130] = {
            0,
            48,
            20,
            127
          },
          [r18_130] = {
            155,
            0,
            100,
            1
          },
          rain = 0.8,
        },
        [r16_130] = {
          [r18_130] = {
            20,
            30,
            30
          },
          [r18_130] = {
            135,
            173,
            197
          },
          [r18_130] = {
            255,
            255,
            255
          },
          [r18_130] = {
            40,
            40,
            40,
            50,
            50,
            50
          },
          [r18_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            2.5
          },
          [r18_130] = {
            0.4,
            0.7
          },
          [r18_130] = {
            80,
            80,
            0
          },
          far = 650,
          fog = 5,
          ground = 0.8,
          [r18_130] = {
            120,
            40,
            40,
            0,
            0,
            0
          },
          [r18_130] = {
            107,
            117,
            122,
            240
          },
          [r18_130] = {
            124,
            124,
            124,
            127
          },
          [r18_130] = {
            0,
            48,
            20,
            127
          },
          [r18_130] = {
            155,
            0,
            0,
            1
          },
          rain = 0.6,
        },
        [r16_130] = {
          [r18_130] = {
            20,
            30,
            30
          },
          [r18_130] = {
            186,
            186,
            186
          },
          [r18_130] = {
            255,
            255,
            255
          },
          [r18_130] = {
            80,
            80,
            80,
            70,
            70,
            70
          },
          [r18_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            1
          },
          [r18_130] = {
            0.1,
            0.5
          },
          [r18_130] = {
            80,
            50,
            120
          },
          far = 650,
          fog = 5,
          ground = 0.7,
          [r18_130] = {
            120,
            100,
            100,
            0,
            0,
            0
          },
          [r18_130] = {
            141,
            141,
            140,
            240
          },
          [r18_130] = {
            124,
            124,
            124,
            127
          },
          [r18_130] = {
            30,
            38,
            30,
            127
          },
          [r18_130] = {
            155,
            0,
            0,
            1
          },
          rain = 0.7,
        },
        [r16_130] = {
          [r18_130] = {
            20,
            30,
            30
          },
          [r18_130] = {
            135,
            173,
            193
          },
          [r18_130] = {
            255,
            255,
            255
          },
          [r18_130] = {
            80,
            80,
            80,
            70,
            70,
            70
          },
          [r18_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            3.5
          },
          [r18_130] = {
            0.5,
            1
          },
          [r18_130] = {
            80,
            50,
            0
          },
          far = 650,
          fog = 5,
          ground = 0.9,
          [r18_130] = {
            120,
            40,
            40,
            0,
            0,
            0
          },
          [r18_130] = {
            116,
            135,
            144,
            240
          },
          [r18_130] = {
            124,
            124,
            124,
            127
          },
          [r18_130] = {
            10,
            46,
            22,
            127
          },
          [r18_130] = {
            155,
            0,
            0,
            1
          },
          rain = 0.8,
        },
        [r16_130] = {
          [r18_130] = {
            20,
            30,
            30
          },
          [r18_130] = {
            167,
            198,
            223
          },
          [r18_130] = {
            255,
            255,
            255
          },
          [r18_130] = {
            40,
            40,
            40,
            70,
            70,
            70
          },
          [r18_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            2
          },
          [r18_130] = {
            1,
            1
          },
          [r18_130] = {
            80,
            80,
            0
          },
          far = 650,
          fog = 5,
          ground = 1,
          [r18_130] = {
            120,
            40,
            40,
            0,
            0,
            0
          },
          [r18_130] = {
            132,
            176,
            189,
            240
          },
          [r18_130] = {
            124,
            124,
            124,
            127
          },
          [r18_130] = {
            0,
            48,
            20,
            127
          },
          [r18_130] = {
            155,
            0,
            0,
            1
          },
          rain = 0.8,
        },
        [r16_130] = {
          [r18_130] = {
            20,
            30,
            30
          },
          [r18_130] = {
            167,
            198,
            223
          },
          [r18_130] = {
            255,
            255,
            255
          },
          [r18_130] = {
            40,
            40,
            40,
            50,
            50,
            50
          },
          [r18_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            1
          },
          [r18_130] = {
            1,
            1
          },
          [r18_130] = {
            200,
            100,
            0
          },
          far = 650,
          fog = 5,
          ground = 1,
          [r18_130] = {
            70,
            27,
            10,
            0,
            0,
            0
          },
          [r18_130] = {
            161,
            176,
            189,
            240
          },
          [r18_130] = {
            124,
            124,
            124,
            127
          },
          [r18_130] = {
            0,
            48,
            20,
            127
          },
          [r18_130] = {
            155,
            0,
            0,
            1
          },
          rain = 0.8,
        },
      },
    },
    {
      name = "Foggy SF",
      [r15_130] = {
        [r17_130] = {
          [r19_130] = {
            33,
            33,
            33
          },
          [r19_130] = {
            141,
            141,
            141
          },
          [r19_130] = {
            255,
            255,
            255
          },
          [r19_130] = {
            0,
            40,
            40,
            0,
            40,
            40
          },
          [r19_130] = {
            10,
            10,
            0,
            10,
            0,
            0,
            1
          },
          [r19_130] = {
            0.7,
            1
          },
          [r19_130] = {
            60,
            50,
            0
          },
          far = 150,
          fog = -200,
          ground = 1,
          [r19_130] = {
            30,
            20,
            0,
            0,
            0,
            0
          },
          [r19_130] = {
            120,
            120,
            125,
            240
          },
          [r19_130] = {
            124,
            124,
            124,
            127
          },
          [r19_130] = {
            30,
            30,
            32,
            127
          },
          [r19_130] = {
            0,
            120,
            0,
            1
          },
        },
        [r17_130] = {
          [r19_130] = {
            33,
            33,
            33
          },
          [r19_130] = {
            210,
            141,
            141
          },
          [r19_130] = {
            255,
            255,
            255
          },
          [r19_130] = {
            0,
            45,
            45,
            0,
            45,
            45
          },
          [r19_130] = {
            10,
            10,
            0,
            10,
            0,
            0,
            0
          },
          [r19_130] = {
            0.7,
            1
          },
          [r19_130] = {
            60,
            50,
            0
          },
          far = 150,
          fog = -200,
          ground = 1,
          [r19_130] = {
            70,
            27,
            10,
            0,
            0,
            0
          },
          [r19_130] = {
            120,
            120,
            125,
            240
          },
          [r19_130] = {
            124,
            124,
            124,
            127
          },
          [r19_130] = {
            30,
            30,
            32,
            127
          },
          [r19_130] = {
            0,
            120,
            0,
            1
          },
        },
        [r17_130] = {
          [r19_130] = {
            33,
            33,
            33
          },
          [r19_130] = {
            141,
            141,
            141
          },
          [r19_130] = {
            255,
            255,
            255
          },
          [r19_130] = {
            0,
            45,
            45,
            0,
            45,
            45
          },
          [r19_130] = {
            0,
            10,
            0,
            10,
            0,
            0,
            3.4
          },
          [r19_130] = {
            0.7,
            0.9
          },
          [r19_130] = {
            60,
            50,
            0
          },
          far = 150,
          fog = -200,
          ground = 0.8,
          [r19_130] = {
            100,
            34,
            25,
            0,
            0,
            0
          },
          [r19_130] = {
            128,
            128,
            125,
            240
          },
          [r19_130] = {
            124,
            124,
            124,
            127
          },
          [r19_130] = {
            30,
            30,
            32,
            127
          },
          [r19_130] = {
            0,
            120,
            100,
            1
          },
        },
        [r17_130] = {
          [r19_130] = {
            33,
            33,
            33
          },
          [r19_130] = {
            141,
            141,
            141
          },
          [r19_130] = {
            255,
            255,
            255
          },
          [r19_130] = {
            40,
            50,
            50,
            40,
            50,
            50
          },
          [r19_130] = {
            10,
            10,
            0,
            10,
            0,
            0,
            2.5
          },
          [r19_130] = {
            0.7,
            0.7
          },
          [r19_130] = {
            60,
            50,
            0
          },
          far = 150,
          fog = -200,
          ground = 0.6,
          [r19_130] = {
            120,
            40,
            40,
            0,
            0,
            0
          },
          [r19_130] = {
            128,
            128,
            125,
            240
          },
          [r19_130] = {
            124,
            124,
            124,
            127
          },
          [r19_130] = {
            30,
            30,
            32,
            127
          },
          [r19_130] = {
            0,
            120,
            0,
            1
          },
        },
        [r17_130] = {
          [r19_130] = {
            13,
            13,
            13
          },
          [r19_130] = {
            141,
            141,
            141
          },
          [r19_130] = {
            255,
            255,
            255
          },
          [r19_130] = {
            146,
            155,
            155,
            127,
            144,
            144
          },
          [r19_130] = {
            10,
            10,
            0,
            10,
            0,
            0,
            1
          },
          [r19_130] = {
            0.3,
            0.5
          },
          [r19_130] = {
            60,
            50,
            60
          },
          far = 250,
          fog = -30,
          ground = 0.3,
          [r19_130] = {
            120,
            100,
            100,
            0,
            0,
            0
          },
          [r19_130] = {
            128,
            128,
            128,
            240
          },
          [r19_130] = {
            124,
            124,
            124,
            127
          },
          [r19_130] = {
            30,
            30,
            32,
            127
          },
          [r19_130] = {
            0,
            120,
            0,
            1
          },
        },
        [r17_130] = {
          [r19_130] = {
            13,
            13,
            13
          },
          [r19_130] = {
            141,
            141,
            141
          },
          [r19_130] = {
            255,
            255,
            255
          },
          [r19_130] = {
            100,
            100,
            105,
            100,
            100,
            105
          },
          [r19_130] = {
            10,
            10,
            0,
            10,
            0,
            0,
            3.5
          },
          [r19_130] = {
            0.3,
            1
          },
          [r19_130] = {
            60,
            50,
            0
          },
          far = 150,
          fog = -70,
          ground = 0.8,
          [r19_130] = {
            120,
            40,
            40,
            0,
            0,
            0
          },
          [r19_130] = {
            123,
            123,
            124,
            240
          },
          [r19_130] = {
            124,
            124,
            124,
            127
          },
          [r19_130] = {
            30,
            30,
            32,
            127
          },
          [r19_130] = {
            0,
            111,
            0,
            1
          },
        },
        [r17_130] = {
          [r19_130] = {
            13,
            13,
            13
          },
          [r19_130] = {
            141,
            141,
            141
          },
          [r19_130] = {
            255,
            255,
            255
          },
          [r19_130] = {
            41,
            60,
            60,
            35,
            53,
            50
          },
          [r19_130] = {
            10,
            10,
            0,
            10,
            0,
            0,
            2
          },
          [r19_130] = {
            1,
            1
          },
          [r19_130] = {
            60,
            50,
            0
          },
          far = 150,
          fog = -80,
          ground = 1,
          [r19_130] = {
            120,
            40,
            40,
            0,
            0,
            0
          },
          [r19_130] = {
            122,
            121,
            124,
            240
          },
          [r19_130] = {
            124,
            124,
            124,
            127
          },
          [r19_130] = {
            30,
            30,
            32,
            127
          },
          [r19_130] = {
            0,
            120,
            0,
            1
          },
        },
        [r17_130] = {
          [r19_130] = {
            33,
            33,
            33
          },
          [r19_130] = {
            141,
            141,
            141
          },
          [r19_130] = {
            255,
            255,
            255
          },
          [r19_130] = {
            0,
            40,
            40,
            0,
            40,
            40
          },
          [r19_130] = {
            10,
            10,
            0,
            10,
            0,
            0,
            1
          },
          [r19_130] = {
            0.7,
            1
          },
          [r19_130] = {
            60,
            50,
            0
          },
          far = 150,
          fog = -100,
          ground = 1,
          [r19_130] = {
            70,
            27,
            10,
            0,
            0,
            0
          },
          [r19_130] = {
            123,
            124,
            120,
            240
          },
          [r19_130] = {
            124,
            124,
            124,
            127
          },
          [r19_130] = {
            30,
            30,
            32,
            127
          },
          [r19_130] = {
            0,
            120,
            0,
            1
          },
        },
      },
    },
    {
      name = "Sunny Vegas",
      [r16_130] = {
        [r18_130] = {
          [r20_130] = {
            25,
            22,
            22
          },
          [r20_130] = {
            144,
            137,
            137
          },
          [r20_130] = {
            255,
            255,
            255
          },
          [r20_130] = {
            16,
            7,
            23,
            24,
            0,
            37
          },
          [r20_130] = {
            255,
            255,
            0,
            5,
            0,
            0,
            1
          },
          [r20_130] = {
            0.8,
            0.3
          },
          [r20_130] = {
            200,
            100,
            0
          },
          far = 1000,
          fog = 100,
          ground = 1,
          [r20_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r20_130] = {
            38,
            38,
            55,
            240
          },
          [r20_130] = {
            64,
            64,
            64,
            127
          },
          [r20_130] = {
            88,
            27,
            0,
            127
          },
          [r20_130] = {
            122,
            0,
            0,
            1
          },
        },
        [r18_130] = {
          [r20_130] = {
            24,
            16,
            25
          },
          [r20_130] = {
            138,
            138,
            138
          },
          [r20_130] = {
            255,
            255,
            255
          },
          [r20_130] = {
            20,
            4,
            19,
            31,
            11,
            27
          },
          [r20_130] = {
            255,
            128,
            0,
            255,
            0,
            0,
            0
          },
          [r20_130] = {
            0.8,
            0.3
          },
          [r20_130] = {
            150,
            100,
            0
          },
          far = 1000,
          fog = 100,
          ground = 1,
          [r20_130] = {
            70,
            27,
            10,
            50,
            43,
            36
          },
          [r20_130] = {
            53,
            62,
            68,
            240
          },
          [r20_130] = {
            64,
            64,
            152,
            127
          },
          [r20_130] = {
            79,
            27,
            0,
            127
          },
          [r20_130] = {
            122,
            0,
            0,
            1
          },
        },
        [r18_130] = {
          [r20_130] = {
            0,
            5,
            10
          },
          [r20_130] = {
            188,
            188,
            188
          },
          [r20_130] = {
            255,
            255,
            255
          },
          [r20_130] = {
            90,
            205,
            255,
            200,
            144,
            85
          },
          [r20_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            8.4
          },
          [r20_130] = {
            0.1,
            0.4
          },
          [r20_130] = {
            140,
            100,
            0
          },
          far = 1000,
          fog = 100,
          ground = 0.8,
          [r20_130] = {
            100,
            34,
            25,
            120,
            92,
            88
          },
          [r20_130] = {
            185,
            160,
            160,
            240
          },
          [r20_130] = {
            64,
            64,
            64,
            127
          },
          [r20_130] = {
            77,
            66,
            0,
            127
          },
          [r20_130] = {
            122,
            0,
            0,
            1
          },
        },
        [r18_130] = {
          [r20_130] = {
            13,
            13,
            1
          },
          [r20_130] = {
            188,
            188,
            188
          },
          [r20_130] = {
            255,
            255,
            255
          },
          [r20_130] = {
            90,
            205,
            255,
            90,
            200,
            255
          },
          [r20_130] = {
            255,
            128,
            0,
            255,
            0,
            0,
            3.3
          },
          [r20_130] = {
            0.1,
            0.2
          },
          [r20_130] = {
            100,
            50,
            0
          },
          far = 1000,
          fog = 100,
          ground = 0.5,
          [r20_130] = {
            120,
            40,
            40,
            159,
            142,
            106
          },
          [r20_130] = {
            145,
            170,
            170,
            240
          },
          [r20_130] = {
            64,
            64,
            64,
            127
          },
          [r20_130] = {
            64,
            64,
            22,
            127
          },
          [r20_130] = {
            122,
            0,
            0,
            1
          },
        },
        [r18_130] = {
          [r20_130] = {
            13,
            13,
            1
          },
          [r20_130] = {
            188,
            188,
            188
          },
          [r20_130] = {
            255,
            255,
            255
          },
          [r20_130] = {
            90,
            180,
            255,
            90,
            200,
            255
          },
          [r20_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            2.5
          },
          [r20_130] = {
            0.3,
            0.1
          },
          [r20_130] = {
            150,
            0,
            150
          },
          far = 1000,
          fog = 10,
          ground = 1,
          [r20_130] = {
            120,
            100,
            100,
            180,
            255,
            255
          },
          [r20_130] = {
            90,
            170,
            170,
            240
          },
          [r20_130] = {
            64,
            64,
            64,
            127
          },
          [r20_130] = {
            128,
            111,
            44,
            127
          },
          [r20_130] = {
            122,
            88,
            0,
            1
          },
        },
        [r18_130] = {
          [r20_130] = {
            1,
            1,
            1
          },
          [r20_130] = {
            163,
            159,
            163
          },
          [r20_130] = {
            255,
            255,
            255
          },
          [r20_130] = {
            109,
            142,
            157,
            90,
            200,
            255
          },
          [r20_130] = {
            255,
            255,
            255,
            255,
            255,
            255,
            3.5
          },
          [r20_130] = {
            1,
            0.2
          },
          [r20_130] = {
            110,
            40,
            0
          },
          far = 1000,
          fog = 10,
          ground = 0.8,
          [r20_130] = {
            120,
            40,
            40,
            200,
            123,
            96
          },
          [r20_130] = {
            153,
            95,
            87,
            240
          },
          [r20_130] = {
            64,
            64,
            64,
            127
          },
          [r20_130] = {
            122,
            27,
            0,
            127
          },
          [r20_130] = {
            122,
            0,
            0,
            1
          },
        },
        [r18_130] = {
          [r20_130] = {
            1,
            1,
            0
          },
          [r20_130] = {
            137,
            137,
            137
          },
          [r20_130] = {
            255,
            255,
            255
          },
          [r20_130] = {
            181,
            150,
            84,
            136,
            110,
            74
          },
          [r20_130] = {
            255,
            128,
            0,
            155,
            0,
            0,
            2
          },
          [r20_130] = {
            1,
            0.2
          },
          [r20_130] = {
            100,
            60,
            0
          },
          far = 1000,
          fog = 10,
          ground = 1,
          [r20_130] = {
            120,
            40,
            40,
            0,
            0,
            0
          },
          [r20_130] = {
            67,
            67,
            67,
            240
          },
          [r20_130] = {
            127,
            93,
            71,
            127
          },
          [r20_130] = {
            83,
            11,
            0,
            127
          },
          [r20_130] = {
            122,
            0,
            0,
            1
          },
        },
        [r18_130] = {
          [r20_130] = {
            12,
            6,
            12
          },
          [r20_130] = {
            138,
            138,
            138
          },
          [r20_130] = {
            255,
            255,
            255
          },
          [r20_130] = {
            31,
            15,
            44,
            39,
            24,
            64
          },
          [r20_130] = {
            255,
            5,
            8,
            5,
            8,
            0,
            1
          },
          [r20_130] = {
            0.6,
            0.3
          },
          [r20_130] = {
            160,
            100,
            0
          },
          far = 1000,
          fog = 10,
          ground = 1,
          [r20_130] = {
            70,
            27,
            10,
            0,
            0,
            0
          },
          [r20_130] = {
            67,
            67,
            62,
            240
          },
          [r20_130] = {
            124,
            124,
            124,
            127
          },
          [r20_130] = {
            34,
            27,
            0,
            127
          },
          [r20_130] = {
            122,
            0,
            0,
            1
          },
        },
      },
    },
    {
      name = "Extra Sunny Vegas",
      [r17_130] = {
        [r19_130] = {
          [r21_130] = {
            22,
            22,
            22
          },
          [r21_130] = {
            163,
            163,
            163
          },
          [r21_130] = {
            255,
            255,
            255
          },
          [r21_130] = {
            9,
            6,
            9,
            18,
            15,
            44
          },
          [r21_130] = {
            255,
            255,
            0,
            5,
            0,
            0,
            1
          },
          [r21_130] = {
            0.7,
            0.3
          },
          [r21_130] = {
            200,
            100,
            0
          },
          far = 1000,
          fog = 200,
          ground = 1,
          [r21_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r21_130] = {
            38,
            38,
            55,
            240
          },
          [r21_130] = {
            77,
            77,
            77,
            127
          },
          [r21_130] = {
            88,
            66,
            41,
            127
          },
          [r21_130] = {
            0,
            30,
            0,
            1
          },
        },
        [r19_130] = {
          [r21_130] = {
            12,
            12,
            12
          },
          [r21_130] = {
            163,
            163,
            163
          },
          [r21_130] = {
            255,
            255,
            255
          },
          [r21_130] = {
            0,
            5,
            10,
            16,
            1,
            30
          },
          [r21_130] = {
            255,
            128,
            0,
            255,
            0,
            0,
            0
          },
          [r21_130] = {
            0.5,
            0.4
          },
          [r21_130] = {
            150,
            100,
            0
          },
          far = 1000,
          fog = 200,
          ground = 1,
          [r21_130] = {
            70,
            27,
            10,
            50,
            43,
            36
          },
          [r21_130] = {
            53,
            62,
            68,
            240
          },
          [r21_130] = {
            124,
            106,
            116,
            127
          },
          [r21_130] = {
            52,
            27,
            0,
            127
          },
          [r21_130] = {
            0,
            90,
            0,
            1
          },
        },
        [r19_130] = {
          [r21_130] = {
            12,
            12,
            12
          },
          [r21_130] = {
            188,
            188,
            188
          },
          [r21_130] = {
            255,
            255,
            255
          },
          [r21_130] = {
            141,
            99,
            81,
            200,
            144,
            85
          },
          [r21_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            8.4
          },
          [r21_130] = {
            0.1,
            1
          },
          [r21_130] = {
            140,
            100,
            0
          },
          far = 1000,
          fog = 0,
          ground = 0.8,
          [r21_130] = {
            100,
            34,
            25,
            120,
            92,
            88
          },
          [r21_130] = {
            185,
            160,
            160,
            240
          },
          [r21_130] = {
            66,
            66,
            66,
            127
          },
          [r21_130] = {
            90,
            70,
            20,
            127
          },
          [r21_130] = {
            0,
            90,
            0,
            1
          },
        },
        [r19_130] = {
          [r21_130] = {
            13,
            4,
            0
          },
          [r21_130] = {
            188,
            188,
            188
          },
          [r21_130] = {
            255,
            255,
            255
          },
          [r21_130] = {
            90,
            205,
            255,
            200,
            144,
            90
          },
          [r21_130] = {
            255,
            128,
            0,
            255,
            0,
            0,
            3.7
          },
          [r21_130] = {
            0,
            1
          },
          [r21_130] = {
            100,
            50,
            0
          },
          far = 1000,
          fog = 0,
          ground = 0.5,
          [r21_130] = {
            120,
            40,
            40,
            159,
            142,
            106
          },
          [r21_130] = {
            145,
            170,
            170,
            240
          },
          [r21_130] = {
            124,
            60,
            60,
            60
          },
          [r21_130] = {
            89,
            91,
            44,
            127
          },
          [r21_130] = {
            0,
            90,
            0,
            1
          },
        },
        [r19_130] = {
          [r21_130] = {
            13,
            13,
            0
          },
          [r21_130] = {
            188,
            188,
            188
          },
          [r21_130] = {
            255,
            255,
            255
          },
          [r21_130] = {
            90,
            180,
            255,
            90,
            200,
            255
          },
          [r21_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            2.5
          },
          [r21_130] = {
            0,
            1
          },
          [r21_130] = {
            150,
            0,
            150
          },
          far = 1000,
          fog = 10,
          ground = 1,
          [r21_130] = {
            120,
            100,
            100,
            180,
            255,
            255
          },
          [r21_130] = {
            90,
            170,
            170,
            240
          },
          [r21_130] = {
            64,
            64,
            64,
            64
          },
          [r21_130] = {
            90,
            80,
            33,
            127
          },
          [r21_130] = {
            0,
            90,
            0,
            1
          },
        },
        [r19_130] = {
          [r21_130] = {
            13,
            13,
            0
          },
          [r21_130] = {
            163,
            163,
            163
          },
          [r21_130] = {
            255,
            255,
            255
          },
          [r21_130] = {
            90,
            180,
            255,
            90,
            200,
            255
          },
          [r21_130] = {
            255,
            47,
            0,
            255,
            0,
            0,
            2.5
          },
          [r21_130] = {
            0.4,
            0.3
          },
          [r21_130] = {
            110,
            40,
            0
          },
          far = 1000,
          fog = 10,
          ground = 0.8,
          [r21_130] = {
            120,
            40,
            40,
            200,
            123,
            96
          },
          [r21_130] = {
            143,
            121,
            87,
            240
          },
          [r21_130] = {
            64,
            64,
            64,
            127
          },
          [r21_130] = {
            114,
            57,
            27,
            127
          },
          [r21_130] = {
            0,
            90,
            0,
            1
          },
        },
        [r19_130] = {
          [r21_130] = {
            13,
            13,
            0
          },
          [r21_130] = {
            163,
            163,
            163
          },
          [r21_130] = {
            255,
            255,
            255
          },
          [r21_130] = {
            109,
            142,
            189,
            165,
            155,
            130
          },
          [r21_130] = {
            255,
            128,
            0,
            155,
            0,
            0,
            2
          },
          [r21_130] = {
            0.6,
            0.5
          },
          [r21_130] = {
            100,
            60,
            0
          },
          far = 1000,
          fog = 10,
          ground = 1,
          [r21_130] = {
            120,
            40,
            40,
            0,
            0,
            0
          },
          [r21_130] = {
            67,
            67,
            67,
            240
          },
          [r21_130] = {
            55,
            55,
            55,
            127
          },
          [r21_130] = {
            120,
            50,
            0,
            127
          },
          [r21_130] = {
            0,
            90,
            0,
            1
          },
        },
        [r19_130] = {
          [r21_130] = {
            22,
            22,
            23
          },
          [r21_130] = {
            163,
            163,
            163
          },
          [r21_130] = {
            255,
            255,
            255
          },
          [r21_130] = {
            0,
            0,
            0,
            18,
            15,
            44
          },
          [r21_130] = {
            255,
            5,
            8,
            5,
            8,
            0,
            1
          },
          [r21_130] = {
            0.7,
            0.5
          },
          [r21_130] = {
            160,
            100,
            0
          },
          far = 1000,
          fog = 200,
          ground = 1,
          [r21_130] = {
            70,
            27,
            10,
            0,
            0,
            0
          },
          [r21_130] = {
            71,
            46,
            53,
            240
          },
          [r21_130] = {
            77,
            77,
            77,
            127
          },
          [r21_130] = {
            122,
            55,
            33,
            127
          },
          [r21_130] = {
            0,
            30,
            0,
            1
          },
        },
      },
    },
    {
      name = "Cloudy Vegas",
      [r18_130] = {
        [r20_130] = {
          [r22_130] = {
            2,
            20,
            33
          },
          [r22_130] = {
            163,
            163,
            163
          },
          [r22_130] = {
            255,
            255,
            255
          },
          [r22_130] = {
            22,
            33,
            44,
            11,
            23,
            44
          },
          [r22_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            0
          },
          [r22_130] = {
            1,
            1
          },
          [r22_130] = {
            200,
            100,
            0
          },
          far = 1000,
          fog = 100,
          ground = 1,
          [r22_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r22_130] = {
            38,
            38,
            55,
            240
          },
          [r22_130] = {
            66,
            124,
            124,
            127
          },
          [r22_130] = {
            34,
            27,
            0,
            127
          },
          [r22_130] = {
            44,
            0,
            0,
            1
          },
        },
        [r20_130] = {
          [r22_130] = {
            11,
            22,
            33
          },
          [r22_130] = {
            163,
            163,
            163
          },
          [r22_130] = {
            255,
            255,
            255
          },
          [r22_130] = {
            22,
            33,
            44,
            22,
            33,
            44
          },
          [r22_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            0
          },
          [r22_130] = {
            1,
            1
          },
          [r22_130] = {
            150,
            100,
            0
          },
          far = 1000,
          fog = 100,
          ground = 1,
          [r22_130] = {
            70,
            27,
            10,
            50,
            43,
            36
          },
          [r22_130] = {
            53,
            62,
            68,
            240
          },
          [r22_130] = {
            66,
            124,
            124,
            127
          },
          [r22_130] = {
            34,
            27,
            0,
            127
          },
          [r22_130] = {
            44,
            0,
            0,
            1
          },
        },
        [r20_130] = {
          [r22_130] = {
            22,
            22,
            33
          },
          [r22_130] = {
            188,
            188,
            187
          },
          [r22_130] = {
            255,
            255,
            255
          },
          [r22_130] = {
            84,
            83,
            88,
            77,
            77,
            77
          },
          [r22_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            0
          },
          [r22_130] = {
            0.9,
            1
          },
          [r22_130] = {
            140,
            100,
            0
          },
          far = 1000,
          fog = 100,
          ground = 0.8,
          [r22_130] = {
            100,
            34,
            25,
            120,
            92,
            88
          },
          [r22_130] = {
            185,
            160,
            160,
            240
          },
          [r22_130] = {
            64,
            124,
            124,
            127
          },
          [r22_130] = {
            34,
            27,
            0,
            127
          },
          [r22_130] = {
            122,
            0,
            0,
            1
          },
        },
        [r20_130] = {
          [r22_130] = {
            22,
            22,
            22
          },
          [r22_130] = {
            188,
            188,
            188
          },
          [r22_130] = {
            255,
            255,
            255
          },
          [r22_130] = {
            211,
            211,
            255,
            155,
            155,
            155
          },
          [r22_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            0
          },
          [r22_130] = {
            0.8,
            1
          },
          [r22_130] = {
            100,
            50,
            0
          },
          far = 1000,
          fog = 100,
          ground = 0.5,
          [r22_130] = {
            120,
            40,
            40,
            159,
            142,
            106
          },
          [r22_130] = {
            145,
            170,
            170,
            240
          },
          [r22_130] = {
            64,
            64,
            64,
            127
          },
          [r22_130] = {
            66,
            55,
            21,
            127
          },
          [r22_130] = {
            122,
            0,
            0,
            1
          },
        },
        [r20_130] = {
          [r22_130] = {
            22,
            22,
            22
          },
          [r22_130] = {
            188,
            188,
            188
          },
          [r22_130] = {
            255,
            255,
            255
          },
          [r22_130] = {
            144,
            144,
            144,
            122,
            122,
            122
          },
          [r22_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            0
          },
          [r22_130] = {
            0.3,
            1
          },
          [r22_130] = {
            150,
            0,
            150
          },
          far = 1000,
          fog = 10,
          ground = 1,
          [r22_130] = {
            120,
            100,
            100,
            88,
            88,
            88
          },
          [r22_130] = {
            90,
            170,
            170,
            240
          },
          [r22_130] = {
            124,
            124,
            124,
            127
          },
          [r22_130] = {
            66,
            55,
            21,
            127
          },
          [r22_130] = {
            122,
            0,
            0,
            1
          },
        },
        [r20_130] = {
          [r22_130] = {
            22,
            22,
            22
          },
          [r22_130] = {
            188,
            163,
            163
          },
          [r22_130] = {
            255,
            255,
            255
          },
          [r22_130] = {
            144,
            144,
            144,
            155,
            155,
            155
          },
          [r22_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            0
          },
          [r22_130] = {
            1,
            1
          },
          [r22_130] = {
            110,
            40,
            0
          },
          far = 1000,
          fog = 10,
          ground = 0.8,
          [r22_130] = {
            120,
            40,
            40,
            88,
            88,
            88
          },
          [r22_130] = {
            153,
            95,
            87,
            240
          },
          [r22_130] = {
            64,
            64,
            64,
            127
          },
          [r22_130] = {
            66,
            66,
            50,
            127
          },
          [r22_130] = {
            122,
            0,
            0,
            1
          },
        },
        [r20_130] = {
          [r22_130] = {
            2,
            2,
            13
          },
          [r22_130] = {
            163,
            163,
            163
          },
          [r22_130] = {
            255,
            255,
            255
          },
          [r22_130] = {
            88,
            88,
            88,
            88,
            88,
            88
          },
          [r22_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            0
          },
          [r22_130] = {
            1,
            1
          },
          [r22_130] = {
            100,
            60,
            0
          },
          far = 1000,
          fog = 10,
          ground = 1,
          [r22_130] = {
            120,
            52,
            79,
            88,
            88,
            88
          },
          [r22_130] = {
            67,
            67,
            67,
            240
          },
          [r22_130] = {
            124,
            124,
            124,
            127
          },
          [r22_130] = {
            34,
            27,
            0,
            127
          },
          [r22_130] = {
            122,
            0,
            0,
            1
          },
        },
        [r20_130] = {
          [r22_130] = {
            2,
            20,
            33
          },
          [r22_130] = {
            163,
            163,
            163
          },
          [r22_130] = {
            255,
            255,
            255
          },
          [r22_130] = {
            22,
            33,
            44,
            11,
            23,
            44
          },
          [r22_130] = {
            0,
            0,
            8,
            0,
            0,
            0,
            0
          },
          [r22_130] = {
            1,
            1
          },
          [r22_130] = {
            160,
            100,
            0
          },
          far = 1000,
          fog = 10,
          ground = 1,
          [r22_130] = {
            70,
            27,
            10,
            0,
            0,
            0
          },
          [r22_130] = {
            67,
            67,
            62,
            240
          },
          [r22_130] = {
            124,
            124,
            124,
            127
          },
          [r22_130] = {
            34,
            27,
            0,
            127
          },
          [r22_130] = {
            44,
            0,
            0,
            1
          },
        },
      },
    },
    {
      name = "Extra Sunny Countryside",
      [r19_130] = {
        [r21_130] = {
          [r23_130] = {
            33,
            33,
            12
          },
          [r23_130] = {
            163,
            163,
            163
          },
          [r23_130] = {
            255,
            255,
            255
          },
          [r23_130] = {
            0,
            30,
            30,
            10,
            22,
            35
          },
          [r23_130] = {
            255,
            255,
            0,
            5,
            0,
            0,
            1
          },
          [r23_130] = {
            1,
            0.5
          },
          [r23_130] = {
            200,
            100,
            0
          },
          far = 1500,
          fog = 100,
          ground = 1,
          [r23_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r23_130] = {
            53,
            62,
            68,
            240
          },
          [r23_130] = {
            89,
            97,
            80,
            127
          },
          [r23_130] = {
            17,
            86,
            109,
            127
          },
          [r23_130] = {
            44,
            120,
            0,
            1
          },
        },
        [r21_130] = {
          [r23_130] = {
            22,
            25,
            25
          },
          [r23_130] = {
            163,
            163,
            163
          },
          [r23_130] = {
            255,
            255,
            255
          },
          [r23_130] = {
            0,
            30,
            30,
            10,
            22,
            35
          },
          [r23_130] = {
            255,
            128,
            0,
            255,
            0,
            0,
            0
          },
          [r23_130] = {
            1,
            0.4
          },
          [r23_130] = {
            150,
            100,
            0
          },
          far = 1500,
          fog = 100,
          ground = 1,
          [r23_130] = {
            23,
            30,
            20,
            50,
            43,
            36
          },
          [r23_130] = {
            53,
            62,
            68,
            240
          },
          [r23_130] = {
            103,
            107,
            80,
            127
          },
          [r23_130] = {
            10,
            90,
            100,
            127
          },
          [r23_130] = {
            88,
            120,
            0,
            1
          },
        },
        [r21_130] = {
          [r23_130] = {
            23,
            23,
            23
          },
          [r23_130] = {
            188,
            188,
            188
          },
          [r23_130] = {
            255,
            255,
            255
          },
          [r23_130] = {
            90,
            145,
            227,
            200,
            144,
            85
          },
          [r23_130] = {
            255,
            128,
            0,
            255,
            255,
            255,
            8.4
          },
          [r23_130] = {
            0.9,
            0.3
          },
          [r23_130] = {
            140,
            100,
            0
          },
          far = 1500,
          fog = 100,
          ground = 0.8,
          [r23_130] = {
            100,
            34,
            25,
            120,
            92,
            88
          },
          [r23_130] = {
            185,
            160,
            160,
            240
          },
          [r23_130] = {
            124,
            124,
            69,
            127
          },
          [r23_130] = {
            91,
            9,
            0,
            127
          },
          [r23_130] = {
            75,
            120,
            0,
            1
          },
        },
        [r21_130] = {
          [r23_130] = {
            22,
            24,
            22
          },
          [r23_130] = {
            188,
            188,
            188
          },
          [r23_130] = {
            255,
            255,
            255
          },
          [r23_130] = {
            90,
            205,
            255,
            187,
            146,
            116
          },
          [r23_130] = {
            255,
            128,
            0,
            255,
            255,
            255,
            3.3
          },
          [r23_130] = {
            0.3,
            0.4
          },
          [r23_130] = {
            100,
            50,
            0
          },
          far = 1500,
          fog = 5,
          ground = 0.5,
          [r23_130] = {
            120,
            40,
            40,
            159,
            142,
            106
          },
          [r23_130] = {
            145,
            170,
            170,
            240
          },
          [r23_130] = {
            62,
            64,
            44,
            127
          },
          [r23_130] = {
            80,
            36,
            22,
            127
          },
          [r23_130] = {
            81,
            120,
            0,
            1
          },
        },
        [r21_130] = {
          [r23_130] = {
            22,
            5,
            5
          },
          [r23_130] = {
            203,
            188,
            188
          },
          [r23_130] = {
            255,
            255,
            255
          },
          [r23_130] = {
            90,
            180,
            255,
            57,
            165,
            255
          },
          [r23_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            2.5
          },
          [r23_130] = {
            0.1,
            1
          },
          [r23_130] = {
            150,
            0,
            150
          },
          far = 1500,
          fog = 65,
          ground = 1,
          [r23_130] = {
            120,
            100,
            100,
            180,
            255,
            255
          },
          [r23_130] = {
            90,
            170,
            170,
            240
          },
          [r23_130] = {
            60,
            60,
            46,
            127
          },
          [r23_130] = {
            86,
            84,
            52,
            127
          },
          [r23_130] = {
            105,
            120,
            0,
            1
          },
        },
        [r21_130] = {
          [r23_130] = {
            22,
            22,
            22
          },
          [r23_130] = {
            163,
            163,
            163
          },
          [r23_130] = {
            255,
            255,
            255
          },
          [r23_130] = {
            109,
            142,
            157,
            165,
            155,
            130
          },
          [r23_130] = {
            255,
            25,
            0,
            255,
            255,
            255,
            7.5
          },
          [r23_130] = {
            0.6,
            0.5
          },
          [r23_130] = {
            110,
            40,
            0
          },
          far = 1500,
          fog = 5,
          ground = 0.8,
          [r23_130] = {
            120,
            40,
            40,
            200,
            123,
            96
          },
          [r23_130] = {
            148,
            134,
            97,
            240
          },
          [r23_130] = {
            66,
            66,
            46,
            127
          },
          [r23_130] = {
            80,
            72,
            32,
            127
          },
          [r23_130] = {
            99,
            120,
            0,
            1
          },
        },
        [r21_130] = {
          [r23_130] = {
            5,
            5,
            0
          },
          [r23_130] = {
            163,
            163,
            163
          },
          [r23_130] = {
            255,
            255,
            255
          },
          [r23_130] = {
            109,
            142,
            189,
            165,
            155,
            130
          },
          [r23_130] = {
            255,
            128,
            0,
            155,
            0,
            0,
            2
          },
          [r23_130] = {
            0.4,
            0.4
          },
          [r23_130] = {
            100,
            60,
            0
          },
          far = 1500,
          fog = 10,
          ground = 1,
          [r23_130] = {
            120,
            40,
            40,
            0,
            0,
            0
          },
          [r23_130] = {
            67,
            67,
            67,
            240
          },
          [r23_130] = {
            118,
            89,
            48,
            127
          },
          [r23_130] = {
            69,
            28,
            6,
            127
          },
          [r23_130] = {
            62,
            120,
            0,
            1
          },
        },
        [r21_130] = {
          [r23_130] = {
            22,
            22,
            12
          },
          [r23_130] = {
            163,
            163,
            163
          },
          [r23_130] = {
            255,
            255,
            255
          },
          [r23_130] = {
            20,
            15,
            45,
            66,
            66,
            64
          },
          [r23_130] = {
            255,
            5,
            8,
            5,
            8,
            0,
            1
          },
          [r23_130] = {
            0.6,
            0.3
          },
          [r23_130] = {
            160,
            100,
            0
          },
          far = 1500,
          fog = 10,
          ground = 1,
          [r23_130] = {
            70,
            27,
            10,
            0,
            0,
            0
          },
          [r23_130] = {
            67,
            67,
            62,
            240
          },
          [r23_130] = {
            62,
            62,
            124,
            62
          },
          [r23_130] = {
            132,
            80,
            40,
            127
          },
          [r23_130] = {
            44,
            120,
            0,
            1
          },
        },
      },
    },
    {
      name = "Sunny Countryside",
      [r20_130] = {
        [r22_130] = {
          [r24_130] = {
            33,
            33,
            33
          },
          [r24_130] = {
            163,
            163,
            163
          },
          [r24_130] = {
            255,
            255,
            255
          },
          [r24_130] = {
            10,
            22,
            35,
            10,
            22,
            35
          },
          [r24_130] = {
            255,
            255,
            0,
            5,
            0,
            0,
            1
          },
          [r24_130] = {
            1,
            0.5
          },
          [r24_130] = {
            200,
            100,
            0
          },
          far = 1500,
          fog = 100,
          ground = 1,
          [r24_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r24_130] = {
            53,
            62,
            68,
            240
          },
          [r24_130] = {
            89,
            97,
            80,
            127
          },
          [r24_130] = {
            17,
            86,
            109,
            127
          },
          [r24_130] = {
            44,
            120,
            0,
            1
          },
        },
        [r22_130] = {
          [r24_130] = {
            22,
            25,
            25
          },
          [r24_130] = {
            163,
            163,
            163
          },
          [r24_130] = {
            255,
            255,
            255
          },
          [r24_130] = {
            10,
            22,
            35,
            10,
            22,
            35
          },
          [r24_130] = {
            255,
            128,
            0,
            255,
            0,
            0,
            0
          },
          [r24_130] = {
            1,
            0.4
          },
          [r24_130] = {
            150,
            100,
            0
          },
          far = 1500,
          fog = 100,
          ground = 1,
          [r24_130] = {
            23,
            30,
            20,
            50,
            43,
            36
          },
          [r24_130] = {
            53,
            62,
            68,
            240
          },
          [r24_130] = {
            103,
            107,
            80,
            127
          },
          [r24_130] = {
            10,
            90,
            100,
            127
          },
          [r24_130] = {
            88,
            120,
            0,
            1
          },
        },
        [r22_130] = {
          [r24_130] = {
            23,
            23,
            23
          },
          [r24_130] = {
            188,
            188,
            188
          },
          [r24_130] = {
            255,
            255,
            255
          },
          [r24_130] = {
            90,
            145,
            227,
            200,
            144,
            85
          },
          [r24_130] = {
            255,
            255,
            255,
            122,
            122,
            0,
            8.4
          },
          [r24_130] = {
            0.9,
            0.3
          },
          [r24_130] = {
            140,
            100,
            0
          },
          far = 1500,
          fog = 100,
          ground = 0.8,
          [r24_130] = {
            100,
            34,
            25,
            120,
            92,
            88
          },
          [r24_130] = {
            185,
            160,
            160,
            240
          },
          [r24_130] = {
            124,
            124,
            69,
            127
          },
          [r24_130] = {
            91,
            9,
            0,
            127
          },
          [r24_130] = {
            75,
            120,
            0,
            1
          },
        },
        [r22_130] = {
          [r24_130] = {
            5,
            5,
            5
          },
          [r24_130] = {
            188,
            188,
            188
          },
          [r24_130] = {
            255,
            255,
            255
          },
          [r24_130] = {
            90,
            205,
            255,
            187,
            146,
            116
          },
          [r24_130] = {
            255,
            255,
            255,
            122,
            122,
            0,
            3.3
          },
          [r24_130] = {
            0.3,
            0.4
          },
          [r24_130] = {
            100,
            50,
            0
          },
          far = 1500,
          fog = 5,
          ground = 0.5,
          [r24_130] = {
            120,
            40,
            40,
            159,
            142,
            106
          },
          [r24_130] = {
            145,
            170,
            170,
            240
          },
          [r24_130] = {
            62,
            64,
            44,
            127
          },
          [r24_130] = {
            80,
            36,
            22,
            127
          },
          [r24_130] = {
            81,
            120,
            0,
            1
          },
        },
        [r22_130] = {
          [r24_130] = {
            22,
            22,
            5
          },
          [r24_130] = {
            188,
            188,
            188
          },
          [r24_130] = {
            255,
            255,
            255
          },
          [r24_130] = {
            90,
            180,
            255,
            57,
            165,
            255
          },
          [r24_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            2.5
          },
          [r24_130] = {
            0.1,
            1
          },
          [r24_130] = {
            150,
            0,
            150
          },
          far = 1500,
          fog = 65,
          ground = 1,
          [r24_130] = {
            120,
            100,
            100,
            180,
            255,
            255
          },
          [r24_130] = {
            90,
            170,
            170,
            240
          },
          [r24_130] = {
            60,
            60,
            46,
            127
          },
          [r24_130] = {
            86,
            84,
            52,
            127
          },
          [r24_130] = {
            105,
            120,
            0,
            1
          },
        },
        [r22_130] = {
          [r24_130] = {
            22,
            22,
            5
          },
          [r24_130] = {
            163,
            163,
            163
          },
          [r24_130] = {
            255,
            255,
            255
          },
          [r24_130] = {
            109,
            142,
            157,
            165,
            155,
            130
          },
          [r24_130] = {
            255,
            128,
            0,
            255,
            0,
            0,
            7.5
          },
          [r24_130] = {
            0.6,
            0.5
          },
          [r24_130] = {
            110,
            40,
            0
          },
          far = 1500,
          fog = 5,
          ground = 0.8,
          [r24_130] = {
            120,
            40,
            40,
            152,
            123,
            96
          },
          [r24_130] = {
            148,
            134,
            97,
            240
          },
          [r24_130] = {
            66,
            66,
            46,
            127
          },
          [r24_130] = {
            80,
            72,
            32,
            127
          },
          [r24_130] = {
            99,
            120,
            0,
            1
          },
        },
        [r22_130] = {
          [r24_130] = {
            21,
            21,
            21
          },
          [r24_130] = {
            163,
            163,
            163
          },
          [r24_130] = {
            255,
            255,
            255
          },
          [r24_130] = {
            109,
            142,
            189,
            165,
            155,
            130
          },
          [r24_130] = {
            255,
            128,
            0,
            155,
            0,
            0,
            2
          },
          [r24_130] = {
            0.4,
            0.4
          },
          [r24_130] = {
            100,
            60,
            0
          },
          far = 1500,
          fog = 10,
          ground = 1,
          [r24_130] = {
            120,
            40,
            40,
            54,
            55,
            55
          },
          [r24_130] = {
            67,
            67,
            67,
            240
          },
          [r24_130] = {
            118,
            89,
            48,
            127
          },
          [r24_130] = {
            69,
            28,
            6,
            127
          },
          [r24_130] = {
            62,
            120,
            0,
            1
          },
        },
        [r22_130] = {
          [r24_130] = {
            33,
            33,
            33
          },
          [r24_130] = {
            163,
            163,
            163
          },
          [r24_130] = {
            255,
            255,
            255
          },
          [r24_130] = {
            20,
            15,
            45,
            66,
            66,
            64
          },
          [r24_130] = {
            255,
            5,
            8,
            5,
            8,
            0,
            1
          },
          [r24_130] = {
            0.6,
            0.3
          },
          [r24_130] = {
            160,
            100,
            0
          },
          far = 1500,
          fog = 10,
          ground = 1,
          [r24_130] = {
            70,
            27,
            10,
            0,
            0,
            0
          },
          [r24_130] = {
            67,
            67,
            62,
            240
          },
          [r24_130] = {
            62,
            62,
            124,
            62
          },
          [r24_130] = {
            132,
            80,
            40,
            127
          },
          [r24_130] = {
            44,
            120,
            0,
            1
          },
        },
      },
    },
    {
      name = "Cloudy Countryside",
      [r21_130] = {
        [r23_130] = {
          [r25_130] = {
            12,
            22,
            35
          },
          [r25_130] = {
            200,
            200,
            200
          },
          [r25_130] = {
            255,
            255,
            255
          },
          [r25_130] = {
            0,
            9,
            9,
            1,
            24,
            32
          },
          [r25_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            1
          },
          [r25_130] = {
            0.4,
            0.3
          },
          [r25_130] = {
            200,
            100,
            0
          },
          far = 1150,
          fog = -22,
          ground = 1,
          [r25_130] = {
            30,
            20,
            0,
            23,
            28,
            30
          },
          [r25_130] = {
            32,
            43,
            66,
            240
          },
          [r25_130] = {
            77,
            77,
            77,
            127
          },
          [r25_130] = {
            99,
            99,
            83,
            127
          },
          [r25_130] = {
            122,
            0,
            0,
            1
          },
        },
        [r23_130] = {
          [r25_130] = {
            3,
            18,
            33
          },
          [r25_130] = {
            190,
            176,
            169
          },
          [r25_130] = {
            255,
            255,
            255
          },
          [r25_130] = {
            0,
            9,
            9,
            1,
            24,
            32
          },
          [r25_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            1
          },
          [r25_130] = {
            0.5,
            0.3
          },
          [r25_130] = {
            200,
            100,
            0
          },
          far = 1150,
          fog = -22,
          ground = 1,
          [r25_130] = {
            70,
            27,
            10,
            23,
            28,
            30
          },
          [r25_130] = {
            26,
            58,
            66,
            240
          },
          [r25_130] = {
            124,
            124,
            124,
            127
          },
          [r25_130] = {
            48,
            48,
            48,
            127
          },
          [r25_130] = {
            122,
            0,
            0,
            1
          },
        },
        [r23_130] = {
          [r25_130] = {
            12,
            22,
            22
          },
          [r25_130] = {
            190,
            176,
            169
          },
          [r25_130] = {
            255,
            255,
            255
          },
          [r25_130] = {
            41,
            46,
            47,
            31,
            36,
            37
          },
          [r25_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            3.4
          },
          [r25_130] = {
            0.4,
            0.3
          },
          [r25_130] = {
            200,
            100,
            0
          },
          far = 1150,
          fog = -22,
          ground = 0.8,
          [r25_130] = {
            100,
            34,
            25,
            23,
            28,
            30
          },
          [r25_130] = {
            42,
            77,
            88,
            240
          },
          [r25_130] = {
            124,
            124,
            124,
            127
          },
          [r25_130] = {
            48,
            48,
            48,
            127
          },
          [r25_130] = {
            122,
            0,
            0,
            1
          },
        },
        [r23_130] = {
          [r25_130] = {
            12,
            22,
            21
          },
          [r25_130] = {
            190,
            176,
            169
          },
          [r25_130] = {
            255,
            255,
            255
          },
          [r25_130] = {
            62,
            72,
            75,
            62,
            72,
            75
          },
          [r25_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            0
          },
          [r25_130] = {
            0.1,
            0.4
          },
          [r25_130] = {
            200,
            50,
            0
          },
          far = 1150,
          fog = -22,
          ground = 0.5,
          [r25_130] = {
            120,
            40,
            40,
            46,
            58,
            61
          },
          [r25_130] = {
            52,
            77,
            88,
            240
          },
          [r25_130] = {
            124,
            124,
            124,
            127
          },
          [r25_130] = {
            48,
            48,
            48,
            127
          },
          [r25_130] = {
            122,
            0,
            0,
            1
          },
        },
        [r23_130] = {
          [r25_130] = {
            2,
            5,
            5
          },
          [r25_130] = {
            188,
            188,
            183
          },
          [r25_130] = {
            255,
            255,
            255
          },
          [r25_130] = {
            125,
            145,
            151,
            125,
            145,
            151
          },
          [r25_130] = {
            0,
            0,
            0,
            0,
            9,
            9,
            2
          },
          [r25_130] = {
            0.3,
            0.3
          },
          [r25_130] = {
            80,
            0,
            120
          },
          far = 1150,
          fog = -22,
          ground = 0.3,
          [r25_130] = {
            120,
            100,
            100,
            92,
            116,
            123
          },
          [r25_130] = {
            97,
            125,
            125,
            240
          },
          [r25_130] = {
            124,
            124,
            124,
            127
          },
          [r25_130] = {
            48,
            48,
            48,
            127
          },
          [r25_130] = {
            122,
            0,
            0,
            1
          },
        },
        [r23_130] = {
          [r25_130] = {
            0,
            5,
            5
          },
          [r25_130] = {
            190,
            176,
            169
          },
          [r25_130] = {
            255,
            255,
            255
          },
          [r25_130] = {
            62,
            72,
            75,
            62,
            72,
            75
          },
          [r25_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            3.5
          },
          [r25_130] = {
            0.3,
            0.4
          },
          [r25_130] = {
            80,
            0,
            0
          },
          far = 1150,
          fog = -22,
          ground = 0.8,
          [r25_130] = {
            120,
            100,
            100,
            46,
            58,
            61
          },
          [r25_130] = {
            102,
            128,
            134,
            240
          },
          [r25_130] = {
            124,
            124,
            124,
            127
          },
          [r25_130] = {
            48,
            48,
            48,
            127
          },
          [r25_130] = {
            122,
            0,
            0,
            1
          },
        },
        [r23_130] = {
          [r25_130] = {
            7,
            5,
            22
          },
          [r25_130] = {
            190,
            176,
            169
          },
          [r25_130] = {
            255,
            255,
            255
          },
          [r25_130] = {
            36,
            36,
            40,
            31,
            36,
            44
          },
          [r25_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            2
          },
          [r25_130] = {
            1,
            0.2
          },
          [r25_130] = {
            80,
            50,
            0
          },
          far = 1150,
          fog = -22,
          ground = 1,
          [r25_130] = {
            120,
            100,
            100,
            46,
            58,
            61
          },
          [r25_130] = {
            105,
            126,
            134,
            240
          },
          [r25_130] = {
            124,
            124,
            124,
            127
          },
          [r25_130] = {
            48,
            48,
            48,
            127
          },
          [r25_130] = {
            122,
            0,
            0,
            1
          },
        },
        [r23_130] = {
          [r25_130] = {
            5,
            22,
            33
          },
          [r25_130] = {
            190,
            176,
            169
          },
          [r25_130] = {
            255,
            255,
            255
          },
          [r25_130] = {
            7,
            9,
            9,
            1,
            24,
            32
          },
          [r25_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            1
          },
          [r25_130] = {
            1,
            0.2
          },
          [r25_130] = {
            200,
            100,
            0
          },
          far = 1150,
          fog = -22,
          ground = 1,
          [r25_130] = {
            70,
            27,
            10,
            23,
            28,
            30
          },
          [r25_130] = {
            41,
            77,
            74,
            240
          },
          [r25_130] = {
            124,
            124,
            124,
            127
          },
          [r25_130] = {
            48,
            48,
            48,
            127
          },
          [r25_130] = {
            122,
            0,
            0,
            1
          },
        },
      },
    },
    {
      name = "Rainy Countryside",
      [r22_130] = {
        [r24_130] = {
          [r26_130] = {
            21,
            21,
            39
          },
          [r26_130] = {
            135,
            173,
            197
          },
          [r26_130] = {
            255,
            255,
            255
          },
          [r26_130] = {
            40,
            40,
            40,
            50,
            50,
            50
          },
          [r26_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            1
          },
          [r26_130] = {
            0.6,
            1
          },
          [r26_130] = {
            200,
            100,
            0
          },
          far = 650,
          fog = 155,
          ground = 1,
          [r26_130] = {
            30,
            20,
            0,
            0,
            0,
            0
          },
          [r26_130] = {
            58,
            115,
            150,
            240
          },
          [r26_130] = {
            38,
            64,
            98,
            127
          },
          [r26_130] = {
            0,
            64,
            20,
            127
          },
          [r26_130] = {
            90,
            55,
            0,
            1
          },
          rain = 1,
        },
        [r24_130] = {
          [r26_130] = {
            31,
            31,
            31
          },
          [r26_130] = {
            135,
            173,
            197
          },
          [r26_130] = {
            255,
            255,
            255
          },
          [r26_130] = {
            50,
            50,
            50,
            50,
            50,
            50
          },
          [r26_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            1
          },
          [r26_130] = {
            0.7,
            1
          },
          [r26_130] = {
            200,
            100,
            0
          },
          far = 650,
          fog = 5,
          ground = 1,
          [r26_130] = {
            70,
            27,
            10,
            0,
            0,
            0
          },
          [r26_130] = {
            59,
            68,
            77,
            240
          },
          [r26_130] = {
            94,
            66,
            55,
            127
          },
          [r26_130] = {
            22,
            66,
            33,
            127
          },
          [r26_130] = {
            90,
            120,
            0,
            1
          },
          rain = 1,
        },
        [r24_130] = {
          [r26_130] = {
            31,
            31,
            31
          },
          [r26_130] = {
            135,
            173,
            197
          },
          [r26_130] = {
            255,
            255,
            255
          },
          [r26_130] = {
            39,
            50,
            50,
            60,
            60,
            60
          },
          [r26_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            3.4
          },
          [r26_130] = {
            0.3,
            0.9
          },
          [r26_130] = {
            200,
            100,
            0
          },
          far = 650,
          fog = 161,
          ground = 0.9,
          [r26_130] = {
            100,
            34,
            25,
            0,
            0,
            0
          },
          [r26_130] = {
            62,
            72,
            77,
            240
          },
          [r26_130] = {
            88,
            89,
            110,
            127
          },
          [r26_130] = {
            0,
            64,
            20,
            127
          },
          [r26_130] = {
            90,
            120,
            100,
            1
          },
          rain = 0.8,
        },
        [r24_130] = {
          [r26_130] = {
            21,
            21,
            21
          },
          [r26_130] = {
            135,
            173,
            197
          },
          [r26_130] = {
            255,
            255,
            255
          },
          [r26_130] = {
            69,
            69,
            69,
            79,
            79,
            79
          },
          [r26_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            0
          },
          [r26_130] = {
            0.5,
            0.7
          },
          [r26_130] = {
            80,
            80,
            0
          },
          far = 650,
          fog = 5,
          ground = 0.8,
          [r26_130] = {
            120,
            40,
            40,
            0,
            0,
            0
          },
          [r26_130] = {
            107,
            117,
            122,
            240
          },
          [r26_130] = {
            80,
            61,
            81,
            127
          },
          [r26_130] = {
            14,
            61,
            20,
            127
          },
          [r26_130] = {
            90,
            120,
            0,
            1
          },
          rain = 0.9,
        },
        [r24_130] = {
          [r26_130] = {
            21,
            21,
            21
          },
          [r26_130] = {
            186,
            186,
            186
          },
          [r26_130] = {
            255,
            255,
            255
          },
          [r26_130] = {
            80,
            80,
            80,
            70,
            70,
            70
          },
          [r26_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            1
          },
          [r26_130] = {
            0.7,
            0.5
          },
          [r26_130] = {
            80,
            50,
            120
          },
          far = 650,
          fog = 5,
          ground = 0.7,
          [r26_130] = {
            120,
            100,
            100,
            0,
            0,
            0
          },
          [r26_130] = {
            141,
            141,
            140,
            240
          },
          [r26_130] = {
            69,
            69,
            69,
            127
          },
          [r26_130] = {
            55,
            55,
            55,
            127
          },
          [r26_130] = {
            90,
            120,
            0,
            1
          },
          rain = 1,
        },
        [r24_130] = {
          [r26_130] = {
            21,
            21,
            21
          },
          [r26_130] = {
            135,
            173,
            193
          },
          [r26_130] = {
            255,
            255,
            255
          },
          [r26_130] = {
            80,
            80,
            80,
            70,
            70,
            70
          },
          [r26_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            3.5
          },
          [r26_130] = {
            0.8,
            0.8
          },
          [r26_130] = {
            80,
            50,
            0
          },
          far = 650,
          fog = 5,
          ground = 0.9,
          [r26_130] = {
            120,
            40,
            40,
            0,
            0,
            0
          },
          [r26_130] = {
            116,
            135,
            144,
            240
          },
          [r26_130] = {
            60,
            90,
            85,
            127
          },
          [r26_130] = {
            38,
            42,
            22,
            127
          },
          [r26_130] = {
            90,
            120,
            0,
            1
          },
          rain = 1,
        },
        [r24_130] = {
          [r26_130] = {
            22,
            22,
            22
          },
          [r26_130] = {
            167,
            198,
            223
          },
          [r26_130] = {
            255,
            255,
            255
          },
          [r26_130] = {
            40,
            40,
            40,
            70,
            70,
            70
          },
          [r26_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            2
          },
          [r26_130] = {
            0.8,
            1.9
          },
          [r26_130] = {
            80,
            80,
            0
          },
          far = 650,
          fog = 123,
          ground = 1,
          [r26_130] = {
            120,
            40,
            40,
            0,
            0,
            0
          },
          [r26_130] = {
            132,
            176,
            189,
            240
          },
          [r26_130] = {
            38,
            64,
            99,
            127
          },
          [r26_130] = {
            0,
            55,
            20,
            127
          },
          [r26_130] = {
            90,
            55,
            0,
            1
          },
          rain = 1,
        },
        [r24_130] = {
          [r26_130] = {
            31,
            31,
            39
          },
          [r26_130] = {
            167,
            198,
            223
          },
          [r26_130] = {
            255,
            255,
            255
          },
          [r26_130] = {
            40,
            40,
            40,
            50,
            50,
            50
          },
          [r26_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            1
          },
          [r26_130] = {
            0.5,
            0.2
          },
          [r26_130] = {
            200,
            100,
            0
          },
          far = 650,
          fog = 188,
          ground = 1,
          [r26_130] = {
            70,
            27,
            10,
            0,
            0,
            0
          },
          [r26_130] = {
            80,
            105,
            144,
            240
          },
          [r26_130] = {
            38,
            64,
            98,
            127
          },
          [r26_130] = {
            0,
            55,
            20,
            127
          },
          [r26_130] = {
            90,
            120,
            0,
            1
          },
          rain = 1,
        },
      },
    },
    {
      name = "Extra Sunny Desert",
      [r23_130] = {
        [r25_130] = {
          [r27_130] = {
            5,
            5,
            11
          },
          [r27_130] = {
            163,
            163,
            163
          },
          [r27_130] = {
            255,
            255,
            255
          },
          [r27_130] = {
            0,
            0,
            26,
            45,
            0,
            64
          },
          [r27_130] = {
            255,
            255,
            0,
            5,
            0,
            0,
            1
          },
          [r27_130] = {
            1,
            0.4
          },
          [r27_130] = {
            200,
            100,
            0
          },
          far = 1500,
          fog = 100,
          ground = 1,
          [r27_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r27_130] = {
            38,
            38,
            55,
            240
          },
          [r27_130] = {
            84,
            109,
            141,
            127
          },
          [r27_130] = {
            34,
            17,
            77,
            127
          },
          [r27_130] = {
            0,
            0,
            0,
            1
          },
        },
        [r25_130] = {
          [r27_130] = {
            5,
            5,
            15
          },
          [r27_130] = {
            180,
            163,
            163
          },
          [r27_130] = {
            255,
            255,
            255
          },
          [r27_130] = {
            11,
            0,
            21,
            80,
            50,
            58
          },
          [r27_130] = {
            255,
            128,
            0,
            255,
            0,
            0,
            0
          },
          [r27_130] = {
            0.5,
            0.7
          },
          [r27_130] = {
            150,
            100,
            0
          },
          far = 1500,
          fog = 100,
          ground = 1,
          [r27_130] = {
            70,
            27,
            10,
            50,
            43,
            36
          },
          [r27_130] = {
            53,
            62,
            68,
            240
          },
          [r27_130] = {
            124,
            93,
            131,
            127
          },
          [r27_130] = {
            34,
            17,
            14,
            127
          },
          [r27_130] = {
            0,
            0,
            0,
            1
          },
        },
        [r25_130] = {
          [r27_130] = {
            5,
            5,
            22
          },
          [r27_130] = {
            188,
            188,
            188
          },
          [r27_130] = {
            255,
            255,
            255
          },
          [r27_130] = {
            90,
            205,
            255,
            200,
            144,
            85
          },
          [r27_130] = {
            255,
            128,
            0,
            155,
            155,
            155,
            8.4
          },
          [r27_130] = {
            0.1,
            1
          },
          [r27_130] = {
            140,
            100,
            0
          },
          far = 1500,
          fog = 100,
          ground = 0.8,
          [r27_130] = {
            100,
            34,
            25,
            120,
            92,
            88
          },
          [r27_130] = {
            159,
            138,
            120,
            240
          },
          [r27_130] = {
            88,
            88,
            88,
            127
          },
          [r27_130] = {
            144,
            77,
            0,
            127
          },
          [r27_130] = {
            0,
            69,
            0,
            1
          },
        },
        [r25_130] = {
          [r27_130] = {
            10,
            10,
            10
          },
          [r27_130] = {
            188,
            188,
            188
          },
          [r27_130] = {
            255,
            255,
            255
          },
          [r27_130] = {
            210,
            231,
            200,
            250,
            218,
            143
          },
          [r27_130] = {
            255,
            128,
            0,
            155,
            155,
            155,
            3.8
          },
          [r27_130] = {
            0.2,
            1
          },
          [r27_130] = {
            100,
            50,
            0
          },
          far = 1500,
          fog = 100,
          ground = 0.5,
          [r27_130] = {
            120,
            40,
            40,
            159,
            142,
            106
          },
          [r27_130] = {
            145,
            170,
            170,
            240
          },
          [r27_130] = {
            64,
            64,
            56,
            127
          },
          [r27_130] = {
            113,
            55,
            0,
            127
          },
          [r27_130] = {
            0,
            188,
            0,
            1
          },
        },
        [r25_130] = {
          [r27_130] = {
            0,
            0,
            0
          },
          [r27_130] = {
            188,
            188,
            188
          },
          [r27_130] = {
            255,
            255,
            255
          },
          [r27_130] = {
            233,
            231,
            233,
            250,
            156,
            158
          },
          [r27_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            2.5
          },
          [r27_130] = {
            0,
            1
          },
          [r27_130] = {
            150,
            0,
            150
          },
          far = 1500,
          fog = 111,
          ground = 1,
          [r27_130] = {
            120,
            100,
            100,
            180,
            255,
            255
          },
          [r27_130] = {
            126,
            170,
            140,
            240
          },
          [r27_130] = {
            77,
            77,
            66,
            127
          },
          [r27_130] = {
            120,
            69,
            0,
            127
          },
          [r27_130] = {
            0,
            122,
            0,
            1
          },
        },
        [r25_130] = {
          [r27_130] = {
            0,
            0,
            0
          },
          [r27_130] = {
            163,
            163,
            163
          },
          [r27_130] = {
            255,
            255,
            255
          },
          [r27_130] = {
            210,
            231,
            200,
            250,
            218,
            143
          },
          [r27_130] = {
            255,
            128,
            0,
            255,
            0,
            0,
            7.5
          },
          [r27_130] = {
            0.6,
            1
          },
          [r27_130] = {
            110,
            40,
            0
          },
          far = 1500,
          fog = 10,
          ground = 0.8,
          [r27_130] = {
            120,
            40,
            40,
            200,
            123,
            96
          },
          [r27_130] = {
            139,
            112,
            87,
            240
          },
          [r27_130] = {
            88,
            88,
            77,
            127
          },
          [r27_130] = {
            92,
            20,
            0,
            127
          },
          [r27_130] = {
            0,
            188,
            0,
            1
          },
        },
        [r25_130] = {
          [r27_130] = {
            0,
            0,
            0
          },
          [r27_130] = {
            163,
            163,
            163
          },
          [r27_130] = {
            255,
            255,
            255
          },
          [r27_130] = {
            76,
            59,
            26,
            84,
            67,
            24
          },
          [r27_130] = {
            255,
            128,
            0,
            155,
            0,
            0,
            2
          },
          [r27_130] = {
            0.4,
            1
          },
          [r27_130] = {
            100,
            60,
            0
          },
          far = 1500,
          fog = 10,
          ground = 1,
          [r27_130] = {
            120,
            40,
            40,
            30,
            0,
            0
          },
          [r27_130] = {
            67,
            67,
            67,
            240
          },
          [r27_130] = {
            127,
            96,
            63,
            127
          },
          [r27_130] = {
            165,
            62,
            0,
            127
          },
          [r27_130] = {
            0,
            0,
            0,
            1
          },
        },
        [r25_130] = {
          [r27_130] = {
            5,
            5,
            11
          },
          [r27_130] = {
            163,
            163,
            163
          },
          [r27_130] = {
            255,
            255,
            255
          },
          [r27_130] = {
            5,
            11,
            29,
            54,
            0,
            64
          },
          [r27_130] = {
            255,
            5,
            8,
            5,
            8,
            0,
            1
          },
          [r27_130] = {
            0.6,
            0.5
          },
          [r27_130] = {
            160,
            100,
            0
          },
          far = 1500,
          fog = 10,
          ground = 1,
          [r27_130] = {
            70,
            27,
            10,
            0,
            0,
            0
          },
          [r27_130] = {
            67,
            67,
            62,
            240
          },
          [r27_130] = {
            84,
            109,
            124,
            127
          },
          [r27_130] = {
            34,
            17,
            77,
            127
          },
          [r27_130] = {
            0,
            0,
            0,
            1
          },
        },
      },
    },
    {
      name = "Sunny Desert",
      [r24_130] = {
        [r26_130] = {
          [r28_130] = {
            10,
            10,
            20
          },
          [r28_130] = {
            163,
            163,
            163
          },
          [r28_130] = {
            255,
            255,
            255
          },
          [r28_130] = {
            0,
            0,
            26,
            45,
            0,
            64
          },
          [r28_130] = {
            255,
            255,
            0,
            5,
            0,
            0,
            1
          },
          [r28_130] = {
            1,
            0.4
          },
          [r28_130] = {
            200,
            100,
            0
          },
          far = 1500,
          fog = 100,
          ground = 1,
          [r28_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r28_130] = {
            38,
            38,
            55,
            240
          },
          [r28_130] = {
            84,
            109,
            141,
            127
          },
          [r28_130] = {
            34,
            17,
            77,
            127
          },
          [r28_130] = {
            55,
            0,
            0,
            1
          },
        },
        [r26_130] = {
          [r28_130] = {
            10,
            10,
            15
          },
          [r28_130] = {
            180,
            163,
            163
          },
          [r28_130] = {
            255,
            255,
            255
          },
          [r28_130] = {
            11,
            0,
            21,
            80,
            50,
            58
          },
          [r28_130] = {
            255,
            128,
            0,
            255,
            0,
            0,
            0
          },
          [r28_130] = {
            0.5,
            0.7
          },
          [r28_130] = {
            150,
            100,
            0
          },
          far = 1500,
          fog = 100,
          ground = 1,
          [r28_130] = {
            70,
            27,
            10,
            50,
            43,
            36
          },
          [r28_130] = {
            53,
            62,
            68,
            240
          },
          [r28_130] = {
            124,
            93,
            131,
            127
          },
          [r28_130] = {
            34,
            17,
            14,
            127
          },
          [r28_130] = {
            55,
            0,
            0,
            1
          },
        },
        [r26_130] = {
          [r28_130] = {
            5,
            5,
            22
          },
          [r28_130] = {
            188,
            188,
            188
          },
          [r28_130] = {
            255,
            255,
            255
          },
          [r28_130] = {
            90,
            205,
            255,
            200,
            144,
            85
          },
          [r28_130] = {
            255,
            128,
            0,
            155,
            155,
            155,
            8.4
          },
          [r28_130] = {
            0.1,
            1
          },
          [r28_130] = {
            140,
            100,
            0
          },
          far = 1500,
          fog = 100,
          ground = 0.8,
          [r28_130] = {
            100,
            34,
            25,
            120,
            92,
            88
          },
          [r28_130] = {
            159,
            138,
            120,
            240
          },
          [r28_130] = {
            88,
            88,
            88,
            127
          },
          [r28_130] = {
            144,
            77,
            0,
            127
          },
          [r28_130] = {
            100,
            69,
            0,
            1
          },
        },
        [r26_130] = {
          [r28_130] = {
            0,
            0,
            0
          },
          [r28_130] = {
            188,
            188,
            188
          },
          [r28_130] = {
            255,
            255,
            255
          },
          [r28_130] = {
            210,
            231,
            200,
            250,
            218,
            143
          },
          [r28_130] = {
            255,
            128,
            0,
            155,
            155,
            155,
            3.8
          },
          [r28_130] = {
            0.2,
            1
          },
          [r28_130] = {
            100,
            50,
            0
          },
          far = 1500,
          fog = 100,
          ground = 0.5,
          [r28_130] = {
            120,
            40,
            40,
            159,
            142,
            106
          },
          [r28_130] = {
            145,
            170,
            170,
            240
          },
          [r28_130] = {
            64,
            64,
            56,
            127
          },
          [r28_130] = {
            113,
            55,
            0,
            127
          },
          [r28_130] = {
            55,
            188,
            0,
            1
          },
        },
        [r26_130] = {
          [r28_130] = {
            0,
            0,
            0
          },
          [r28_130] = {
            188,
            188,
            188
          },
          [r28_130] = {
            255,
            255,
            255
          },
          [r28_130] = {
            233,
            231,
            233,
            250,
            156,
            158
          },
          [r28_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            2.5
          },
          [r28_130] = {
            0,
            1
          },
          [r28_130] = {
            150,
            0,
            150
          },
          far = 1500,
          fog = 111,
          ground = 1,
          [r28_130] = {
            120,
            100,
            100,
            180,
            255,
            255
          },
          [r28_130] = {
            126,
            170,
            140,
            240
          },
          [r28_130] = {
            77,
            77,
            66,
            127
          },
          [r28_130] = {
            120,
            69,
            0,
            127
          },
          [r28_130] = {
            33,
            122,
            0,
            1
          },
        },
        [r26_130] = {
          [r28_130] = {
            0,
            0,
            0
          },
          [r28_130] = {
            163,
            163,
            163
          },
          [r28_130] = {
            255,
            255,
            255
          },
          [r28_130] = {
            210,
            231,
            200,
            250,
            218,
            143
          },
          [r28_130] = {
            255,
            128,
            0,
            255,
            0,
            0,
            7.5
          },
          [r28_130] = {
            0.6,
            1
          },
          [r28_130] = {
            110,
            40,
            0
          },
          far = 1500,
          fog = 10,
          ground = 0.8,
          [r28_130] = {
            120,
            40,
            40,
            200,
            123,
            96
          },
          [r28_130] = {
            139,
            112,
            87,
            240
          },
          [r28_130] = {
            88,
            88,
            77,
            127
          },
          [r28_130] = {
            92,
            20,
            0,
            127
          },
          [r28_130] = {
            55,
            188,
            0,
            1
          },
        },
        [r26_130] = {
          [r28_130] = {
            0,
            0,
            0
          },
          [r28_130] = {
            163,
            163,
            163
          },
          [r28_130] = {
            255,
            255,
            255
          },
          [r28_130] = {
            181,
            150,
            84,
            167,
            108,
            65
          },
          [r28_130] = {
            255,
            128,
            0,
            155,
            0,
            0,
            2
          },
          [r28_130] = {
            0.4,
            1
          },
          [r28_130] = {
            100,
            60,
            0
          },
          far = 1500,
          fog = 10,
          ground = 1,
          [r28_130] = {
            120,
            40,
            40,
            30,
            0,
            0
          },
          [r28_130] = {
            67,
            67,
            67,
            240
          },
          [r28_130] = {
            81,
            85,
            40,
            127
          },
          [r28_130] = {
            66,
            27,
            0,
            127
          },
          [r28_130] = {
            53,
            0,
            0,
            1
          },
        },
        [r26_130] = {
          [r28_130] = {
            10,
            10,
            10
          },
          [r28_130] = {
            163,
            163,
            163
          },
          [r28_130] = {
            255,
            255,
            255
          },
          [r28_130] = {
            5,
            11,
            29,
            54,
            0,
            64
          },
          [r28_130] = {
            255,
            5,
            8,
            5,
            8,
            0,
            1
          },
          [r28_130] = {
            0.6,
            0.5
          },
          [r28_130] = {
            160,
            100,
            0
          },
          far = 1500,
          fog = 10,
          ground = 1,
          [r28_130] = {
            70,
            27,
            10,
            0,
            0,
            0
          },
          [r28_130] = {
            67,
            67,
            62,
            240
          },
          [r28_130] = {
            84,
            109,
            124,
            127
          },
          [r28_130] = {
            34,
            17,
            77,
            127
          },
          [r28_130] = {
            55,
            0,
            0,
            1
          },
        },
      },
    },
    {
      name = "Sandstorm Desert",
      [r25_130] = {
        [r27_130] = {
          [r29_130] = {
            21,
            21,
            21
          },
          [r29_130] = {
            137,
            137,
            137
          },
          [r29_130] = {
            255,
            255,
            255
          },
          [r29_130] = {
            55,
            55,
            55,
            55,
            55,
            55
          },
          [r29_130] = {
            255,
            255,
            0,
            5,
            0,
            0,
            1
          },
          [r29_130] = {
            1,
            1
          },
          [r29_130] = {
            50,
            100,
            0
          },
          far = 150,
          fog = -111,
          ground = 1,
          [r29_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r29_130] = {
            38,
            38,
            55,
            240
          },
          [r29_130] = {
            64,
            64,
            64,
            127
          },
          [r29_130] = {
            56,
            38,
            0,
            127
          },
          [r29_130] = {
            0,
            12,
            0,
            1
          },
        },
        [r27_130] = {
          [r29_130] = {
            21,
            21,
            21
          },
          [r29_130] = {
            137,
            137,
            137
          },
          [r29_130] = {
            255,
            255,
            255
          },
          [r29_130] = {
            105,
            102,
            82,
            105,
            102,
            82
          },
          [r29_130] = {
            255,
            128,
            0,
            255,
            0,
            0,
            0
          },
          [r29_130] = {
            1,
            1
          },
          [r29_130] = {
            50,
            100,
            0
          },
          far = 150,
          fog = -111,
          ground = 1,
          [r29_130] = {
            70,
            27,
            10,
            50,
            43,
            36
          },
          [r29_130] = {
            53,
            62,
            68,
            240
          },
          [r29_130] = {
            64,
            64,
            64,
            127
          },
          [r29_130] = {
            56,
            38,
            0,
            127
          },
          [r29_130] = {
            0,
            12,
            0,
            1
          },
        },
        [r27_130] = {
          [r29_130] = {
            21,
            21,
            21
          },
          [r29_130] = {
            137,
            137,
            137
          },
          [r29_130] = {
            255,
            255,
            255
          },
          [r29_130] = {
            112,
            109,
            89,
            112,
            109,
            89
          },
          [r29_130] = {
            255,
            128,
            0,
            255,
            128,
            0,
            8.4
          },
          [r29_130] = {
            0,
            1
          },
          [r29_130] = {
            50,
            100,
            0
          },
          far = 150,
          fog = -111,
          ground = 0.8,
          [r29_130] = {
            100,
            34,
            25,
            120,
            92,
            88
          },
          [r29_130] = {
            185,
            160,
            160,
            192
          },
          [r29_130] = {
            64,
            64,
            64,
            127
          },
          [r29_130] = {
            56,
            32,
            0,
            127
          },
          [r29_130] = {
            0,
            12,
            0,
            1
          },
        },
        [r27_130] = {
          [r29_130] = {
            21,
            21,
            21
          },
          [r29_130] = {
            137,
            137,
            137
          },
          [r29_130] = {
            255,
            255,
            255
          },
          [r29_130] = {
            120,
            117,
            96,
            120,
            117,
            96
          },
          [r29_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            0
          },
          [r29_130] = {
            0,
            1
          },
          [r29_130] = {
            50,
            50,
            0
          },
          far = 150,
          fog = -111,
          ground = 0.5,
          [r29_130] = {
            120,
            40,
            40,
            159,
            142,
            106
          },
          [r29_130] = {
            145,
            170,
            170,
            230
          },
          [r29_130] = {
            64,
            64,
            64,
            127
          },
          [r29_130] = {
            99,
            89,
            77,
            127
          },
          [r29_130] = {
            0,
            12,
            0,
            1
          },
        },
        [r27_130] = {
          [r29_130] = {
            11,
            11,
            11
          },
          [r29_130] = {
            137,
            137,
            137
          },
          [r29_130] = {
            255,
            255,
            255
          },
          [r29_130] = {
            166,
            163,
            140,
            166,
            163,
            140
          },
          [r29_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            0
          },
          [r29_130] = {
            0,
            1
          },
          [r29_130] = {
            50,
            0,
            0
          },
          far = 150,
          fog = -111,
          ground = 1,
          [r29_130] = {
            120,
            100,
            100,
            180,
            255,
            255
          },
          [r29_130] = {
            45,
            90,
            90,
            240
          },
          [r29_130] = {
            64,
            44,
            33,
            127
          },
          [r29_130] = {
            99,
            99,
            77,
            127
          },
          [r29_130] = {
            0,
            44,
            0,
            1
          },
        },
        [r27_130] = {
          [r29_130] = {
            21,
            21,
            21
          },
          [r29_130] = {
            137,
            137,
            137
          },
          [r29_130] = {
            255,
            255,
            255
          },
          [r29_130] = {
            97,
            94,
            78,
            97,
            94,
            78
          },
          [r29_130] = {
            255,
            128,
            0,
            255,
            0,
            0,
            0
          },
          [r29_130] = {
            1,
            1
          },
          [r29_130] = {
            50,
            40,
            0
          },
          far = 150,
          fog = -111,
          ground = 0.8,
          [r29_130] = {
            120,
            40,
            40,
            200,
            123,
            96
          },
          [r29_130] = {
            98,
            95,
            87,
            240
          },
          [r29_130] = {
            64,
            64,
            64,
            127
          },
          [r29_130] = {
            99,
            99,
            99,
            127
          },
          [r29_130] = {
            0,
            255,
            0,
            1
          },
        },
        [r27_130] = {
          [r29_130] = {
            21,
            21,
            21
          },
          [r29_130] = {
            137,
            137,
            137
          },
          [r29_130] = {
            255,
            255,
            255
          },
          [r29_130] = {
            87,
            84,
            69,
            87,
            84,
            69
          },
          [r29_130] = {
            255,
            128,
            0,
            155,
            0,
            0,
            2
          },
          [r29_130] = {
            1,
            1
          },
          [r29_130] = {
            50,
            60,
            0
          },
          far = 150,
          fog = -111,
          ground = 1,
          [r29_130] = {
            120,
            40,
            40,
            0,
            0,
            0
          },
          [r29_130] = {
            67,
            67,
            67,
            240
          },
          [r29_130] = {
            64,
            64,
            64,
            127
          },
          [r29_130] = {
            56,
            38,
            0,
            127
          },
          [r29_130] = {
            0,
            255,
            0,
            1
          },
        },
        [r27_130] = {
          [r29_130] = {
            21,
            21,
            21
          },
          [r29_130] = {
            137,
            155,
            33
          },
          [r29_130] = {
            255,
            255,
            255
          },
          [r29_130] = {
            55,
            55,
            55,
            55,
            55,
            55
          },
          [r29_130] = {
            255,
            5,
            8,
            5,
            8,
            0,
            1
          },
          [r29_130] = {
            1,
            1
          },
          [r29_130] = {
            50,
            100,
            0
          },
          far = 150,
          fog = -111,
          ground = 1,
          [r29_130] = {
            70,
            27,
            10,
            0,
            0,
            0
          },
          [r29_130] = {
            67,
            67,
            62,
            240
          },
          [r29_130] = {
            64,
            64,
            64,
            127
          },
          [r29_130] = {
            56,
            38,
            0,
            127
          },
          [r29_130] = {
            0,
            0,
            0,
            1
          },
        },
      },
    },
    {
      name = "Underwater",
      [r26_130] = {
        [r28_130] = {
          [r30_130] = {
            21,
            21,
            21
          },
          [r30_130] = {
            135,
            173,
            197
          },
          [r30_130] = {
            255,
            255,
            255
          },
          [r30_130] = {
            10,
            10,
            10,
            20,
            20,
            20
          },
          [r30_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            1
          },
          [r30_130] = {
            1,
            1
          },
          [r30_130] = {
            200,
            100,
            0
          },
          far = 300,
          fog = 5,
          ground = 1,
          [r30_130] = {
            30,
            20,
            0,
            0,
            0,
            0
          },
          [r30_130] = {
            59,
            68,
            77,
            192
          },
          [r30_130] = {
            104,
            136,
            83,
            127
          },
          [r30_130] = {
            24,
            76,
            16,
            127
          },
          [r30_130] = {
            255,
            0,
            0,
            1
          },
        },
        [r28_130] = {
          [r30_130] = {
            21,
            21,
            21
          },
          [r30_130] = {
            135,
            173,
            197
          },
          [r30_130] = {
            255,
            255,
            255
          },
          [r30_130] = {
            10,
            10,
            10,
            20,
            20,
            20
          },
          [r30_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            0
          },
          [r30_130] = {
            1,
            1
          },
          [r30_130] = {
            200,
            100,
            0
          },
          far = 300,
          fog = 5,
          ground = 1,
          [r30_130] = {
            70,
            27,
            10,
            0,
            0,
            0
          },
          [r30_130] = {
            59,
            68,
            77,
            192
          },
          [r30_130] = {
            94,
            141,
            95,
            127
          },
          [r30_130] = {
            0,
            70,
            20,
            127
          },
          [r30_130] = {
            255,
            0,
            0,
            1
          },
        },
        [r28_130] = {
          [r30_130] = {
            21,
            21,
            21
          },
          [r30_130] = {
            135,
            173,
            197
          },
          [r30_130] = {
            255,
            255,
            255
          },
          [r30_130] = {
            10,
            10,
            10,
            20,
            20,
            20
          },
          [r30_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            3.4
          },
          [r30_130] = {
            0.9,
            0.9
          },
          [r30_130] = {
            200,
            100,
            0
          },
          far = 300,
          fog = 5,
          ground = 0.9,
          [r30_130] = {
            100,
            34,
            25,
            0,
            0,
            0
          },
          [r30_130] = {
            62,
            72,
            77,
            192
          },
          [r30_130] = {
            124,
            174,
            110,
            127
          },
          [r30_130] = {
            0,
            64,
            20,
            127
          },
          [r30_130] = {
            255,
            0,
            100,
            1
          },
        },
        [r28_130] = {
          [r30_130] = {
            21,
            21,
            21
          },
          [r30_130] = {
            135,
            173,
            197
          },
          [r30_130] = {
            255,
            255,
            255
          },
          [r30_130] = {
            40,
            40,
            40,
            50,
            50,
            50
          },
          [r30_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            2.5
          },
          [r30_130] = {
            0.8,
            0.7
          },
          [r30_130] = {
            80,
            80,
            0
          },
          far = 300,
          fog = 5,
          ground = 0.8,
          [r30_130] = {
            120,
            40,
            40,
            0,
            0,
            0
          },
          [r30_130] = {
            107,
            117,
            122,
            192
          },
          [r30_130] = {
            124,
            153,
            104,
            127
          },
          [r30_130] = {
            0,
            48,
            20,
            127
          },
          [r30_130] = {
            255,
            0,
            0,
            1
          },
        },
        [r28_130] = {
          [r30_130] = {
            21,
            21,
            21
          },
          [r30_130] = {
            186,
            186,
            186
          },
          [r30_130] = {
            255,
            255,
            255
          },
          [r30_130] = {
            80,
            80,
            80,
            70,
            70,
            70
          },
          [r30_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            1
          },
          [r30_130] = {
            0.7,
            0.5
          },
          [r30_130] = {
            80,
            50,
            120
          },
          far = 300,
          fog = 5,
          ground = 0.7,
          [r30_130] = {
            120,
            100,
            100,
            0,
            0,
            0
          },
          [r30_130] = {
            141,
            141,
            140,
            255
          },
          [r30_130] = {
            124,
            143,
            109,
            127
          },
          [r30_130] = {
            0,
            51,
            24,
            127
          },
          [r30_130] = {
            255,
            0,
            0,
            1
          },
        },
        [r28_130] = {
          [r30_130] = {
            21,
            21,
            21
          },
          [r30_130] = {
            135,
            173,
            193
          },
          [r30_130] = {
            255,
            255,
            255
          },
          [r30_130] = {
            80,
            80,
            80,
            70,
            70,
            70
          },
          [r30_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            3.5
          },
          [r30_130] = {
            1,
            1
          },
          [r30_130] = {
            80,
            50,
            0
          },
          far = 300,
          fog = 5,
          ground = 0.9,
          [r30_130] = {
            120,
            40,
            40,
            0,
            0,
            0
          },
          [r30_130] = {
            116,
            135,
            144,
            192
          },
          [r30_130] = {
            124,
            139,
            85,
            127
          },
          [r30_130] = {
            10,
            46,
            22,
            127
          },
          [r30_130] = {
            255,
            0,
            0,
            1
          },
        },
        [r28_130] = {
          [r30_130] = {
            21,
            21,
            21
          },
          [r30_130] = {
            167,
            198,
            223
          },
          [r30_130] = {
            255,
            255,
            255
          },
          [r30_130] = {
            40,
            40,
            40,
            70,
            70,
            70
          },
          [r30_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            2
          },
          [r30_130] = {
            1,
            1
          },
          [r30_130] = {
            80,
            80,
            0
          },
          far = 300,
          fog = 5,
          ground = 1,
          [r30_130] = {
            120,
            40,
            40,
            0,
            0,
            0
          },
          [r30_130] = {
            132,
            176,
            189,
            192
          },
          [r30_130] = {
            63,
            124,
            99,
            127
          },
          [r30_130] = {
            0,
            87,
            20,
            127
          },
          [r30_130] = {
            255,
            0,
            0,
            1
          },
        },
        [r28_130] = {
          [r30_130] = {
            21,
            21,
            21
          },
          [r30_130] = {
            167,
            198,
            223
          },
          [r30_130] = {
            255,
            255,
            255
          },
          [r30_130] = {
            40,
            40,
            40,
            50,
            50,
            50
          },
          [r30_130] = {
            0,
            0,
            0,
            0,
            0,
            0,
            1
          },
          [r30_130] = {
            1,
            1
          },
          [r30_130] = {
            200,
            100,
            0
          },
          far = 300,
          fog = 5,
          ground = 1,
          [r30_130] = {
            70,
            27,
            10,
            0,
            0,
            0
          },
          [r30_130] = {
            161,
            176,
            189,
            192
          },
          [r30_130] = {
            124,
            124,
            91,
            127
          },
          [r30_130] = {
            0,
            85,
            20,
            127
          },
          [r30_130] = {
            255,
            0,
            0,
            1
          },
        },
      },
    },
    {
      name = "Extra Colours 1",
      [r27_130] = {
        [r29_130] = {
          [r31_130] = {
            0,
            0,
            0
          },
          [r31_130] = {
            166,
            166,
            166
          },
          [r31_130] = {
            255,
            255,
            255
          },
          [r31_130] = {
            255,
            255,
            255,
            5,
            5,
            5
          },
          [r31_130] = {
            255,
            255,
            0,
            5,
            0,
            0,
            1
          },
          [r31_130] = {
            1,
            1
          },
          [r31_130] = {
            200,
            100,
            0
          },
          far = 400,
          fog = 100,
          ground = 1,
          [r31_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r31_130] = {
            85,
            85,
            65,
            192
          },
          [r31_130] = {
            64,
            64,
            41,
            127
          },
          [r31_130] = {
            64,
            64,
            64,
            127
          },
          [r31_130] = {
            0,
            0,
            0,
            0
          },
        },
        [r29_130] = {
          [r31_130] = {
            0,
            0,
            0
          },
          [r31_130] = {
            121,
            122,
            122
          },
          [r31_130] = {
            255,
            255,
            255
          },
          [r31_130] = {
            1,
            1,
            1,
            5,
            5,
            5
          },
          [r31_130] = {
            255,
            255,
            0,
            5,
            0,
            0,
            1
          },
          [r31_130] = {
            1,
            0.4
          },
          [r31_130] = {
            200,
            100,
            0
          },
          far = 400,
          fog = 100,
          ground = 1,
          [r31_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r31_130] = {
            65,
            85,
            65,
            147
          },
          [r31_130] = {
            64,
            64,
            43,
            127
          },
          [r31_130] = {
            73,
            69,
            64,
            127
          },
          [r31_130] = {
            0,
            0,
            0,
            1
          },
        },
        [r29_130] = {
          [r31_130] = {
            0,
            0,
            0
          },
          [r31_130] = {
            50,
            50,
            50
          },
          [r31_130] = {
            255,
            255,
            255
          },
          [r31_130] = {
            255,
            255,
            255,
            5,
            5,
            5
          },
          [r31_130] = {
            255,
            255,
            0,
            5,
            0,
            0,
            1
          },
          [r31_130] = {
            1,
            1
          },
          [r31_130] = {
            200,
            100,
            0
          },
          far = 400,
          fog = 100,
          ground = 1,
          [r31_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r31_130] = {
            85,
            85,
            65,
            192
          },
          [r31_130] = {
            64,
            64,
            64,
            127
          },
          [r31_130] = {
            64,
            64,
            64,
            127
          },
          [r31_130] = {
            0,
            0,
            0,
            1
          },
        },
        [r29_130] = {
          [r31_130] = {
            0,
            0,
            0
          },
          [r31_130] = {
            180,
            180,
            180
          },
          [r31_130] = {
            255,
            255,
            255
          },
          [r31_130] = {
            1,
            1,
            1,
            5,
            5,
            5
          },
          [r31_130] = {
            255,
            255,
            0,
            5,
            0,
            0,
            1
          },
          [r31_130] = {
            1,
            1
          },
          [r31_130] = {
            200,
            100,
            0
          },
          far = 400,
          fog = 100,
          ground = 1,
          [r31_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r31_130] = {
            85,
            85,
            65,
            192
          },
          [r31_130] = {
            64,
            64,
            46,
            127
          },
          [r31_130] = {
            65,
            64,
            64,
            127
          },
          [r31_130] = {
            0,
            0,
            0,
            1
          },
        },
        [r29_130] = {
          [r31_130] = {
            8,
            2,
            4
          },
          [r31_130] = {
            22,
            22,
            22
          },
          [r31_130] = {
            255,
            255,
            255
          },
          [r31_130] = {
            255,
            255,
            255,
            5,
            5,
            5
          },
          [r31_130] = {
            255,
            255,
            0,
            5,
            0,
            0,
            1
          },
          [r31_130] = {
            1,
            1
          },
          [r31_130] = {
            200,
            100,
            0
          },
          far = 400,
          fog = 100,
          ground = 1,
          [r31_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r31_130] = {
            85,
            85,
            65,
            192
          },
          [r31_130] = {
            87,
            64,
            85,
            127
          },
          [r31_130] = {
            64,
            33,
            33,
            127
          },
          [r31_130] = {
            0,
            0,
            0,
            0
          },
        },
        [r29_130] = {
          [r31_130] = {
            7,
            9,
            2
          },
          [r31_130] = {
            54,
            55,
            55
          },
          [r31_130] = {
            255,
            255,
            255
          },
          [r31_130] = {
            255,
            255,
            255,
            5,
            5,
            5
          },
          [r31_130] = {
            255,
            255,
            0,
            5,
            0,
            0,
            1
          },
          [r31_130] = {
            1,
            1
          },
          [r31_130] = {
            200,
            100,
            0
          },
          far = 400,
          fog = 100,
          ground = 1,
          [r31_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r31_130] = {
            85,
            85,
            65,
            192
          },
          [r31_130] = {
            44,
            64,
            87,
            127
          },
          [r31_130] = {
            99,
            99,
            99,
            127
          },
          [r31_130] = {
            0,
            0,
            0,
            1
          },
        },
        [r29_130] = {
          [r31_130] = {
            0,
            0,
            0
          },
          [r31_130] = {
            20,
            20,
            20
          },
          [r31_130] = {
            255,
            255,
            255
          },
          [r31_130] = {
            255,
            255,
            255,
            5,
            5,
            5
          },
          [r31_130] = {
            255,
            255,
            0,
            5,
            0,
            0,
            1
          },
          [r31_130] = {
            1,
            1
          },
          [r31_130] = {
            200,
            100,
            0
          },
          far = 400,
          fog = 100,
          ground = 1,
          [r31_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r31_130] = {
            85,
            85,
            65,
            192
          },
          [r31_130] = {
            64,
            64,
            64,
            127
          },
          [r31_130] = {
            64,
            146,
            64,
            127
          },
          [r31_130] = {
            0,
            0,
            0,
            1
          },
        },
        [r29_130] = {
          [r31_130] = {
            0,
            0,
            0
          },
          [r31_130] = {
            20,
            20,
            20
          },
          [r31_130] = {
            255,
            255,
            255
          },
          [r31_130] = {
            255,
            255,
            255,
            5,
            5,
            5
          },
          [r31_130] = {
            255,
            255,
            0,
            5,
            0,
            0,
            1
          },
          [r31_130] = {
            0.5,
            0.4
          },
          [r31_130] = {
            200,
            100,
            0
          },
          far = 400,
          fog = 100,
          ground = 1,
          [r31_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r31_130] = {
            85,
            85,
            65,
            192
          },
          [r31_130] = {
            64,
            64,
            64,
            127
          },
          [r31_130] = {
            96,
            92,
            64,
            127
          },
          [r31_130] = {
            0,
            0,
            0,
            1
          },
        },
      },
    },
    {
      name = "Extra Colours 2",
      [r28_130] = {
        [r30_130] = {
          [r32_130] = {
            0,
            0,
            0
          },
          [r32_130] = {
            99,
            99,
            99
          },
          [r32_130] = {
            255,
            255,
            255
          },
          [r32_130] = {
            255,
            255,
            255,
            5,
            5,
            5
          },
          [r32_130] = {
            255,
            255,
            0,
            5,
            0,
            0,
            1
          },
          [r32_130] = {
            1,
            1
          },
          [r32_130] = {
            200,
            100,
            0
          },
          far = 400,
          fog = 100,
          ground = 1,
          [r32_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r32_130] = {
            85,
            85,
            65,
            192
          },
          [r32_130] = {
            61,
            53,
            30,
            127
          },
          [r32_130] = {
            64,
            64,
            64,
            127
          },
          [r32_130] = {
            0,
            0,
            0,
            1
          },
        },
        [r30_130] = {
          [r32_130] = {
            30,
            30,
            30
          },
          [r32_130] = {
            20,
            20,
            20
          },
          [r32_130] = {
            255,
            255,
            255
          },
          [r32_130] = {
            255,
            255,
            255,
            5,
            5,
            5
          },
          [r32_130] = {
            255,
            255,
            0,
            5,
            0,
            0,
            1
          },
          [r32_130] = {
            1,
            1
          },
          [r32_130] = {
            200,
            100,
            0
          },
          far = 400,
          fog = 100,
          ground = 1,
          [r32_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r32_130] = {
            85,
            85,
            65,
            192
          },
          [r32_130] = {
            64,
            64,
            64,
            127
          },
          [r32_130] = {
            64,
            73,
            80,
            127
          },
          [r32_130] = {
            0,
            0,
            0,
            1
          },
        },
        [r30_130] = {
          [r32_130] = {
            0,
            0,
            0
          },
          [r32_130] = {
            20,
            20,
            20
          },
          [r32_130] = {
            255,
            255,
            255
          },
          [r32_130] = {
            255,
            255,
            255,
            50,
            5,
            50
          },
          [r32_130] = {
            255,
            255,
            0,
            5,
            0,
            0,
            1
          },
          [r32_130] = {
            1,
            1
          },
          [r32_130] = {
            200,
            100,
            0
          },
          far = 78,
          fog = 50,
          ground = 1,
          [r32_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r32_130] = {
            85,
            85,
            65,
            192
          },
          [r32_130] = {
            64,
            16,
            64,
            127
          },
          [r32_130] = {
            64,
            64,
            64,
            127
          },
          [r32_130] = {
            0,
            0,
            0,
            1
          },
        },
        [r30_130] = {
          [r32_130] = {
            0,
            0,
            0
          },
          [r32_130] = {
            133,
            133,
            133
          },
          [r32_130] = {
            255,
            255,
            255
          },
          [r32_130] = {
            255,
            255,
            255,
            0,
            0,
            0
          },
          [r32_130] = {
            0,
            0,
            0,
            5,
            0,
            0,
            1
          },
          [r32_130] = {
            1,
            1
          },
          [r32_130] = {
            200,
            0,
            0
          },
          far = 400,
          fog = 100,
          ground = 1,
          [r32_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r32_130] = {
            85,
            85,
            65,
            192
          },
          [r32_130] = {
            64,
            64,
            64,
            64
          },
          [r32_130] = {
            64,
            64,
            64,
            127
          },
          [r32_130] = {
            0,
            0,
            0,
            0
          },
        },
        [r30_130] = {
          [r32_130] = {
            0,
            0,
            0
          },
          [r32_130] = {
            0,
            0,
            0
          },
          [r32_130] = {
            255,
            255,
            255
          },
          [r32_130] = {
            255,
            255,
            255,
            0,
            0,
            0
          },
          [r32_130] = {
            0,
            0,
            0,
            5,
            0,
            0,
            1
          },
          [r32_130] = {
            1,
            1
          },
          [r32_130] = {
            200,
            0,
            0
          },
          far = 400,
          fog = 100,
          ground = 1,
          [r32_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r32_130] = {
            85,
            85,
            65,
            192
          },
          [r32_130] = {
            44,
            44,
            44,
            127
          },
          [r32_130] = {
            33,
            64,
            64,
            127
          },
          [r32_130] = {
            234,
            0,
            0,
            0
          },
        },
        [r30_130] = {
          [r32_130] = {
            0,
            0,
            0
          },
          [r32_130] = {
            20,
            20,
            20
          },
          [r32_130] = {
            255,
            255,
            255
          },
          [r32_130] = {
            255,
            255,
            255,
            5,
            5,
            5
          },
          [r32_130] = {
            255,
            255,
            0,
            5,
            0,
            0,
            1
          },
          [r32_130] = {
            1,
            1
          },
          [r32_130] = {
            200,
            100,
            0
          },
          far = 400,
          fog = 100,
          ground = 1,
          [r32_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r32_130] = {
            85,
            85,
            65,
            192
          },
          [r32_130] = {
            64,
            64,
            64,
            127
          },
          [r32_130] = {
            64,
            146,
            64,
            127
          },
          [r32_130] = {
            0,
            0,
            0,
            1
          },
        },
        [r30_130] = {
          [r32_130] = {
            0,
            0,
            0
          },
          [r32_130] = {
            50,
            50,
            50
          },
          [r32_130] = {
            255,
            255,
            255
          },
          [r32_130] = {
            255,
            255,
            255,
            5,
            5,
            5
          },
          [r32_130] = {
            255,
            255,
            0,
            5,
            0,
            0,
            1
          },
          [r32_130] = {
            1,
            1
          },
          [r32_130] = {
            200,
            100,
            0
          },
          far = 400,
          fog = 100,
          ground = 1,
          [r32_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r32_130] = {
            85,
            85,
            65,
            192
          },
          [r32_130] = {
            64,
            64,
            64,
            127
          },
          [r32_130] = {
            64,
            64,
            64,
            127
          },
          [r32_130] = {
            0,
            0,
            0,
            1
          },
        },
        [r30_130] = {
          [r32_130] = {
            0,
            0,
            0
          },
          [r32_130] = {
            190,
            180,
            180
          },
          [r32_130] = {
            255,
            255,
            255
          },
          [r32_130] = {
            1,
            1,
            1,
            5,
            5,
            5
          },
          [r32_130] = {
            255,
            255,
            0,
            5,
            0,
            0,
            1
          },
          [r32_130] = {
            1,
            1
          },
          [r32_130] = {
            200,
            100,
            0
          },
          far = 400,
          fog = 100,
          ground = 1,
          [r32_130] = {
            30,
            20,
            0,
            3,
            3,
            3
          },
          [r32_130] = {
            85,
            85,
            65,
            192
          },
          [r32_130] = {
            64,
            64,
            64,
            127
          },
          [r32_130] = {
            64,
            64,
            40,
            127
          },
          [r32_130] = {
            0,
            0,
            0,
            1
          },
        },
      },
    }
  }
  local r28_130 = "amb"
  r28_130 = "obj"
  r28_130 = "dir"
  r28_130 = "sky"
  r28_130 = "sun"
  r28_130 = "sprite"
  r28_130 = "shadow"
  r28_130 = "cloud"
  r28_130 = "water"
  r28_130 = "rgb1"
  r28_130 = "rgb2"
  r28_130 = "cloud2"
  r28_130 = "amb"
  r28_130 = "obj"
  r28_130 = "dir"
  r28_130 = "sky"
  r28_130 = "sun"
  r28_130 = "sprite"
  r28_130 = "shadow"
  r28_130 = "cloud"
  r28_130 = "water"
  r28_130 = "rgb1"
  r28_130 = "rgb2"
  r28_130 = "cloud2"
  r28_130 = "amb"
  r28_130 = "obj"
  r28_130 = "dir"
  r28_130 = "sky"
  r28_130 = "sun"
  r28_130 = "sprite"
  r28_130 = "shadow"
  r28_130 = "cloud"
  r28_130 = "water"
  r28_130 = "rgb1"
  r28_130 = "rgb2"
  r28_130 = "cloud2"
  r28_130 = "amb"
  r28_130 = "obj"
  r28_130 = "dir"
  r28_130 = "sky"
  r28_130 = "sun"
  r28_130 = "sprite"
  r28_130 = "shadow"
  r28_130 = "cloud"
  r28_130 = "water"
  r28_130 = "rgb1"
  r28_130 = "rgb2"
  r28_130 = "cloud2"
  r28_130 = "amb"
  r28_130 = "obj"
  r28_130 = "dir"
  r28_130 = "sky"
  r28_130 = "sun"
  r28_130 = "sprite"
  r28_130 = "shadow"
  r28_130 = "cloud"
  r28_130 = "water"
  r28_130 = "rgb1"
  r28_130 = "rgb2"
  r28_130 = "cloud2"
  r28_130 = "amb"
  r28_130 = "obj"
  r28_130 = "dir"
  r28_130 = "sky"
  r28_130 = "sun"
  r28_130 = "sprite"
  r28_130 = "shadow"
  r28_130 = "cloud"
  r28_130 = "water"
  r28_130 = "rgb1"
  r28_130 = "rgb2"
  r28_130 = "cloud2"
  r28_130 = "amb"
  r28_130 = "obj"
  r28_130 = "dir"
  r28_130 = "sky"
  r28_130 = "sun"
  r28_130 = "sprite"
  r28_130 = "shadow"
  r28_130 = "cloud"
  r28_130 = "water"
  r28_130 = "rgb1"
  r28_130 = "rgb2"
  r28_130 = "cloud2"
  r28_130 = "amb"
  r28_130 = "obj"
  r28_130 = "dir"
  r28_130 = "sky"
  r28_130 = "sun"
  r28_130 = "sprite"
  r28_130 = "shadow"
  r28_130 = "cloud"
  r28_130 = "water"
  r28_130 = "rgb1"
  r28_130 = "rgb2"
  r28_130 = "cloud2"
  local r29_130 = "amb"
  r29_130 = "obj"
  r29_130 = "dir"
  r29_130 = "sky"
  r29_130 = "sun"
  r29_130 = "sprite"
  r29_130 = "shadow"
  r29_130 = "cloud"
  r29_130 = "water"
  r29_130 = "rgb1"
  r29_130 = "rgb2"
  r29_130 = "cloud2"
  r29_130 = "amb"
  r29_130 = "obj"
  r29_130 = "dir"
  r29_130 = "sky"
  r29_130 = "sun"
  r29_130 = "sprite"
  r29_130 = "shadow"
  r29_130 = "cloud"
  r29_130 = "water"
  r29_130 = "rgb1"
  r29_130 = "rgb2"
  r29_130 = "cloud2"
  r29_130 = "amb"
  r29_130 = "obj"
  r29_130 = "dir"
  r29_130 = "sky"
  r29_130 = "sun"
  r29_130 = "sprite"
  r29_130 = "shadow"
  r29_130 = "cloud"
  r29_130 = "water"
  r29_130 = "rgb1"
  r29_130 = "rgb2"
  r29_130 = "cloud2"
  r29_130 = "amb"
  r29_130 = "obj"
  r29_130 = "dir"
  r29_130 = "sky"
  r29_130 = "sun"
  r29_130 = "sprite"
  r29_130 = "shadow"
  r29_130 = "cloud"
  r29_130 = "water"
  r29_130 = "rgb1"
  r29_130 = "rgb2"
  r29_130 = "cloud2"
  r29_130 = "amb"
  r29_130 = "obj"
  r29_130 = "dir"
  r29_130 = "sky"
  r29_130 = "sun"
  r29_130 = "sprite"
  r29_130 = "shadow"
  r29_130 = "cloud"
  r29_130 = "water"
  r29_130 = "rgb1"
  r29_130 = "rgb2"
  r29_130 = "cloud2"
  r29_130 = "amb"
  r29_130 = "obj"
  r29_130 = "dir"
  r29_130 = "sky"
  r29_130 = "sun"
  r29_130 = "sprite"
  r29_130 = "shadow"
  r29_130 = "cloud"
  r29_130 = "water"
  r29_130 = "rgb1"
  r29_130 = "rgb2"
  r29_130 = "cloud2"
  r29_130 = "amb"
  r29_130 = "obj"
  r29_130 = "dir"
  r29_130 = "sky"
  r29_130 = "sun"
  r29_130 = "sprite"
  r29_130 = "shadow"
  r29_130 = "cloud"
  r29_130 = "water"
  r29_130 = "rgb1"
  r29_130 = "rgb2"
  r29_130 = "cloud2"
  r29_130 = "amb"
  r29_130 = "obj"
  r29_130 = "dir"
  r29_130 = "sky"
  r29_130 = "sun"
  r29_130 = "sprite"
  r29_130 = "shadow"
  r29_130 = "cloud"
  r29_130 = "water"
  r29_130 = "rgb1"
  r29_130 = "rgb2"
  r29_130 = "cloud2"
  r28_130 = 0
  local r30_130 = "amb"
  r30_130 = "obj"
  r30_130 = "dir"
  r30_130 = "sky"
  r30_130 = "sun"
  r30_130 = "sprite"
  r30_130 = "shadow"
  r30_130 = "cloud"
  r30_130 = "water"
  r30_130 = "rgb1"
  r30_130 = "rgb2"
  r30_130 = "cloud2"
  r28_130 = 5
  r30_130 = "amb"
  r30_130 = "obj"
  r30_130 = "dir"
  r30_130 = "sky"
  r30_130 = "sun"
  r30_130 = "sprite"
  r30_130 = "shadow"
  r30_130 = "cloud"
  r30_130 = "water"
  r30_130 = "rgb1"
  r30_130 = "rgb2"
  r30_130 = "cloud2"
  r28_130 = 6
  r30_130 = "amb"
  r30_130 = "obj"
  r30_130 = "dir"
  r30_130 = "sky"
  r30_130 = "sun"
  r30_130 = "sprite"
  r30_130 = "shadow"
  r30_130 = "cloud"
  r30_130 = "water"
  r30_130 = "rgb1"
  r30_130 = "rgb2"
  r30_130 = "cloud2"
  r28_130 = 7
  r30_130 = "amb"
  r30_130 = "obj"
  r30_130 = "dir"
  r30_130 = "sky"
  r30_130 = "sun"
  r30_130 = "sprite"
  r30_130 = "shadow"
  r30_130 = "cloud"
  r30_130 = "water"
  r30_130 = "rgb1"
  r30_130 = "rgb2"
  r30_130 = "cloud2"
  r28_130 = 12
  r30_130 = "amb"
  r30_130 = "obj"
  r30_130 = "dir"
  r30_130 = "sky"
  r30_130 = "sun"
  r30_130 = "sprite"
  r30_130 = "shadow"
  r30_130 = "cloud"
  r30_130 = "water"
  r30_130 = "rgb1"
  r30_130 = "rgb2"
  r30_130 = "cloud2"
  r28_130 = 19
  r30_130 = "amb"
  r30_130 = "obj"
  r30_130 = "dir"
  r30_130 = "sky"
  r30_130 = "sun"
  r30_130 = "sprite"
  r30_130 = "shadow"
  r30_130 = "cloud"
  r30_130 = "water"
  r30_130 = "rgb1"
  r30_130 = "rgb2"
  r30_130 = "cloud2"
  r28_130 = 20
  r30_130 = "amb"
  r30_130 = "obj"
  r30_130 = "dir"
  r30_130 = "sky"
  r30_130 = "sun"
  r30_130 = "sprite"
  r30_130 = "shadow"
  r30_130 = "cloud"
  r30_130 = "water"
  r30_130 = "rgb1"
  r30_130 = "rgb2"
  r30_130 = "cloud2"
  r28_130 = 22
  r30_130 = "amb"
  r30_130 = "obj"
  r30_130 = "dir"
  r30_130 = "sky"
  r30_130 = "sun"
  r30_130 = "sprite"
  r30_130 = "shadow"
  r30_130 = "cloud"
  r30_130 = "water"
  r30_130 = "rgb1"
  r30_130 = "rgb2"
  r30_130 = "cloud2"
  r29_130 = 0
  local r31_130 = "amb"
  r31_130 = "obj"
  r31_130 = "dir"
  r31_130 = "sky"
  r31_130 = "sun"
  r31_130 = "sprite"
  r31_130 = "shadow"
  r31_130 = "cloud"
  r31_130 = "water"
  r31_130 = "rgb1"
  r31_130 = "rgb2"
  r31_130 = "cloud2"
  r29_130 = 5
  r31_130 = "amb"
  r31_130 = "obj"
  r31_130 = "dir"
  r31_130 = "sky"
  r31_130 = "sun"
  r31_130 = "sprite"
  r31_130 = "shadow"
  r31_130 = "cloud"
  r31_130 = "water"
  r31_130 = "rgb1"
  r31_130 = "rgb2"
  r31_130 = "cloud2"
  r29_130 = 6
  r31_130 = "amb"
  r31_130 = "obj"
  r31_130 = "dir"
  r31_130 = "sky"
  r31_130 = "sun"
  r31_130 = "sprite"
  r31_130 = "shadow"
  r31_130 = "cloud"
  r31_130 = "water"
  r31_130 = "rgb1"
  r31_130 = "rgb2"
  r31_130 = "cloud2"
  r29_130 = 7
  r31_130 = "amb"
  r31_130 = "obj"
  r31_130 = "dir"
  r31_130 = "sky"
  r31_130 = "sun"
  r31_130 = "sprite"
  r31_130 = "shadow"
  r31_130 = "cloud"
  r31_130 = "water"
  r31_130 = "rgb1"
  r31_130 = "rgb2"
  r31_130 = "cloud2"
  r29_130 = 12
  r31_130 = "amb"
  r31_130 = "obj"
  r31_130 = "dir"
  r31_130 = "sky"
  r31_130 = "sun"
  r31_130 = "sprite"
  r31_130 = "shadow"
  r31_130 = "cloud"
  r31_130 = "water"
  r31_130 = "rgb1"
  r31_130 = "rgb2"
  r31_130 = "cloud2"
  r29_130 = 19
  r31_130 = "amb"
  r31_130 = "obj"
  r31_130 = "dir"
  r31_130 = "sky"
  r31_130 = "sun"
  r31_130 = "sprite"
  r31_130 = "shadow"
  r31_130 = "cloud"
  r31_130 = "water"
  r31_130 = "rgb1"
  r31_130 = "rgb2"
  r31_130 = "cloud2"
  r29_130 = 20
  r31_130 = "amb"
  r31_130 = "obj"
  r31_130 = "dir"
  r31_130 = "sky"
  r31_130 = "sun"
  r31_130 = "sprite"
  r31_130 = "shadow"
  r31_130 = "cloud"
  r31_130 = "water"
  r31_130 = "rgb1"
  r31_130 = "rgb2"
  r31_130 = "cloud2"
  r29_130 = 22
  r31_130 = "amb"
  r31_130 = "obj"
  r31_130 = "dir"
  r31_130 = "sky"
  r31_130 = "sun"
  r31_130 = "sprite"
  r31_130 = "shadow"
  r31_130 = "cloud"
  r31_130 = "water"
  r31_130 = "rgb1"
  r31_130 = "rgb2"
  r31_130 = "cloud2"
  r28_130 = "hours"
  r30_130 = 0
  local r32_130 = "amb"
  r32_130 = "obj"
  r32_130 = "dir"
  r32_130 = "sky"
  r32_130 = "sun"
  r32_130 = "sprite"
  r32_130 = "shadow"
  r32_130 = "cloud"
  r32_130 = "water"
  r32_130 = "rgb1"
  r32_130 = "rgb2"
  r32_130 = "cloud2"
  r30_130 = 5
  r32_130 = "amb"
  r32_130 = "obj"
  r32_130 = "dir"
  r32_130 = "sky"
  r32_130 = "sun"
  r32_130 = "sprite"
  r32_130 = "shadow"
  r32_130 = "cloud"
  r32_130 = "water"
  r32_130 = "rgb1"
  r32_130 = "rgb2"
  r32_130 = "cloud2"
  r30_130 = 6
  r32_130 = "amb"
  r32_130 = "obj"
  r32_130 = "dir"
  r32_130 = "sky"
  r32_130 = "sun"
  r32_130 = "sprite"
  r32_130 = "shadow"
  r32_130 = "cloud"
  r32_130 = "water"
  r32_130 = "rgb1"
  r32_130 = "rgb2"
  r32_130 = "cloud2"
  r30_130 = 7
  r32_130 = "amb"
  r32_130 = "obj"
  r32_130 = "dir"
  r32_130 = "sky"
  r32_130 = "sun"
  r32_130 = "sprite"
  r32_130 = "shadow"
  r32_130 = "cloud"
  r32_130 = "water"
  r32_130 = "rgb1"
  r32_130 = "rgb2"
  r32_130 = "cloud2"
  r30_130 = 12
  r32_130 = "amb"
  r32_130 = "obj"
  r32_130 = "dir"
  r32_130 = "sky"
  r32_130 = "sun"
  r32_130 = "sprite"
  r32_130 = "shadow"
  r32_130 = "cloud"
  r32_130 = "water"
  r32_130 = "rgb1"
  r32_130 = "rgb2"
  r32_130 = "cloud2"
  r30_130 = 19
  r32_130 = "amb"
  r32_130 = "obj"
  r32_130 = "dir"
  r32_130 = "sky"
  r32_130 = "sun"
  r32_130 = "sprite"
  r32_130 = "shadow"
  r32_130 = "cloud"
  r32_130 = "water"
  r32_130 = "rgb1"
  r32_130 = "rgb2"
  r32_130 = "cloud2"
  r30_130 = 20
  r32_130 = "amb"
  r32_130 = "obj"
  r32_130 = "dir"
  r32_130 = "sky"
  r32_130 = "sun"
  r32_130 = "sprite"
  r32_130 = "shadow"
  r32_130 = "cloud"
  r32_130 = "water"
  r32_130 = "rgb1"
  r32_130 = "rgb2"
  r32_130 = "cloud2"
  r30_130 = 22
  r32_130 = "amb"
  r32_130 = "obj"
  r32_130 = "dir"
  r32_130 = "sky"
  r32_130 = "sun"
  r32_130 = "sprite"
  r32_130 = "shadow"
  r32_130 = "cloud"
  r32_130 = "water"
  r32_130 = "rgb1"
  r32_130 = "rgb2"
  r32_130 = "cloud2"
  weatherSAData = r4_130
  function onClientResourceStart(r0_131)
    -- line: [246, 262] id: 131
    bindKey("F4", "down", "team_change")
    bindKey("num_4", "down", "help_me")
    bindKey("b", "down", "gun")
    bindKey("F1", "down", "control_panel")
    bindKey("pause", "down", "pause")
    bindKey("f", "down", "weapon_pickup")
    bindKey("backspace", "down", "weapon_drop")
    bindKey("m", "down", "votemap_toggle")
    bindKey("F2", "down", "player_config")
    bindKey("u", "down", "chatbox", "Adminsay")
    bindKey("r", "down", "reload")
    bindKey("horn", "down", toggleGangDriveby)
    bindKey("vehicle_look_left", "down", switchGangDrivebyWeapon)
    bindKey("vehicle_look_right", "down", switchGangDrivebyWeapon)
    setTimer(callServerFunction, 50, 1, "refreshMaps", localPlayer)
  end
  function createAdminPanel()
    -- line: [263, 1164] id: 132
    admin_window = guiCreateWindow(xscreen * 0.5 - r0_130 * 0.5 - 80, yscreen * 0.5 - r1_130 * 0.5 - 15, r0_130 + 160, r1_130 + 30, "Tactics " .. getTacticsData("version") .. " - Gamemode Control Panel", false)
    guiWindowSetSizable(admin_window, false)
    config_list = guiCreateGridList(0.01, 0.05, 0.23, 0.39, true, admin_window)
    guiGridListSetSortingEnabled(config_list, false)
    guiGridListAddColumn(config_list, "Configurations", 0.8)
    config_flags = guiCreateEdit(0.01, 0.45, 0.23, 0.04, "", true, admin_window)
    guiEditSetReadOnly(config_flags, true)
    guiSetFont(config_flags, "default-small")
    config_delete = guiCreateButton(0.01, 0.5, 0.23, 0.04, "Delete selected", true, admin_window)
    guiSetFont(config_delete, "default-bold-small")
    guiSetProperty(config_delete, "NormalTextColour", "C0FF0000")
    config_save = guiCreateButton(0.01, 0.55, 0.23, 0.04, "Save as...", true, admin_window)
    guiSetFont(config_save, "default-bold-small")
    guiSetProperty(config_save, "NormalTextColour", "C000FF00")
    config_rename = guiCreateButton(0.01, 0.6, 0.23, 0.04, "Rename config...", true, admin_window)
    guiSetFont(config_rename, "default-bold-small")
    config_add = guiCreateButton(0.01, 0.65, 0.23, 0.04, "Insert from HOST...", true, admin_window)
    guiSetFont(config_add, "default-bold-small")
    window_expert = guiCreateCheckBox(0.01, 0.82, 0.23, 0.05, "", false, true, admin_window)
    temp = guiCreateLabel(0.15, 0, 1, 1, "Show Expert Options", true, window_expert)
    guiSetEnabled(temp, false)
    temp = guiCreateLabel(0.15, 0.5, 1, 1, "For advanced users only!", true, window_expert)
    guiSetFont(temp, "default-small")
    guiLabelSetColor(temp, 255, 0, 0)
    guiSetEnabled(temp, false)
    window_updates = guiCreateButton(0.01, 0.89, 0.23, 0.04, "Check for updates", true, admin_window)
    guiSetFont(window_updates, "default-bold-small")
    guiSetProperty(window_updates, "NormalTextColour", "C080FF00")
    window_close = guiCreateButton(0.01, 0.94, 0.23, 0.04, "Close panel", true, admin_window)
    guiSetFont(window_close, "default-bold-small")
    admin_tabs = guiCreateTabPanel(0.25, 0.05, 0.74, 0.94, true, admin_window)
    guiSetFont(admin_tabs, "default-small")
    guiSetProperty(admin_tabs, "TabTextPadding", "0.016")
    admin_tab_players = guiCreateTab("Players", admin_tabs)
    admin_tab_maps = guiCreateTab("Maps", admin_tabs)
    admin_tab_settings = guiCreateTab("Settings", admin_tabs)
    admin_tab_teams = guiCreateTab("Teams", admin_tabs)
    admin_tab_weapons = guiCreateTab("Weapons", admin_tabs)
    admin_tab_vehicles = guiCreateTab("Vehicles", admin_tabs)
    admin_tab_weather = guiCreateTab("Weather", admin_tabs)
    admin_tab_shooting = guiCreateTab("Shooting", admin_tabs)
    guiSetVisible(admin_tab_shooting, false)
    admin_tab_handling = guiCreateTab("Handling", admin_tabs)
    guiSetVisible(admin_tab_handling, false)
    admin_tab_anticheat = guiCreateTab("AC", admin_tabs)
    guiSetVisible(admin_tab_anticheat, false)
    player_list = guiCreateGridList(0.02, 0.02, 0.47, 0.96, true, admin_tab_players)
    guiGridListSetSortingEnabled(player_list, false)
    guiGridListSetSelectionMode(player_list, 1)
    player_id = guiGridListAddColumn(player_list, "ID", 0.15)
    player_name = guiGridListAddColumn(player_list, "Name", 0.5)
    player_status = guiGridListAddColumn(player_list, "Status", 0.2)
    player_info = guiCreateMemo(0.51, 0.02, 0.47, 0.18, "", true, admin_tab_players)
    guiMemoSetReadOnly(player_info, true)
    guiSetFont(player_info, "default-small")
    player_infocopy = guiCreateButton(0.79, 0.65, 0.2, 0.3, "Copy", true, player_info)
    guiSetAlpha(player_infocopy, 1)
    guiSetFont(player_infocopy, "default-bold-small")
    temp = guiCreateLabel(0.51, 0.19999999999999998, 0.47, 0.04, "For everybody", true, admin_tab_players)
    guiLabelSetHorizontalAlign(temp, "center")
    guiSetFont(temp, "default-bold-small")
    player_swapsides = guiCreateButton(0.51, 0.26, 0.23, 0.05, "Swap Sides", true, admin_tab_players)
    guiSetFont(player_swapsides, "default-bold-small")
    player_balancecombobox = guiCreateComboBox(0.75, 0.26, 0.23, 0.2, "", true, admin_tab_players)
    guiComboBoxAddItem(player_balancecombobox, "Lite")
    guiComboBoxAddItem(player_balancecombobox, "Select")
    player_balancebg = guiCreateStaticImage(0, 1, 85, 21, "images/color_pixel.png", false, player_balancecombobox)
    guiSetProperty(player_balancebg, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    guiSetProperty(player_balancebg, "AlwaysOnTop", "True")
    player_balance = guiCreateButton(0, 0, 1.2, 1, "Balance", true, player_balancebg)
    guiSetFont(player_balance, "default-bold-small")
    guiSetProperty(player_balance, "InheritsAlpha", "False")
    guiSetAlpha(player_balance, 1)
    player_resetstats = guiCreateButton(0.51, 0.32, 0.47, 0.05, "Reset Scores & Stats", true, admin_tab_players)
    guiSetFont(player_resetstats, "default-bold-small")
    player_healall = guiCreateButton(0.51, 0.38, 0.23, 0.05, "     Heal Players", true, admin_tab_players)
    guiSetFont(player_healall, "default-bold-small")
    guiSetEnabled(guiCreateStaticImage(5, 3, 16, 16, "images/health.png", false, player_healall), false)
    player_fixall = guiCreateButton(0.75, 0.38, 0.23, 0.05, "     Fix Vehicles", true, admin_tab_players)
    guiSetFont(player_fixall, "default-bold-small")
    guiSetEnabled(guiCreateStaticImage(5, 3, 16, 16, "images/car.png", false, player_fixall), false)
    temp = guiCreateLabel(0.51, 0.44, 0.47, 0.05, "For selected players", true, admin_tab_players)
    guiLabelSetHorizontalAlign(temp, "center")
    guiSetFont(temp, "default-bold-small")
    player_add = guiCreateButton(0.51, 0.5, 0.23, 0.05, "Add/Remove", true, admin_tab_players)
    guiSetFont(player_add, "default-bold-small")
    player_restore = guiCreateButton(0.75, 0.5, 0.23, 0.05, "     Restore", true, admin_tab_players)
    guiSetFont(player_restore, "default-bold-small")
    guiSetEnabled(guiCreateStaticImage(5, 3, 16, 16, "images/save.png", false, player_restore), false)
    player_setteamcombobox = guiCreateComboBox(0.51, 0.56, 0.23, 0.3, getTeamName(getElementsByType("team")[1]), true, admin_tab_players)
    player_setteambg = guiCreateStaticImage(0, 1, 85, 21, "images/color_pixel.png", false, player_setteamcombobox)
    guiSetProperty(player_setteambg, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    guiSetProperty(player_setteambg, "AlwaysOnTop", "True")
    player_setteam = guiCreateButton(0, 0, 1.2, 1, getTeamName(getElementsByType("team")[1]), true, player_setteambg)
    guiSetFont(player_setteam, "default-bold-small")
    guiSetProperty(player_setteam, "InheritsAlpha", "False")
    guiSetAlpha(player_setteam, 1)
    player_specskinbtn = guiCreateButton(0.75, 0.56, 0.23, 0.05, "     Spectate Skin", true, admin_tab_players)
    guiSetFont(player_specskinbtn, "default-bold-small")
    player_specskin = guiCreateCheckBox(5, 3, 16, 16, "", false, false, player_specskinbtn)
    player_heal = guiCreateButton(0.51, 0.62, 0.23, 0.05, "     Heal", true, admin_tab_players)
    guiSetFont(player_heal, "default-bold-small")
    guiSetEnabled(guiCreateStaticImage(5, 3, 16, 16, "images/health.png", false, player_heal), false)
    player_fix = guiCreateButton(0.75, 0.62, 0.23, 0.05, "     Fix", true, admin_tab_players)
    guiSetFont(player_fix, "default-bold-small")
    guiSetEnabled(guiCreateStaticImage(5, 3, 16, 16, "images/car.png", false, player_fix), false)
    player_gunmenu = guiCreateButton(0.51, 0.6799999999999999, 0.23, 0.05, "     Gun Menu", true, admin_tab_players)
    guiSetFont(player_gunmenu, "default-bold-small")
    guiSetEnabled(guiCreateStaticImage(5, 3, 16, 16, "images/frag.png", false, player_gunmenu), false)
    player_takescreencombobox = guiCreateComboBox(0.75, 0.6799999999999999, 0.23, 0.37, "320x240:30%", true, admin_tab_players)
    guiComboBoxAddItem(player_takescreencombobox, "320x240:30%")
    guiComboBoxAddItem(player_takescreencombobox, "640x480:45%")
    guiComboBoxAddItem(player_takescreencombobox, "800x600:60%")
    guiComboBoxAddItem(player_takescreencombobox, "1024x768:75%")
    guiComboBoxAddItem(player_takescreencombobox, "My screens")
    player_takescreenbg = guiCreateStaticImage(0, 1, 85, 21, "images/color_pixel.png", false, player_takescreencombobox)
    guiSetProperty(player_takescreenbg, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    guiSetProperty(player_takescreenbg, "AlwaysOnTop", "True")
    player_takescreen = guiCreateButton(0, 0, 1.1, 1, "Screen Shot", true, player_takescreenbg)
    guiSetFont(player_takescreen, "default-bold-small")
    guiSetProperty(player_takescreen, "InheritsAlpha", "False")
    guiSetAlpha(player_takescreen, 1)
    player_redirect = guiCreateButton(0.51, 0.74, 0.23, 0.05, "Redirect", true, admin_tab_players)
    guiSetFont(player_redirect, "default-bold-small")
    player_pause = guiCreateButton(0.51, 0.9199999999999999, 0.47, 0.05, "", true, admin_tab_players)
    guiSetFont(player_pause, "default-bold-small")
    if not isRoundPaused() then
      guiSetText(player_pause, "Pause")
      guiSetProperty(player_pause, "NormalTextColour", "C0FF8000")
    else
      guiSetText(player_pause, "Unpause")
      guiSetProperty(player_pause, "NormalTextColour", "C00080FF")
    end
    maps_search = guiCreateEdit(0.02, 0.02, 0.47, 0.05, "", true, admin_tab_maps)
    guiSetEnabled(guiCreateStaticImage(0.91, 0.1, 0.08, 0.8, "images/search.png", true, maps_search), false)
    server_maps = guiCreateGridList(0.02, 0.08, 0.47, 0.56, true, admin_tab_maps)
    guiGridListSetSortingEnabled(server_maps, false)
    guiGridListAddColumn(server_maps, "Mode", 0.3)
    guiGridListAddColumn(server_maps, "Name", 0.5)
    guiGridListSetSelectionMode(server_maps, 1)
    maps_include = guiCreateCheckBox(0.02, 0.65, 0.47, 0.05, "Include Disabled Maps", true, true, admin_tab_maps)
    maps_refresh = guiCreateButton(0.02, 0.71, 0.47, 0.05, "Refresh Maps Cache", true, admin_tab_maps)
    guiSetFont(maps_refresh, "default-bold-small")
    guiSetEnabled(maps_refresh, false)
    temp = guiCreateLabel(0.05, 0, 0.9, 1, "Hard!", true, maps_refresh)
    guiSetFont(temp, "default-small")
    guiLabelSetColor(temp, 255, 0, 0)
    guiLabelSetHorizontalAlign(temp, "right")
    guiLabelSetVerticalAlign(temp, "center")
    guiSetEnabled(temp, false)
    maps_disable = guiCreateButton(0.02, 0.77, 0.23, 0.05, "Enable/Disable", true, admin_tab_maps)
    guiSetFont(maps_disable, "default-bold-small")
    maps_end = guiCreateButton(0.26, 0.77, 0.23, 0.05, "End", true, admin_tab_maps)
    guiSetFont(maps_end, "default-bold-small")
    maps_next = guiCreateButton(0.02, 0.83, 0.23, 0.05, "Set next map", true, admin_tab_maps)
    guiSetFont(maps_next, "default-bold-small")
    maps_cancelnext = guiCreateButton(0.26, 0.83, 0.23, 0.05, "Cancel next", true, admin_tab_maps)
    guiSetFont(maps_cancelnext, "default-bold-small")
    maps_switch = guiCreateButton(0.02, 0.89, 0.47, 0.05, "Add >", true, admin_tab_maps)
    guiSetFont(maps_switch, "default-bold-small")
    temp = guiCreateLabel(0.51, 0.02, 0.24, 0.05, "Automatics Rounds", true, admin_tab_maps)
    guiSetFont(temp, "default-bold-small")
    guiLabelSetVerticalAlign(temp, "center")
    cycler_automatics = guiCreateComboBox(0.75, 0.02, 0.23, 0.3, "Lobby", true, admin_tab_maps)
    guiComboBoxAddItem(cycler_automatics, "Lobby")
    guiComboBoxAddItem(cycler_automatics, "Cycle")
    guiComboBoxAddItem(cycler_automatics, "Voting")
    guiComboBoxAddItem(cycler_automatics, "Random")
    server_cycler = guiCreateGridList(0.51, 0.08, 0.47, 0.68, true, admin_tab_maps)
    guiGridListSetSortingEnabled(server_cycler, false)
    guiGridListAddColumn(server_cycler, "#", 0.08)
    guiGridListAddColumn(server_cycler, "Mode", 0.22)
    guiGridListAddColumn(server_cycler, "Name", 0.5)
    guiGridListSetSelectionMode(server_cycler, 1)
    cycler_moveup = guiCreateButton(0.51, 0.77, 0.23, 0.05, "Move Up", true, admin_tab_maps)
    guiSetFont(cycler_moveup, "default-bold-small")
    cycler_randomize = guiCreateButton(0.75, 0.77, 0.23, 0.05, "Randomize", true, admin_tab_maps)
    guiSetFont(cycler_randomize, "default-bold-small")
    cycler_movedown = guiCreateButton(0.51, 0.83, 0.23, 0.05, "Move Down", true, admin_tab_maps)
    guiSetFont(cycler_movedown, "default-bold-small")
    cycler_clear = guiCreateButton(0.75, 0.83, 0.23, 0.05, "Clear", true, admin_tab_maps)
    guiSetFont(cycler_clear, "default-bold-small")
    cycler_switch = guiCreateButton(0.51, 0.89, 0.47, 0.05, "< Remove", true, admin_tab_maps)
    guiSetFont(cycler_switch, "default-bold-small")
    temp = guiCreateLabel(0.02, 0.95, 0.96, 0.04, "Double-click to start map", true, admin_tab_maps)
    guiSetFont(temp, "default-small")
    guiLabelSetHorizontalAlign(temp, "center")
    modes_list = guiCreateGridList(0.02, 0.02, 0.3, 0.91, true, admin_tab_settings)
    guiGridListSetSortingEnabled(modes_list, false)
    guiGridListAddColumn(modes_list, "Section", 0.8)
    guiGridListSetItemText(modes_list, guiGridListAddRow(modes_list), 1, "Tactics", true, false)
    guiGridListSetItemText(modes_list, guiGridListAddRow(modes_list), 1, "settings", false, false)
    guiGridListSetItemText(modes_list, guiGridListAddRow(modes_list), 1, "glitches", false, false)
    guiGridListSetItemText(modes_list, guiGridListAddRow(modes_list), 1, "cheats", false, false)
    guiGridListSetItemText(modes_list, guiGridListAddRow(modes_list), 1, "limites", false, false)
    guiGridListSetItemText(modes_list, guiGridListAddRow(modes_list), 1, "Modes", true, false)
    modes_disable = guiCreateButton(0.02, 0.94, 0.3, 0.04, "Enable / Disable", true, admin_tab_settings)
    guiSetFont(modes_disable, "default-bold-small")
    modes_rules = guiCreateGridList(0.33, 0.02, 0.65, 0.91, true, admin_tab_settings)
    guiGridListSetSortingEnabled(modes_rules, false)
    guiGridListAddColumn(modes_rules, "Rule", 0.45)
    guiGridListAddColumn(modes_rules, "Value", 0.45)
    temp = guiCreateLabel(0.33, 0.95, 0.65, 0.04, "Double-click to edit rule", true, admin_tab_settings)
    guiSetFont(temp, "default-small")
    guiLabelSetHorizontalAlign(temp, "center")
    weapons_scrollerbg = guiCreateGridList(9, 9, 288, 430, false, admin_tab_weapons)
    weapons_scroller = guiCreateScrollPane(3, 3, 284, 425, false, weapons_scrollerbg)
    weapons_items = {}
    weapons_adding = guiCreateButton(0, 10, 64, 64, "Add", false, weapons_scroller)
    guiSetFont(weapons_adding, "default-bold-small")
    guiSetProperty(weapons_adding, "NormalTextColour", "C000FF00")
    sortWeaponNames = {}
    for r3_132 in pairs(convertWeaponNamesToID) do
      table.insert(sortWeaponNames, r3_132)
    end
    local r0_132 = {
      [2] = 1,
      [3] = 2,
      [4] = 2,
      [5] = 3,
      [6] = 3,
    }
    table.sort(sortWeaponNames, function(r0_133, r1_133)
      -- line: [490, 498] id: 133
      local r2_133 = convertWeaponNamesToID[r0_133] or 46
      local r3_133 = convertWeaponNamesToID[r1_133] or 46
      local r4_133 = getSlotFromWeapon(r2_133)
      local r5_133 = getSlotFromWeapon(r3_133)
      local r6_133 = r0_132[r4_133] or 4
      local r7_133 = r0_132[r5_133] or 4
      local r8_133 = nil	-- notice: implicit variable refs by block#[13]
      if r6_133 ~= r7_133 or r2_133 >= r3_133 then
        r8_133 = r6_133 < r7_133
      else
        goto label_33	-- block#12 is visited secondly
      end
      return r8_133
    end)
    weapons_addnames = guiCreateComboBox(302, 9, 161, 300, sortWeaponNames[1], false, admin_tab_weapons)
    for r4_132, r5_132 in ipairs(sortWeaponNames) do
      guiComboBoxAddItem(weapons_addnames, r5_132)
    end
    weapons_addnamesbg = guiCreateStaticImage(0, 0, 138, 22, "images/color_pixel.png", false, weapons_addnames)
    guiSetProperty(weapons_addnamesbg, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    guiSetProperty(weapons_addnamesbg, "AlwaysOnTop", "True")
    weapons_addname = guiCreateEdit(0, 0, 1.1, 1, sortWeaponNames[1], true, weapons_addnamesbg)
    guiSetProperty(weapons_addname, "InheritsAlpha", "False")
    guiSetAlpha(weapons_addname, 1)
    weapons_addicon = guiCreateStaticImage(350, 36, 64, 64, "images/hud/" .. sortWeaponNames[1] .. ".png", false, admin_tab_weapons)
    guiSetEnabled(weapons_addicon, false)
    temp = guiCreateLabel(302, 106, 80, 22, "Ammo", false, admin_tab_weapons)
    guiSetEnabled(temp, false)
    weapons_addammo = guiCreateEdit(388, 104, 75, 22, "", false, admin_tab_weapons)
    guiEditSetMaxLength(weapons_addammo, 5)
    temp = guiCreateLabel(302, 130, 80, 22, "Limit", false, admin_tab_weapons)
    guiSetEnabled(temp, false)
    weapons_addlimit = guiCreateEdit(388, 128, 75, 22, "", false, admin_tab_weapons)
    guiEditSetMaxLength(weapons_addlimit, 5)
    temp = guiCreateLabel(302, 154, 80, 22, "Cost", false, admin_tab_weapons)
    guiSetEnabled(temp, false)
    weapons_addcost = guiCreateEdit(388, 152, 75, 22, "$", false, admin_tab_weapons)
    guiEditSetMaxLength(weapons_addcost, 7)
    temp = guiCreateLabel(302, 178, 80, 22, "Slot", false, admin_tab_weapons)
    guiSetEnabled(temp, false)
    weapons_addslot = guiCreateEdit(388, 176, 75, 22, "", false, admin_tab_weapons)
    guiEditSetMaxLength(weapons_addslot, 5)
    weapons_save = guiCreateButton(302, 200, 161, 22, "Add/Save", false, admin_tab_weapons)
    guiSetFont(weapons_save, "default-bold-small")
    guiSetProperty(weapons_save, "NormalTextColour", "C000FF00")
    weapons_remove = guiCreateButton(302, 224, 161, 22, "Remove", false, admin_tab_weapons)
    guiSetFont(weapons_remove, "default-bold-small")
    guiSetProperty(weapons_remove, "NormalTextColour", "C0FF0000")
    temp = guiCreateLabel(302, 394, 80, 22, "Max Slots", false, admin_tab_weapons)
    guiSetEnabled(temp, false)
    weapons_slots = guiCreateEdit(387, 392, 75, 22, tostring(getTacticsData("weapon_slots") or "0"), false, admin_tab_weapons)
    guiEditSetMaxLength(weapons_slots, 5)
    weapons_apply = guiCreateButton(302, 416, 161, 22, "Apply", false, admin_tab_weapons)
    guiSetFont(weapons_apply, "default-bold-small")
    guiSetProperty(weapons_apply, "NormalTextColour", "C000FF00")
    shooting_weapon = guiCreateComboBox(0.02, 0.02, 0.54, 0.85, getWeaponNameFromID(22), true, admin_tab_shooting)
    guiComboBoxAddItem(shooting_weapon, getWeaponNameFromID(22))
    guiComboBoxAddItem(shooting_weapon, getWeaponNameFromID(23))
    guiComboBoxAddItem(shooting_weapon, getWeaponNameFromID(24))
    guiComboBoxAddItem(shooting_weapon, getWeaponNameFromID(25))
    guiComboBoxAddItem(shooting_weapon, getWeaponNameFromID(26))
    guiComboBoxAddItem(shooting_weapon, getWeaponNameFromID(27))
    guiComboBoxAddItem(shooting_weapon, getWeaponNameFromID(28))
    guiComboBoxAddItem(shooting_weapon, getWeaponNameFromID(32))
    guiComboBoxAddItem(shooting_weapon, getWeaponNameFromID(29))
    guiComboBoxAddItem(shooting_weapon, getWeaponNameFromID(30))
    guiComboBoxAddItem(shooting_weapon, getWeaponNameFromID(31))
    guiComboBoxAddItem(shooting_weapon, getWeaponNameFromID(33))
    guiComboBoxAddItem(shooting_weapon, getWeaponNameFromID(34))
    guiComboBoxAddItem(shooting_weapon, getWeaponNameFromID(35))
    guiComboBoxAddItem(shooting_weapon, getWeaponNameFromID(36))
    guiComboBoxAddItem(shooting_weapon, getWeaponNameFromID(37))
    guiComboBoxAddItem(shooting_weapon, getWeaponNameFromID(38))
    guiComboBoxAddItem(shooting_weapon, getWeaponNameFromID(41))
    guiComboBoxAddItem(shooting_weapon, getWeaponNameFromID(42))
    shooting_ok = guiCreateButton(0.57, 0.02, 0.2, 0.052, "Apply", true, admin_tab_shooting)
    guiSetFont(shooting_ok, "default-bold-small")
    guiSetProperty(shooting_ok, "NormalTextColour", "C000FF00")
    shooting_reset = guiCreateButton(0.78, 0.02, 0.2, 0.052, "Set Original", true, admin_tab_shooting)
    guiSetFont(shooting_reset, "default-bold-small")
    guiSetProperty(shooting_reset, "NormalTextColour", "C0FFFF00")
    shooting_generalbg = guiCreateStaticImage(0.02, 0.1, 0.18, 0.08, "images/color_pixel.png", true, admin_tab_shooting)
    guiSetProperty(shooting_generalbg, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    shooting_general = guiCreateButton(0, 0, 1.1, 1, "Properties", true, shooting_generalbg)
    guiSetFont(shooting_general, "default-bold-small")
    guiSetAlpha(shooting_general, 1)
    guiSetProperty(shooting_general, "NormalTextColour", "FFFFFFFF")
    shooting_animationbg = guiCreateStaticImage(0.02, 0.18, 0.18, 0.08, "images/color_pixel.png", true, admin_tab_shooting)
    guiSetProperty(shooting_animationbg, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    shooting_animation = guiCreateButton(0, 0, 1.1, 1, "Animation", true, shooting_animationbg)
    guiSetFont(shooting_animation, "default-bold-small")
    guiSetAlpha(shooting_animation, 1)
    shooting_flagsbg = guiCreateStaticImage(0.02, 0.26, 0.18, 0.08, "images/color_pixel.png", true, admin_tab_shooting)
    guiSetProperty(shooting_flagsbg, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    shooting_flag = guiCreateButton(0, 0, 1.1, 1, "Type", true, shooting_flagsbg)
    guiSetFont(shooting_flag, "default-bold-small")
    guiSetAlpha(shooting_flag, 1)
    shooting_generalpane = guiCreateGridList(0.2, 0.09, 0.78, 0.89, true, admin_tab_shooting)
    guiCreateLabel(0.05, 0.025, 0.38, 0.05, "Weapon Range", true, shooting_generalpane)
    shooting_weapon_range = guiCreateEdit(0.45, 0.02, 0.3, 0.055, "", true, shooting_generalpane)
    guiCreateLabel(0.77, 0.025, 0.26, 0.05, "m", true, shooting_generalpane)
    guiCreateLabel(0.05, 0.08499999999999999, 0.38, 0.05, "Target Range", true, shooting_generalpane)
    shooting_target_range = guiCreateEdit(0.45, 0.08, 0.3, 0.055, "", true, shooting_generalpane)
    guiCreateLabel(0.77, 0.08499999999999999, 0.26, 0.05, "m", true, shooting_generalpane)
    guiCreateLabel(0.05, 0.145, 0.38, 0.05, "Accuracy", true, shooting_generalpane)
    shooting_accuracy = guiCreateEdit(0.45, 0.13999999999999999, 0.3, 0.055, "", true, shooting_generalpane)
    guiCreateLabel(0.77, 0.145, 0.26, 0.05, "?", true, shooting_generalpane)
    guiCreateLabel(0.05, 0.205, 0.38, 0.05, "Damage", true, shooting_generalpane)
    shooting_damage = guiCreateEdit(0.45, 0.19999999999999998, 0.3, 0.055, "", true, shooting_generalpane)
    guiCreateLabel(0.77, 0.205, 0.26, 0.05, "hp", true, shooting_generalpane)
    guiCreateLabel(0.05, 0.265, 0.38, 0.05, "Ammo in Clip", true, shooting_generalpane)
    shooting_maximum_clip = guiCreateEdit(0.45, 0.26, 0.3, 0.055, "", true, shooting_generalpane)
    guiCreateLabel(0.77, 0.265, 0.26, 0.05, "", true, shooting_generalpane)
    guiCreateLabel(0.05, 0.325, 0.38, 0.05, "Move Speed", true, shooting_generalpane)
    shooting_move_speed = guiCreateEdit(0.45, 0.32, 0.3, 0.055, "", true, shooting_generalpane)
    guiCreateLabel(0.77, 0.325, 0.26, 0.05, "% / 100", true, shooting_generalpane)
    shooting_animationpane = guiCreateGridList(0.2, 0.09, 0.78, 0.89, true, admin_tab_shooting)
    guiSetVisible(shooting_animationpane, false)
    guiCreateLabel(0.05, 0.025, 0.38, 0.05, "Start", true, shooting_animationpane)
    shooting_anim_loop_start = guiCreateEdit(0.45, 0.02, 0.3, 0.055, "", true, shooting_animationpane)
    guiCreateLabel(0.77, 0.025, 0.26, 0.05, "sec", true, shooting_animationpane)
    guiCreateLabel(0.05, 0.08499999999999999, 0.38, 0.05, "End", true, shooting_animationpane)
    shooting_anim_loop_stop = guiCreateEdit(0.45, 0.08, 0.3, 0.055, "", true, shooting_animationpane)
    guiCreateLabel(0.77, 0.08499999999999999, 0.26, 0.05, "sec", true, shooting_animationpane)
    guiCreateLabel(0.05, 0.145, 0.38, 0.05, "Bullet Fire", true, shooting_animationpane)
    shooting_anim_loop_bullet_fire = guiCreateEdit(0.45, 0.13999999999999999, 0.3, 0.055, "", true, shooting_animationpane)
    guiCreateLabel(0.77, 0.145, 0.26, 0.05, "sec", true, shooting_animationpane)
    guiCreateLabel(0.05, 0.205, 0.38, 0.05, "Ducked Start", true, shooting_animationpane)
    shooting_anim2_loop_start = guiCreateEdit(0.45, 0.19999999999999998, 0.3, 0.055, "", true, shooting_animationpane)
    guiCreateLabel(0.77, 0.205, 0.26, 0.05, "sec", true, shooting_animationpane)
    guiCreateLabel(0.05, 0.265, 0.38, 0.05, "Ducked End", true, shooting_animationpane)
    shooting_anim2_loop_stop = guiCreateEdit(0.45, 0.26, 0.3, 0.055, "", true, shooting_animationpane)
    guiCreateLabel(0.77, 0.265, 0.26, 0.05, "sec", true, shooting_animationpane)
    guiCreateLabel(0.05, 0.325, 0.38, 0.05, "Ducked Bullet Fire", true, shooting_animationpane)
    shooting_anim2_loop_bullet_fire = guiCreateEdit(0.45, 0.32, 0.3, 0.055, "", true, shooting_animationpane)
    guiCreateLabel(0.77, 0.325, 0.26, 0.05, "sec", true, shooting_animationpane)
    guiCreateLabel(0.05, 0.385, 0.38, 0.05, "Breakout Time", true, shooting_animationpane)
    shooting_anim_breakout_time = guiCreateEdit(0.45, 0.38, 0.3, 0.055, "", true, shooting_animationpane)
    guiCreateLabel(0.77, 0.385, 0.26, 0.05, "sec", true, shooting_animationpane)
    shooting_flagpane = guiCreateGridList(0.2, 0.09, 0.78, 0.89, true, admin_tab_shooting)
    guiSetVisible(shooting_flagpane, false)
    shooting_flags = {
      {},
      {},
      {},
      {},
      {}
    }
    shooting_flags[1][1] = guiCreateCheckBox(0.05, 0.02, 0.45, 0.04, "Joypad aim", false, true, shooting_flagpane)
    shooting_flags[1][2] = guiCreateCheckBox(0.05, 0.07, 0.45, 0.04, "Running aim", false, true, shooting_flagpane)
    shooting_flags[1][4] = guiCreateCheckBox(0.05, 0.12000000000000001, 0.45, 0.04, "1st person", false, true, shooting_flagpane)
    shooting_flags[1][8] = guiCreateCheckBox(0.05, 0.17, 0.45, 0.04, "Free aiming", false, true, shooting_flagpane)
    shooting_flags[2][1] = guiCreateCheckBox(0.05, 0.24000000000000002, 0.45, 0.04, "Move and aim", false, true, shooting_flagpane)
    shooting_flags[2][2] = guiCreateCheckBox(0.05, 0.29, 0.45, 0.04, "Move and fire", false, true, shooting_flagpane)
    shooting_flags[2][4] = guiCreateCheckBox(0.05, 0.34, 0.45, 0.04, "[???]", false, true, shooting_flagpane)
    shooting_flags[2][8] = guiCreateCheckBox(0.05, 0.39, 0.45, 0.04, "[???]", false, true, shooting_flagpane)
    shooting_flags[3][1] = guiCreateCheckBox(0.05, 0.46, 0.45, 0.04, "Is throwing", false, true, shooting_flagpane)
    shooting_flags[3][2] = guiCreateCheckBox(0.05, 0.51, 0.45, 0.04, "Heavy weapon", false, true, shooting_flagpane)
    shooting_flags[3][4] = guiCreateCheckBox(0.05, 0.56, 0.45, 0.04, "Without delay", false, true, shooting_flagpane)
    shooting_flags[3][8] = guiCreateCheckBox(0.05, 0.6100000000000001, 0.45, 0.04, "2x guns", false, true, shooting_flagpane)
    shooting_flags[4][1] = guiCreateCheckBox(0.05, 0.68, 0.45, 0.04, "Has reload", false, true, shooting_flagpane)
    shooting_flags[4][2] = guiCreateCheckBox(0.05, 0.73, 0.45, 0.04, "Has crouching", false, true, shooting_flagpane)
    shooting_flags[4][4] = guiCreateCheckBox(0.05, 0.78, 0.45, 0.04, "[???]", false, true, shooting_flagpane)
    shooting_flags[4][8] = guiCreateCheckBox(0.05, 0.83, 0.45, 0.04, "Full reload time", false, true, shooting_flagpane)
    triggerEvent("onClientGUIComboBoxAccepted", shooting_weapon)
    local r1_132 = {}
    for r5_132 = 400, 611, 1 do
      if getVehicleNameFromModel(r5_132) and 0 < #getVehicleNameFromModel(r5_132) then
        table.insert(r1_132, getVehicleNameFromModel(r5_132))
      end
    end
    table.sort(r1_132, function(r0_134, r1_134)
      -- line: [660, 660] id: 134
      return r0_134 < r1_134
    end)
    handling_model = guiCreateComboBox(0.02, 0.02, 0.54, 0.85, getVehicleNameFromModel(411), true, admin_tab_handling)
    for r5_132, r6_132 in ipairs(r1_132) do
      guiComboBoxAddItem(handling_model, r6_132)
    end
    handling_ok = guiCreateButton(0.57, 0.02, 0.2, 0.052, "Apply", true, admin_tab_handling)
    guiSetFont(handling_ok, "default-bold-small")
    guiSetProperty(handling_ok, "NormalTextColour", "C000FF00")
    handling_reset = guiCreateButton(0.78, 0.02, 0.2, 0.052, "Set Original", true, admin_tab_handling)
    guiSetFont(handling_reset, "default-bold-small")
    guiSetProperty(handling_reset, "NormalTextColour", "C0FFFF00")
    handling_generalbg = guiCreateStaticImage(0.02, 0.1, 0.18, 0.08, "images/color_pixel.png", true, admin_tab_handling)
    guiSetProperty(handling_generalbg, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    handling_general = guiCreateButton(0, 0, 1.1, 1, "Body", true, handling_generalbg)
    guiSetFont(handling_general, "default-bold-small")
    guiSetAlpha(handling_general, 1)
    guiSetProperty(handling_general, "NormalTextColour", "FFFFFFFF")
    handling_enginebg = guiCreateStaticImage(0.02, 0.18, 0.18, 0.08, "images/color_pixel.png", true, admin_tab_handling)
    guiSetProperty(handling_enginebg, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    handling_engine = guiCreateButton(0, 0, 1.1, 1, "Engine", true, handling_enginebg)
    guiSetFont(handling_engine, "default-bold-small")
    guiSetAlpha(handling_engine, 1)
    handling_wheelsbg = guiCreateStaticImage(0.02, 0.26, 0.18, 0.08, "images/color_pixel.png", true, admin_tab_handling)
    guiSetProperty(handling_wheelsbg, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    handling_wheels = guiCreateButton(0, 0, 1.1, 1, "Wheels", true, handling_wheelsbg)
    guiSetFont(handling_wheels, "default-bold-small")
    guiSetAlpha(handling_wheels, 1)
    handling_suspensionbg = guiCreateStaticImage(0.02, 0.33999999999999997, 0.18, 0.08, "images/color_pixel.png", true, admin_tab_handling)
    guiSetProperty(handling_suspensionbg, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    handling_suspension = guiCreateButton(0, 0, 1.1, 1, "Suspension", true, handling_suspensionbg)
    guiSetFont(handling_suspension, "default-bold-small")
    guiSetAlpha(handling_suspension, 1)
    handling_modelflagbg = guiCreateStaticImage(0.02, 0.42000000000000004, 0.18, 0.08, "images/color_pixel.png", true, admin_tab_handling)
    guiSetProperty(handling_modelflagbg, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    handling_modelflag = guiCreateButton(0, 0, 1.1, 1, "Model", true, handling_modelflagbg)
    guiSetFont(handling_modelflag, "default-bold-small")
    guiSetAlpha(handling_modelflag, 1)
    handling_handlingflagbg = guiCreateStaticImage(0.02, 0.5, 0.18, 0.08, "images/color_pixel.png", true, admin_tab_handling)
    guiSetProperty(handling_handlingflagbg, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    handling_handlingflag = guiCreateButton(0, 0, 1.1, 1, "Handling", true, handling_handlingflagbg)
    guiSetFont(handling_handlingflag, "default-bold-small")
    guiSetAlpha(handling_handlingflag, 1)
    handling_sirensbg = guiCreateStaticImage(0.02, 0.58, 0.18, 0.08, "images/color_pixel.png", true, admin_tab_handling)
    guiSetProperty(handling_sirensbg, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    handling_sirens = guiCreateButton(0, 0, 1.1, 1, "Sirens", true, handling_sirensbg)
    guiSetFont(handling_sirens, "default-bold-small")
    guiSetAlpha(handling_sirens, 1)
    handling_generalpane = guiCreateGridList(0.2, 0.09, 0.78, 0.89, true, admin_tab_handling)
    guiCreateLabel(0.05, 0.025, 0.38, 0.05, "Mass", true, handling_generalpane)
    handling_mass = guiCreateEdit(0.45, 0.02, 0.3, 0.055, "", true, handling_generalpane)
    guiCreateLabel(0.77, 0.025, 0.26, 0.05, "kg", true, handling_generalpane)
    guiCreateLabel(0.05, 0.08499999999999999, 0.38, 0.05, "Turn Mass", true, handling_generalpane)
    handling_turnmass = guiCreateEdit(0.45, 0.08, 0.3, 0.055, "", true, handling_generalpane)
    guiCreateLabel(0.77, 0.08499999999999999, 0.26, 0.05, "kg * m²", true, handling_generalpane)
    guiCreateLabel(0.05, 0.145, 0.38, 0.05, "Drag Coefficient", true, handling_generalpane)
    handling_dragcoeff = guiCreateEdit(0.45, 0.13999999999999999, 0.3, 0.055, "", true, handling_generalpane)
    guiCreateLabel(0.77, 0.145, 0.26, 0.05, "", true, handling_generalpane)
    temp = guiCreateLabel(0.05, 0.205, 0.3, 0.16, "Center of Mass", true, handling_generalpane)
    guiLabelSetVerticalAlign(temp, "center")
    guiLabelSetHorizontalAlign(temp, "left", true)
    guiLabelSetHorizontalAlign(guiCreateLabel(0.05, 0.205, 0.38, 0.05, "in Width", true, handling_generalpane), "right")
    guiLabelSetHorizontalAlign(guiCreateLabel(0.05, 0.265, 0.38, 0.05, "in Length", true, handling_generalpane), "right")
    guiLabelSetHorizontalAlign(guiCreateLabel(0.05, 0.325, 0.38, 0.05, "in Height", true, handling_generalpane), "right")
    handling_centerofmass_x = guiCreateEdit(0.45, 0.19999999999999998, 0.3, 0.055, "", true, handling_generalpane)
    guiCreateLabel(0.77, 0.205, 0.26, 0.05, "m (+ in right)", true, handling_generalpane)
    handling_centerofmass_y = guiCreateEdit(0.45, 0.26, 0.3, 0.055, "", true, handling_generalpane)
    guiCreateLabel(0.77, 0.265, 0.26, 0.05, "m (+ in front)", true, handling_generalpane)
    handling_centerofmass_z = guiCreateEdit(0.45, 0.32, 0.3, 0.055, "", true, handling_generalpane)
    guiCreateLabel(0.77, 0.325, 0.26, 0.05, "m (+ in top)", true, handling_generalpane)
    guiCreateLabel(0.05, 0.385, 0.38, 0.05, "Percent Submerged", true, handling_generalpane)
    handling_percentsubmerged = guiCreateEdit(0.45, 0.38, 0.3, 0.055, "", true, handling_generalpane)
    guiCreateLabel(0.77, 0.385, 0.26, 0.05, "%", true, handling_generalpane)
    guiCreateLabel(0.05, 0.445, 0.38, 0.05, "Seat Offset Distance", true, handling_generalpane)
    handling_seatoffsetdistance = guiCreateEdit(0.45, 0.44, 0.3, 0.055, "", true, handling_generalpane)
    guiCreateLabel(0.77, 0.445, 0.26, 0.05, "m", true, handling_generalpane)
    guiCreateLabel(0.05, 0.505, 0.38, 0.05, "Collision Damage Multiplier", true, handling_generalpane)
    handling_collisiondamagemultiplier = guiCreateEdit(0.45, 0.5, 0.3, 0.055, "", true, handling_generalpane)
    guiCreateLabel(0.77, 0.505, 0.26, 0.05, "% / 100", true, handling_generalpane)
    guiCreateLabel(0.05, 0.595, 0.38, 0.05, "Variants", true, handling_generalpane)
    handling_variant1 = guiCreateComboBox(0.45, 0.56, 0.3, 0.2, "Random", true, handling_generalpane)
    guiComboBoxAddItem(handling_variant1, "Random")
    handling_variant2 = guiCreateComboBox(0.45, 0.62, 0.3, 0.2, "Random", true, handling_generalpane)
    guiComboBoxAddItem(handling_variant2, "Random")
    guiCreateLabel(0.77, 0.5650000000000001, 0.26, 0.05, "", true, handling_generalpane)
    handling_enginepane = guiCreateGridList(0.2, 0.09, 0.78, 0.89, true, admin_tab_handling)
    guiSetVisible(handling_enginepane, false)
    guiCreateLabel(0.05, 0.025, 0.38, 0.05, "Number of Gears", true, handling_enginepane)
    handling_numberofgears = guiCreateEdit(0.45, 0.02, 0.3, 0.055, "", true, handling_enginepane)
    guiCreateLabel(0.77, 0.025, 0.26, 0.05, "", true, handling_enginepane)
    guiCreateLabel(0.05, 0.08499999999999999, 0.38, 0.05, "Maximal Velocity", true, handling_enginepane)
    handling_maxvelocity = guiCreateEdit(0.45, 0.08, 0.3, 0.055, "", true, handling_enginepane)
    guiCreateLabel(0.77, 0.08499999999999999, 0.26, 0.05, "km / h", true, handling_enginepane)
    guiCreateLabel(0.05, 0.145, 0.38, 0.05, "Acceleration", true, handling_enginepane)
    handling_engineacceleration = guiCreateEdit(0.45, 0.13999999999999999, 0.3, 0.055, "", true, handling_enginepane)
    guiCreateLabel(0.77, 0.145, 0.26, 0.05, "m * sec²", true, handling_enginepane)
    guiCreateLabel(0.05, 0.205, 0.38, 0.05, "Inertia", true, handling_enginepane)
    handling_engineinertia = guiCreateEdit(0.45, 0.19999999999999998, 0.3, 0.055, "", true, handling_enginepane)
    guiCreateLabel(0.77, 0.205, 0.26, 0.05, "kg * m²", true, handling_enginepane)
    guiCreateLabel(0.05, 0.265, 0.38, 0.05, "Drive Type", true, handling_enginepane)
    handling_drivetype = guiCreateComboBox(0.45, 0.26, 0.3, 0.2, "", true, handling_enginepane)
    guiComboBoxAddItem(handling_drivetype, "Rear")
    guiComboBoxAddItem(handling_drivetype, "Front")
    guiComboBoxAddItem(handling_drivetype, "4x4")
    guiCreateLabel(0.77, 0.265, 0.26, 0.05, "", true, handling_enginepane)
    guiCreateLabel(0.05, 0.325, 0.38, 0.05, "Engine Type", true, handling_enginepane)
    handling_enginetype = guiCreateComboBox(0.45, 0.32, 0.3, 0.2, "", true, handling_enginepane)
    guiComboBoxAddItem(handling_enginetype, "Petrol")
    guiComboBoxAddItem(handling_enginetype, "Diesel")
    guiComboBoxAddItem(handling_enginetype, "Electric")
    guiCreateLabel(0.77, 0.325, 0.26, 0.05, "", true, handling_enginepane)
    handling_wheelspane = guiCreateGridList(0.2, 0.09, 0.78, 0.89, true, admin_tab_handling)
    guiSetVisible(handling_wheelspane, false)
    guiCreateLabel(0.05, 0.025, 0.38, 0.05, "Traction Multiplier", true, handling_wheelspane)
    handling_tractionmultiplier = guiCreateEdit(0.45, 0.02, 0.3, 0.055, "", true, handling_wheelspane)
    guiCreateLabel(0.77, 0.025, 0.26, 0.05, "", true, handling_wheelspane)
    guiCreateLabel(0.05, 0.08499999999999999, 0.38, 0.05, "Traction Loss", true, handling_wheelspane)
    handling_tractionloss = guiCreateEdit(0.45, 0.08, 0.3, 0.055, "", true, handling_wheelspane)
    guiCreateLabel(0.77, 0.08499999999999999, 0.26, 0.05, "", true, handling_wheelspane)
    guiCreateLabel(0.05, 0.145, 0.38, 0.05, "Traction Bias Ratio", true, handling_wheelspane)
    handling_tractionbias = guiCreateEdit(0.45, 0.13999999999999999, 0.3, 0.055, "", true, handling_wheelspane)
    guiCreateLabel(0.77, 0.145, 0.26, 0.05, "(1.0 full front)", true, handling_wheelspane)
    guiCreateLabel(0.05, 0.205, 0.38, 0.05, "Brake Deceleration", true, handling_wheelspane)
    handling_brakedeceleration = guiCreateEdit(0.45, 0.19999999999999998, 0.3, 0.055, "", true, handling_wheelspane)
    guiCreateLabel(0.77, 0.205, 0.26, 0.05, "", true, handling_wheelspane)
    guiCreateLabel(0.05, 0.265, 0.38, 0.05, "Brake Bias Ratio", true, handling_wheelspane)
    handling_brakebias = guiCreateEdit(0.45, 0.26, 0.3, 0.055, "", true, handling_wheelspane)
    guiCreateLabel(0.77, 0.265, 0.26, 0.05, "(1.0 full front)", true, handling_wheelspane)
    guiCreateLabel(0.05, 0.325, 0.38, 0.05, "ABS", true, handling_wheelspane)
    handling_abs = guiCreateComboBox(0.45, 0.32, 0.3, 0.18, "", true, handling_wheelspane)
    guiComboBoxAddItem(handling_abs, "Enable")
    guiComboBoxAddItem(handling_abs, "Disable")
    guiCreateLabel(0.77, 0.325, 0.26, 0.05, "", true, handling_wheelspane)
    guiCreateLabel(0.05, 0.385, 0.38, 0.05, "Steering Lock", true, handling_wheelspane)
    handling_steeringlock = guiCreateEdit(0.45, 0.38, 0.3, 0.055, "", true, handling_wheelspane)
    guiCreateLabel(0.77, 0.385, 0.26, 0.05, "º", true, handling_wheelspane)
    handling_suspensionpane = guiCreateGridList(0.2, 0.09, 0.78, 0.89, true, admin_tab_handling)
    guiSetVisible(handling_suspensionpane, false)
    guiCreateLabel(0.05, 0.025, 0.38, 0.05, "Force Level", true, handling_suspensionpane)
    handling_suspensionforcelevel = guiCreateEdit(0.45, 0.02, 0.3, 0.055, "", true, handling_suspensionpane)
    guiCreateLabel(0.77, 0.025, 0.26, 0.05, "", true, handling_suspensionpane)
    guiCreateLabel(0.05, 0.08499999999999999, 0.38, 0.05, "Damping Level", true, handling_suspensionpane)
    handling_suspensiondamping = guiCreateEdit(0.45, 0.08, 0.3, 0.055, "", true, handling_suspensionpane)
    guiCreateLabel(0.77, 0.08499999999999999, 0.26, 0.05, "", true, handling_suspensionpane)
    guiCreateLabel(0.05, 0.145, 0.38, 0.05, "High Speed Damping", true, handling_suspensionpane)
    handling_suspensionhighspeeddamping = guiCreateEdit(0.45, 0.13999999999999999, 0.3, 0.055, "", true, handling_suspensionpane)
    guiCreateLabel(0.77, 0.145, 0.26, 0.05, "", true, handling_suspensionpane)
    guiCreateLabel(0.05, 0.205, 0.38, 0.05, "Upper Limit", true, handling_suspensionpane)
    handling_suspensionupperlimit = guiCreateEdit(0.45, 0.19999999999999998, 0.3, 0.055, "", true, handling_suspensionpane)
    guiCreateLabel(0.77, 0.205, 0.26, 0.05, "m", true, handling_suspensionpane)
    guiCreateLabel(0.05, 0.265, 0.38, 0.05, "Lower Limit", true, handling_suspensionpane)
    handling_suspensionlowerlimit = guiCreateEdit(0.45, 0.26, 0.3, 0.055, "", true, handling_suspensionpane)
    guiCreateLabel(0.77, 0.265, 0.26, 0.05, "m", true, handling_suspensionpane)
    guiCreateLabel(0.05, 0.325, 0.38, 0.05, "Bias Ratio", true, handling_suspensionpane)
    handling_suspensionfrontrearbias = guiCreateEdit(0.45, 0.32, 0.3, 0.055, "", true, handling_suspensionpane)
    guiCreateLabel(0.77, 0.325, 0.26, 0.05, "(1.0 full front)", true, handling_suspensionpane)
    guiCreateLabel(0.05, 0.385, 0.38, 0.05, "Anti-Dive Multiplier", true, handling_suspensionpane)
    handling_suspensionantidivemultiplier = guiCreateEdit(0.45, 0.38, 0.3, 0.055, "", true, handling_suspensionpane)
    guiCreateLabel(0.77, 0.385, 0.26, 0.05, "", true, handling_suspensionpane)
    handling_modelflagpane = guiCreateGridList(0.2, 0.09, 0.78, 0.89, true, admin_tab_handling)
    guiSetVisible(handling_modelflagpane, false)
    handling_modelflags = {
      {},
      {},
      {},
      {},
      {},
      {},
      {},
      {}
    }
    handling_modelflags[1][1] = guiCreateCheckBox(0.05, 0.02, 0.45, 0.04, "Is van", false, true, handling_modelflagpane)
    handling_modelflags[1][2] = guiCreateCheckBox(0.05, 0.07, 0.45, 0.04, "Is bus", false, true, handling_modelflagpane)
    handling_modelflags[1][4] = guiCreateCheckBox(0.05, 0.12000000000000001, 0.45, 0.04, "Is low", false, true, handling_modelflagpane)
    handling_modelflags[1][8] = guiCreateCheckBox(0.05, 0.17, 0.45, 0.04, "Is big", false, true, handling_modelflagpane)
    handling_modelflags[2][1] = guiCreateCheckBox(0.05, 0.24000000000000002, 0.45, 0.04, "Reverse bonnet", false, true, handling_modelflagpane)
    handling_modelflags[2][2] = guiCreateCheckBox(0.05, 0.29, 0.45, 0.04, "Hanging boot", false, true, handling_modelflagpane)
    handling_modelflags[2][4] = guiCreateCheckBox(0.05, 0.34, 0.45, 0.04, "Tailgate boot", false, true, handling_modelflagpane)
    handling_modelflags[2][8] = guiCreateCheckBox(0.05, 0.39, 0.45, 0.04, "Noswing boot", false, true, handling_modelflagpane)
    handling_modelflags[3][1] = guiCreateCheckBox(0.05, 0.46, 0.45, 0.04, "No doors", false, true, handling_modelflagpane)
    handling_modelflags[3][2] = guiCreateCheckBox(0.05, 0.51, 0.45, 0.04, "Tandem seats", false, true, handling_modelflagpane)
    handling_modelflags[3][4] = guiCreateCheckBox(0.05, 0.56, 0.45, 0.04, "Sit in boat", false, true, handling_modelflagpane)
    handling_modelflags[3][8] = guiCreateCheckBox(0.05, 0.6100000000000001, 0.45, 0.04, "Cabriolet", false, true, handling_modelflagpane)
    handling_modelflags[4][1] = guiCreateCheckBox(0.05, 0.68, 0.45, 0.04, "No exhaust", false, true, handling_modelflagpane)
    handling_modelflags[4][2] = guiCreateCheckBox(0.05, 0.73, 0.45, 0.04, "Dbl exhaust", false, true, handling_modelflagpane)
    handling_modelflags[4][4] = guiCreateCheckBox(0.05, 0.78, 0.45, 0.04, "Invis look behind", false, true, handling_modelflagpane)
    handling_modelflags[4][8] = guiCreateCheckBox(0.05, 0.83, 0.45, 0.04, "Force door check", false, true, handling_modelflagpane)
    handling_modelflags[5][1] = guiCreateCheckBox(0.5, 0.02, 0.45, 0.04, "Axle F notilt", false, true, handling_modelflagpane)
    handling_modelflags[5][2] = guiCreateCheckBox(0.5, 0.07, 0.45, 0.04, "Axle F solid", false, true, handling_modelflagpane)
    handling_modelflags[5][4] = guiCreateCheckBox(0.5, 0.12000000000000001, 0.45, 0.04, "Axle F mcpherson", false, true, handling_modelflagpane)
    handling_modelflags[5][8] = guiCreateCheckBox(0.5, 0.17, 0.45, 0.04, "Axle F reverse", false, true, handling_modelflagpane)
    handling_modelflags[6][1] = guiCreateCheckBox(0.5, 0.24000000000000002, 0.45, 0.04, "Axle R notilt", false, true, handling_modelflagpane)
    handling_modelflags[6][2] = guiCreateCheckBox(0.5, 0.29, 0.45, 0.04, "Axle R solid", false, true, handling_modelflagpane)
    handling_modelflags[6][4] = guiCreateCheckBox(0.5, 0.34, 0.45, 0.04, "Axle R mcpherson", false, true, handling_modelflagpane)
    handling_modelflags[6][8] = guiCreateCheckBox(0.5, 0.39, 0.45, 0.04, "Axle R reverse", false, true, handling_modelflagpane)
    handling_modelflags[7][1] = guiCreateCheckBox(0.5, 0.46, 0.45, 0.04, "Is bike", false, true, handling_modelflagpane)
    handling_modelflags[7][2] = guiCreateCheckBox(0.5, 0.51, 0.45, 0.04, "Is heli", false, true, handling_modelflagpane)
    handling_modelflags[7][4] = guiCreateCheckBox(0.5, 0.56, 0.45, 0.04, "Is plane", false, true, handling_modelflagpane)
    handling_modelflags[7][8] = guiCreateCheckBox(0.5, 0.6100000000000001, 0.45, 0.04, "Is boat", false, true, handling_modelflagpane)
    handling_modelflags[8][1] = guiCreateCheckBox(0.5, 0.68, 0.45, 0.04, "Bounce panels", false, true, handling_modelflagpane)
    handling_modelflags[8][2] = guiCreateCheckBox(0.5, 0.73, 0.45, 0.04, "Double R wheels", false, true, handling_modelflagpane)
    handling_modelflags[8][4] = guiCreateCheckBox(0.5, 0.78, 0.45, 0.04, "Force ground clearance", false, true, handling_modelflagpane)
    handling_modelflags[8][8] = guiCreateCheckBox(0.5, 0.83, 0.45, 0.04, "Is hatchback", false, true, handling_modelflagpane)
    handling_handlingflagpane = guiCreateGridList(0.2, 0.09, 0.78, 0.89, true, admin_tab_handling)
    guiSetVisible(handling_handlingflagpane, false)
    handling_handlingflags = {
      {},
      {},
      {},
      {},
      {},
      {},
      {},
      {}
    }
    handling_handlingflags[1][1] = guiCreateCheckBox(0.05, 0.02, 0.45, 0.04, "1G boost", false, true, handling_handlingflagpane)
    handling_handlingflags[1][2] = guiCreateCheckBox(0.05, 0.07, 0.45, 0.04, "2G boost", false, true, handling_handlingflagpane)
    handling_handlingflags[1][4] = guiCreateCheckBox(0.05, 0.12000000000000001, 0.45, 0.04, "NPC anti roll", false, true, handling_handlingflagpane)
    handling_handlingflags[1][8] = guiCreateCheckBox(0.05, 0.17, 0.45, 0.04, "NPC neutral handl", false, true, handling_handlingflagpane)
    handling_handlingflags[2][1] = guiCreateCheckBox(0.05, 0.24000000000000002, 0.45, 0.04, "No handbrake", false, true, handling_handlingflagpane)
    handling_handlingflags[2][2] = guiCreateCheckBox(0.05, 0.29, 0.45, 0.04, "Steer rearwheels", false, true, handling_handlingflagpane)
    handling_handlingflags[2][4] = guiCreateCheckBox(0.05, 0.34, 0.45, 0.04, "Hb rearwheel steer", false, true, handling_handlingflagpane)
    handling_handlingflags[2][8] = guiCreateCheckBox(0.05, 0.39, 0.45, 0.04, "Alt steer opt", false, true, handling_handlingflagpane)
    handling_handlingflags[3][1] = guiCreateCheckBox(0.05, 0.46, 0.45, 0.04, "Wheel F narrowest", false, true, handling_handlingflagpane)
    handling_handlingflags[3][2] = guiCreateCheckBox(0.05, 0.51, 0.45, 0.04, "Wheel F narrow", false, true, handling_handlingflagpane)
    handling_handlingflags[3][4] = guiCreateCheckBox(0.05, 0.56, 0.45, 0.04, "Wheel F wide", false, true, handling_handlingflagpane)
    handling_handlingflags[3][8] = guiCreateCheckBox(0.05, 0.6100000000000001, 0.45, 0.04, "Wheel F widest", false, true, handling_handlingflagpane)
    handling_handlingflags[4][1] = guiCreateCheckBox(0.05, 0.68, 0.45, 0.04, "Wheel R narrowest", false, true, handling_handlingflagpane)
    handling_handlingflags[4][2] = guiCreateCheckBox(0.05, 0.73, 0.45, 0.04, "Wheel R narrow", false, true, handling_handlingflagpane)
    handling_handlingflags[4][4] = guiCreateCheckBox(0.05, 0.78, 0.45, 0.04, "Wheel R wide", false, true, handling_handlingflagpane)
    handling_handlingflags[4][8] = guiCreateCheckBox(0.05, 0.83, 0.45, 0.04, "Wheel R widest", false, true, handling_handlingflagpane)
    handling_handlingflags[5][1] = guiCreateCheckBox(0.5, 0.02, 0.45, 0.04, "Hydraulic geom", false, true, handling_handlingflagpane)
    handling_handlingflags[5][2] = guiCreateCheckBox(0.5, 0.07, 0.45, 0.04, "Hydraulic inst", false, true, handling_handlingflagpane)
    handling_handlingflags[5][4] = guiCreateCheckBox(0.5, 0.12000000000000001, 0.45, 0.04, "Hydraulic none", false, true, handling_handlingflagpane)
    handling_handlingflags[5][8] = guiCreateCheckBox(0.5, 0.17, 0.45, 0.04, "Nitro inst", false, true, handling_handlingflagpane)
    handling_handlingflags[6][1] = guiCreateCheckBox(0.5, 0.24000000000000002, 0.45, 0.04, "Dirt offroad", false, true, handling_handlingflagpane)
    handling_handlingflags[6][2] = guiCreateCheckBox(0.5, 0.29, 0.45, 0.04, "Sand offroad", false, true, handling_handlingflagpane)
    handling_handlingflags[6][4] = guiCreateCheckBox(0.5, 0.34, 0.45, 0.04, "Halogen lights", false, true, handling_handlingflagpane)
    handling_handlingflags[6][8] = guiCreateCheckBox(0.5, 0.39, 0.45, 0.04, "Proc rearwheel 1st", false, true, handling_handlingflagpane)
    handling_handlingflags[7][1] = guiCreateCheckBox(0.5, 0.46, 0.45, 0.04, "Use maxsp limit", false, true, handling_handlingflagpane)
    handling_handlingflags[7][2] = guiCreateCheckBox(0.5, 0.51, 0.45, 0.04, "Low rider", false, true, handling_handlingflagpane)
    handling_handlingflags[7][4] = guiCreateCheckBox(0.5, 0.56, 0.45, 0.04, "Street racer", false, true, handling_handlingflagpane)
    handling_handlingflags[7][8] = guiCreateCheckBox(0.5, 0.6100000000000001, 0.45, 0.04, "[???]", false, true, handling_handlingflagpane)
    handling_handlingflags[8][1] = guiCreateCheckBox(0.5, 0.68, 0.45, 0.04, "Swinging chassis", false, true, handling_handlingflagpane)
    handling_handlingflags[8][2] = guiCreateCheckBox(0.5, 0.73, 0.45, 0.04, "[???]", false, true, handling_handlingflagpane)
    handling_handlingflags[8][4] = guiCreateCheckBox(0.5, 0.78, 0.45, 0.04, "[???]", false, true, handling_handlingflagpane)
    handling_handlingflags[8][8] = guiCreateCheckBox(0.5, 0.83, 0.45, 0.04, "[???]", false, true, handling_handlingflagpane)
    handling_sirenspane = guiCreateGridList(0.2, 0.09, 0.78, 0.89, true, admin_tab_handling)
    guiSetVisible(handling_sirenspane, false)
    guiCreateLabel(0.05, 0.025, 0.38, 0.05, "Count", true, handling_sirenspane)
    sirens_count = guiCreateComboBox(0.45, 0.02, 0.3, 0.42, "", true, handling_sirenspane)
    guiComboBoxAddItem(sirens_count, "Original")
    guiComboBoxAddItem(sirens_count, "1")
    guiComboBoxAddItem(sirens_count, "2")
    guiComboBoxAddItem(sirens_count, "3")
    guiComboBoxAddItem(sirens_count, "4")
    guiComboBoxAddItem(sirens_count, "5")
    guiComboBoxAddItem(sirens_count, "6")
    guiComboBoxAddItem(sirens_count, "7")
    guiComboBoxAddItem(sirens_count, "8")
    guiCreateLabel(0.77, 0.025, 0.26, 0.05, "", true, handling_sirenspane)
    guiCreateLabel(0.05, 0.08499999999999999, 0.38, 0.05, "Type", true, handling_sirenspane)
    sirens_type = guiCreateComboBox(0.45, 0.08, 0.3, 0.3, "", true, handling_sirenspane)
    guiComboBoxAddItem(sirens_type, "Invisible")
    guiComboBoxAddItem(sirens_type, "Single")
    guiComboBoxAddItem(sirens_type, "Dual")
    guiComboBoxAddItem(sirens_type, "Triple")
    guiComboBoxAddItem(sirens_type, "Quadruple")
    guiComboBoxAddItem(sirens_type, "Quinary")
    guiCreateLabel(0.77, 0.08499999999999999, 0.26, 0.05, "", true, handling_sirenspane)
    sirens_360 = guiCreateCheckBox(0.05, 0.18, 0.45, 0.04, "Visibility 360°", false, true, handling_sirenspane)
    sirens_LOS = guiCreateCheckBox(0.05, 0.23000000000000004, 0.45, 0.04, "Check light of sight", false, true, handling_sirenspane)
    sirens_randomiser = guiCreateCheckBox(0.5, 0.18, 0.45, 0.04, "Randomise order", false, true, handling_sirenspane)
    sirens_silent = guiCreateCheckBox(0.5, 0.23000000000000004, 0.45, 0.04, "Silent siren", false, true, handling_sirenspane)
    guiCreateLabel(0.05, 0.32, 0.164, 0.055, "X offset", true, handling_sirenspane)
    guiCreateLabel(0.23399999999999999, 0.32, 0.164, 0.055, "Y offset", true, handling_sirenspane)
    guiCreateLabel(0.418, 0.32, 0.164, 0.055, "Z offset", true, handling_sirenspane)
    guiCreateLabel(0.6020000000000001, 0.32, 0.164, 0.055, "Color", true, handling_sirenspane)
    guiCreateLabel(0.786, 0.32, 0.164, 0.055, "Min Alpha", true, handling_sirenspane)
    local r2_132 = {}
    local r3_132 = {}
    local r4_132 = {}
    local r5_132 = {}
    sirens_minalpha = {}
    sirens_color = r5_132
    sirens_zcenter = r4_132
    sirens_ycenter = r3_132
    sirens_xcenter = r2_132
    sirens_xcenter[1] = guiCreateEdit(0.05, 0.38, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_ycenter[1] = guiCreateEdit(0.23399999999999999, 0.38, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_zcenter[1] = guiCreateEdit(0.418, 0.38, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_color[1] = guiCreateEdit(0.6020000000000001, 0.38, 0.164, 0.055, "", true, handling_sirenspane)
    guiEditSetReadOnly(sirens_color[1], true)
    sirens_minalpha[1] = guiCreateEdit(0.786, 0.38, 0.164, 0.055, "0", true, handling_sirenspane)
    sirens_xcenter[2] = guiCreateEdit(0.05, 0.44, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_ycenter[2] = guiCreateEdit(0.23399999999999999, 0.44, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_zcenter[2] = guiCreateEdit(0.418, 0.44, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_color[2] = guiCreateEdit(0.6020000000000001, 0.44, 0.164, 0.055, "", true, handling_sirenspane)
    guiEditSetReadOnly(sirens_color[2], true)
    sirens_minalpha[2] = guiCreateEdit(0.786, 0.44, 0.164, 0.055, "0", true, handling_sirenspane)
    sirens_xcenter[3] = guiCreateEdit(0.05, 0.5, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_ycenter[3] = guiCreateEdit(0.23399999999999999, 0.5, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_zcenter[3] = guiCreateEdit(0.418, 0.5, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_color[3] = guiCreateEdit(0.6020000000000001, 0.5, 0.164, 0.055, "", true, handling_sirenspane)
    guiEditSetReadOnly(sirens_color[3], true)
    sirens_minalpha[3] = guiCreateEdit(0.786, 0.5, 0.164, 0.055, "0", true, handling_sirenspane)
    sirens_xcenter[4] = guiCreateEdit(0.05, 0.56, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_ycenter[4] = guiCreateEdit(0.23399999999999999, 0.56, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_zcenter[4] = guiCreateEdit(0.418, 0.56, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_color[4] = guiCreateEdit(0.6020000000000001, 0.56, 0.164, 0.055, "", true, handling_sirenspane)
    guiEditSetReadOnly(sirens_color[4], true)
    sirens_minalpha[4] = guiCreateEdit(0.786, 0.56, 0.164, 0.055, "0", true, handling_sirenspane)
    sirens_xcenter[5] = guiCreateEdit(0.05, 0.62, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_ycenter[5] = guiCreateEdit(0.23399999999999999, 0.62, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_zcenter[5] = guiCreateEdit(0.418, 0.62, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_color[5] = guiCreateEdit(0.6020000000000001, 0.62, 0.164, 0.055, "", true, handling_sirenspane)
    guiEditSetReadOnly(sirens_color[5], true)
    sirens_minalpha[5] = guiCreateEdit(0.786, 0.62, 0.164, 0.055, "0", true, handling_sirenspane)
    sirens_xcenter[6] = guiCreateEdit(0.05, 0.6799999999999999, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_ycenter[6] = guiCreateEdit(0.23399999999999999, 0.6799999999999999, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_zcenter[6] = guiCreateEdit(0.418, 0.6799999999999999, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_color[6] = guiCreateEdit(0.6020000000000001, 0.6799999999999999, 0.164, 0.055, "", true, handling_sirenspane)
    guiEditSetReadOnly(sirens_color[6], true)
    sirens_minalpha[6] = guiCreateEdit(0.786, 0.6799999999999999, 0.164, 0.055, "0", true, handling_sirenspane)
    sirens_xcenter[7] = guiCreateEdit(0.05, 0.74, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_ycenter[7] = guiCreateEdit(0.23399999999999999, 0.74, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_zcenter[7] = guiCreateEdit(0.418, 0.74, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_color[7] = guiCreateEdit(0.6020000000000001, 0.74, 0.164, 0.055, "", true, handling_sirenspane)
    guiEditSetReadOnly(sirens_color[7], true)
    sirens_minalpha[7] = guiCreateEdit(0.786, 0.74, 0.164, 0.055, "0", true, handling_sirenspane)
    sirens_xcenter[8] = guiCreateEdit(0.05, 0.8, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_ycenter[8] = guiCreateEdit(0.23399999999999999, 0.8, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_zcenter[8] = guiCreateEdit(0.418, 0.8, 0.164, 0.055, "0.000", true, handling_sirenspane)
    sirens_color[8] = guiCreateEdit(0.6020000000000001, 0.8, 0.164, 0.055, "", true, handling_sirenspane)
    guiEditSetReadOnly(sirens_color[8], true)
    sirens_minalpha[8] = guiCreateEdit(0.786, 0.8, 0.164, 0.055, "0", true, handling_sirenspane)
    triggerEvent("onClientGUIComboBoxAccepted", handling_model)
    temp = guiCreateLabel(8, 8, 40, 21, "Side", false, admin_tab_teams)
    guiSetFont(temp, "default-bold-small")
    guiLabelSetHorizontalAlign(temp, "center")
    temp = guiCreateLabel(53, 8, 120, 21, "Name", false, admin_tab_teams)
    guiSetFont(temp, "default-bold-small")
    guiLabelSetHorizontalAlign(temp, "center")
    temp = guiCreateLabel(178, 8, 80, 21, "Skins (id,id, )", false, admin_tab_teams)
    guiSetFont(temp, "default-bold-small")
    guiLabelSetHorizontalAlign(temp, "center")
    temp = guiCreateLabel(263, 8, 50, 21, "Score", false, admin_tab_teams)
    guiSetFont(temp, "default-bold-small")
    guiLabelSetHorizontalAlign(temp, "center")
    temp = guiCreateLabel(318, 8, 50, 21, "Color", false, admin_tab_teams)
    guiSetFont(temp, "default-bold-small")
    guiLabelSetHorizontalAlign(temp, "center")
    teams_scroller = guiCreateScrollPane(0, 0.06, 1, 0.9, true, admin_tab_teams)
    guiSetVisible(guiCreateButton(0, 0, 1, 1, "", false, teams_scroller), false)
    teams_teams = {}
    teams_apply = guiCreateButton(0, 0, 70, 21, "Apply", false, teams_scroller)
    guiSetFont(teams_apply, "default-bold-small")
    teams_addteam = guiCreateButton(0, 0, 70, 21, "Add", false, teams_scroller)
    guiSetFont(teams_addteam, "default-bold-small")
    guiSetProperty(teams_addteam, "NormalTextColour", "C000FF00")
    vehicles_disabled = guiCreateGridList(0.02, 0.02, 0.3, 0.91, true, admin_tab_vehicles)
    guiGridListSetSortingEnabled(vehicles_disabled, false)
    guiGridListAddColumn(vehicles_disabled, "Disabled", 0.8)
    guiGridListSetSelectionMode(vehicles_disabled, 1)
    vehicles_enabled = guiCreateGridList(0.33, 0.02, 0.3, 0.91, true, admin_tab_vehicles)
    guiGridListSetSortingEnabled(vehicles_enabled, false)
    guiGridListAddColumn(vehicles_enabled, "Enabled", 0.8)
    guiGridListSetSelectionMode(vehicles_enabled, 1)
    vehicles_enable = guiCreateButton(0.02, 0.94, 0.3, 0.04, "Enable >", true, admin_tab_vehicles)
    guiSetFont(vehicles_enable, "default-bold-small")
    vehicles_disable = guiCreateButton(0.33, 0.94, 0.3, 0.04, "< Disable", true, admin_tab_vehicles)
    guiSetFont(vehicles_disable, "default-bold-small")
    weather_default = guiCreateComboBox(9, 9, 220, 383, "", false, admin_tab_weather)
    for r5_132, r6_132 in ipairs(weatherSAData) do
      guiComboBoxAddItem(weather_default, string.format("[%i] %s", r5_132 - 1, r6_132.name))
    end
    guiComboBoxSetSelected(weather_default, 0)
    weather_load = guiCreateButton(235, 9, 113, 23, "Load Weather", false, admin_tab_weather)
    guiSetFont(weather_load, "default-bold-small")
    guiSetProperty(weather_load, "NormalTextColour", "C000FF00")
    weather_loadhour = guiCreateButton(353, 9, 108, 23, "Load Hour", false, admin_tab_weather)
    guiSetFont(weather_loadhour, "default-bold-small")
    weather_record = guiCreateGridList(9, 36, 339, 77, false, admin_tab_weather)
    guiGridListSetSortingEnabled(weather_record, false)
    guiGridListSetSelectionMode(weather_record, 6)
    guiSetProperty(weather_record, "ColumnsMovable", "False")
    guiSetProperty(weather_record, "ColumnsSizable", "False")
    temp = guiCreateLabel(0.02, 0.8, 0.96, 0.2, "Double-click to load hour", true, weather_record)
    guiSetFont(temp, "default-small")
    guiLabelSetHorizontalAlign(temp, "center")
    guiSetEnabled(temp, false)
    weather_hour = guiCreateComboBox(405, 36, 57, 383, "0", false, admin_tab_weather)
    for r5_132 = 0, 23, 1 do
      guiComboBoxAddItem(weather_hour, tostring(r5_132))
    end
    weather_insert = guiCreateButton(353, 36, 47, 23, "Add", false, admin_tab_weather)
    guiSetFont(weather_insert, "default-bold-small")
    weather_save = guiCreateButton(353, 63, 108, 23, "Save Hour", false, admin_tab_weather)
    guiSetFont(weather_save, "default-bold-small")
    guiSetProperty(weather_save, "NormalTextColour", "C000FF00")
    weather_delete = guiCreateButton(353, 90, 108, 23, "Delete Hour", false, admin_tab_weather)
    guiSetFont(weather_delete, "default-bold-small")
    guiSetProperty(weather_delete, "NormalTextColour", "C0FF0000")
    temp = guiCreateLabel(10, 117, 200, 21, "Wind Vector & Speed", false, admin_tab_weather)
    guiSetFont(temp, "default-bold-small")
    wind_radar = guiCreateStaticImage(10, 142, 64, 64, "images/wind_radar.png", false, admin_tab_weather)
    wind_aim = guiCreateStaticImage(36, 136, 12, 12, "images/color_aim.png", false, admin_tab_weather)
    wind_vector = guiCreateEdit(80, 142, 65, 21, "", false, admin_tab_weather)
    guiCreateLabel(145, 142, 30, 21, " °", false, admin_tab_weather)
    wind_speed = guiCreateEdit(80, 167, 65, 21, "", false, admin_tab_weather)
    guiCreateLabel(145, 167, 30, 21, " m/s", false, admin_tab_weather)
    wind_slide = guiCreateScrollBar(80, 192, 135, 21, true, false, admin_tab_weather)
    guiSetProperty(wind_slide, "StepSize", "1")
    temp = guiCreateLabel(10, 217, 235, 21, "Rain Level", false, admin_tab_weather)
    guiSetFont(temp, "default-bold-small")
    rain_level = guiCreateEdit(10, 242, 60, 21, "", false, admin_tab_weather)
    rain_slide = guiCreateScrollBar(75, 242, 140, 21, true, false, admin_tab_weather)
    guiSetProperty(rain_slide, "StepSize", "1")
    temp = guiCreateLabel(10, 267, 235, 21, "Heat Level", false, admin_tab_weather)
    guiSetFont(temp, "default-bold-small")
    heat_level = guiCreateEdit(10, 292, 70, 21, "", false, admin_tab_weather)
    heat_levelslide = guiCreateScrollBar(85, 292, 130, 21, true, false, admin_tab_weather)
    guiSetProperty(heat_levelslide, "StepSize", "1")
    temp = guiCreateLabel(10, 317, 235, 21, "Far Clip Distance", false, admin_tab_weather)
    guiSetFont(temp, "default-bold-small")
    farclip_distance = guiCreateEdit(10, 342, 70, 21, "", false, admin_tab_weather)
    farclip_slide = guiCreateScrollBar(85, 342, 130, 21, true, false, admin_tab_weather)
    guiSetProperty(farclip_slide, "StepSize", "1")
    temp = guiCreateLabel(10, 367, 235, 21, "Fog Distance", false, admin_tab_weather)
    guiSetFont(temp, "default-bold-small")
    fog_distance = guiCreateEdit(10, 392, 70, 21, "", false, admin_tab_weather)
    fog_slide = guiCreateScrollBar(85, 392, 130, 21, true, false, admin_tab_weather)
    guiSetProperty(fog_slide, "StepSize", "1")
    temp = guiCreateLabel(235, 117, 90, 21, "Effect", false, admin_tab_weather)
    guiSetFont(temp, "default-bold-small")
    weather_effect = guiCreateComboBox(330, 117, 130, 200, "Clear", false, admin_tab_weather)
    guiComboBoxAddItem(weather_effect, "Clear")
    guiComboBoxAddItem(weather_effect, "Cloudy")
    guiComboBoxAddItem(weather_effect, "Thunder")
    guiComboBoxAddItem(weather_effect, "Storm")
    guiComboBoxAddItem(weather_effect, "Fog")
    temp = guiCreateLabel(235, 142, 235, 21, "Sky Gradient & Clouds", false, admin_tab_weather)
    guiSetFont(temp, "default-bold-small")
    sky_topcolor = guiCreateEdit(235, 167, 70, 21, "", false, admin_tab_weather)
    guiEditSetReadOnly(sky_topcolor, true)
    sky_bottomcolor = guiCreateEdit(235, 192, 70, 21, "", false, admin_tab_weather)
    guiEditSetReadOnly(sky_bottomcolor, true)
    sky_clouds = guiCreateCheckBox(235, 217, 70, 21, "Clouds", true, false, admin_tab_weather)
    sky_birds = guiCreateCheckBox(310, 217, 70, 21, "Birds", true, false, admin_tab_weather)
    sky_gradient = guiCreateStaticImage(310, 167, 150, 46, "images/color_pixel.png", false, admin_tab_weather)
    guiSetEnabled(sky_gradient, false)
    sky_clouds_img = guiCreateStaticImage(0, 0, 0.6, 1, "images/sky_clouds.png", true, sky_gradient)
    sky_birds_img = guiCreateStaticImage(0.6, 0.3, 0.4, 0.7, "images/sky_birds.png", true, sky_gradient)
    temp = guiCreateLabel(235, 242, 235, 21, "Sun Size & Color", false, admin_tab_weather)
    guiSetFont(temp, "default-bold-small")
    sun_size = guiCreateEdit(235, 267, 70, 21, "", false, admin_tab_weather)
    sun_sizeslide = guiCreateScrollBar(310, 267, 150, 21, true, false, admin_tab_weather)
    guiSetProperty(sun_sizeslide, "StepSize", "1")
    guiCreateLabel(235, 292, 50, 21, "Core", false, admin_tab_weather)
    sun_colora = guiCreateEdit(265, 292, 70, 21, "", false, admin_tab_weather)
    guiEditSetReadOnly(sun_colora, true)
    guiCreateLabel(355, 292, 50, 21, "Shine", false, admin_tab_weather)
    sun_colorb = guiCreateEdit(390, 292, 70, 21, "", false, admin_tab_weather)
    guiEditSetReadOnly(sun_colorb, true)
    temp = guiCreateLabel(235, 317, 235, 21, "Water Level & Color", false, admin_tab_weather)
    guiSetFont(temp, "default-bold-small")
    water_level = guiCreateEdit(235, 342, 70, 21, "", false, admin_tab_weather)
    water_levelslide = guiCreateScrollBar(310, 342, 150, 21, true, false, admin_tab_weather)
    guiSetProperty(water_levelslide, "StepSize", "1")
    guiCreateLabel(235, 367, 50, 21, "Color", false, admin_tab_weather)
    water_color = guiCreateEdit(265, 367, 70, 21, "", false, admin_tab_weather)
    guiEditSetReadOnly(water_color, true)
    guiSetFont(guiCreateLabel(235, 392, 235, 21, "Wave Height", false, admin_tab_weather), "default-bold-small")
    wave_height = guiCreateEdit(235, 417, 70, 21, "", false, admin_tab_weather)
    wave_heightslide = guiCreateScrollBar(310, 417, 150, 21, true, false, admin_tab_weather)
    guiSetProperty(wave_heightslide, "StepSize", "1")
    guiSetFont(guiCreateLabel(0.02, 0.03, 0.23, 0.055, "Action detecting", true, admin_tab_anticheat), "default-bold-small")
    anticheat_action = guiCreateComboBox(0.28, 0.02, 0.35, 0.5, ({
      chat = "Chat message",
      adminchat = "Adminchat message",
      kick = "Kick",
    })[getTacticsData("anticheat", "action_detection")] or "", true, admin_tab_anticheat)
    guiComboBoxAddItem(anticheat_action, "Chat message")
    guiComboBoxAddItem(anticheat_action, "Adminchat message")
    guiComboBoxAddItem(anticheat_action, "Kick")
    guiSetFont(guiCreateLabel(0.02, 0.09, 0.23, 0.055, "SpeedHack", true, admin_tab_anticheat), "default-bold-small")
    r2_132 = guiCreateComboBox
    r3_132 = 0.28
    r4_132 = 0.085
    r5_132 = 0.2
    local r6_132 = 0.2
    local r7_132 = getTacticsData("anticheat", "speedhach")
    if r7_132 == "true" then
      r7_132 = "Enable" or "Disable"
    else
      goto label_6744	-- block#29 is visited secondly
    end
    anticheat_speedhack = r2_132(r3_132, r4_132, r5_132, r6_132, r7_132, true, admin_tab_anticheat)
    guiComboBoxAddItem(anticheat_speedhack, "Enable")
    guiComboBoxAddItem(anticheat_speedhack, "Disable")
    guiSetFont(guiCreateLabel(0.02, 0.15, 0.23, 0.055, "GodMode", true, admin_tab_anticheat), "default-bold-small")
    r2_132 = guiCreateComboBox
    r3_132 = 0.28
    r4_132 = 0.14500000000000002
    r5_132 = 0.2
    r6_132 = 0.2
    r7_132 = getTacticsData("anticheat", "godmode")
    if r7_132 == "true" then
      r7_132 = "Enable" or "Disable"
    else
      goto label_6784	-- block#32 is visited secondly
    end
    anticheat_godmode = r2_132(r3_132, r4_132, r5_132, r6_132, r7_132, true, admin_tab_anticheat)
    guiComboBoxAddItem(anticheat_godmode, "Enable")
    guiComboBoxAddItem(anticheat_godmode, "Disable")
    guiSetFont(guiCreateLabel(0.02, 0.21, 0.23, 0.055, "Mods", true, admin_tab_anticheat), "default-bold-small")
    r2_132 = guiCreateComboBox
    r3_132 = 0.28
    r4_132 = 0.20500000000000002
    r5_132 = 0.2
    r6_132 = 0.2
    r7_132 = getTacticsData("anticheat", "mods")
    if r7_132 == "true" then
      r7_132 = "Enable" or "Disable"
    else
      goto label_6824	-- block#35 is visited secondly
    end
    anticheat_mods = r2_132(r3_132, r4_132, r5_132, r6_132, r7_132, true, admin_tab_anticheat)
    guiComboBoxAddItem(anticheat_mods, "Enable")
    guiComboBoxAddItem(anticheat_mods, "Disable")
    anticheat_modslist = guiCreateGridList(0.02, 0.27, 0.47, 0.65, true, admin_tab_anticheat)
    guiGridListSetSortingEnabled(anticheat_modslist, false)
    guiGridListAddColumn(anticheat_modslist, "Modification", 0.55)
    guiGridListAddColumn(anticheat_modslist, "Search", 0.3)
    anticheat_modsadd = guiCreateButton(0.02, 0.93, 0.23, 0.05, "Add", true, admin_tab_anticheat)
    guiSetFont(anticheat_modsadd, "default-bold-small")
    anticheat_modsdel = guiCreateButton(0.26, 0.93, 0.23, 0.05, "Delete", true, admin_tab_anticheat)
    guiSetFont(anticheat_modsdel, "default-bold-small")
    refreshSettingsConfig()
    refreshTeamConfig()
    remakeAdminWeaponsPack()
    refreshVehicleConfig()
    refreshWeatherConfig()
    updateAdminMaps()
    refreshCyclerResources()
    updateAdmin()
    refreshAnticheatSearch()
    return admin_window
  end
  function createAdminRenameConfig()
    -- line: [1165, 1175] id: 135
    rename_window = guiCreateWindow(xscreen * 0.5 - 42.5, yscreen * 0.5 - 130, 240, 85, "Rename Config", false)
    guiWindowSetSizable(rename_window, false)
    guiSetFont(guiCreateLabel(12, 26, 80, 20.8, "Filename", false, rename_window), "default-bold-small")
    rename_name = guiCreateEdit(80, 26, 160, 20.8, "", false, rename_window)
    rename_ok = guiCreateButton(12, 52, 103.2, 18.2, "Rename", false, rename_window)
    guiSetFont(rename_ok, "default-bold-small")
    rename_cancel = guiCreateButton(122.4, 52, 103.2, 18.2, "Cancel", false, rename_window)
    guiSetFont(rename_cancel, "default-bold-small")
    return rename_window
  end
  function createAdminAddConfig()
    -- line: [1176, 1186] id: 136
    add_window = guiCreateWindow(xscreen * 0.5 - 42.5, yscreen * 0.5 - 130, 240, 85, "Add Config", false)
    guiWindowSetSizable(add_window, false)
    guiSetFont(guiCreateLabel(12, 26, 80, 20.8, "Filename", false, add_window), "default-bold-small")
    add_name = guiCreateEdit(80, 26, 160, 20.8, "", false, add_window)
    add_ok = guiCreateButton(12, 52, 103.2, 18.2, "Add", false, add_window)
    guiSetFont(add_ok, "default-bold-small")
    add_cancel = guiCreateButton(122.4, 52, 103.2, 18.2, "Cancel", false, add_window)
    guiSetFont(add_cancel, "default-bold-small")
    return add_window
  end
  function createAdminSaveConfig()
    -- line: [1187, 1227] id: 137
    save_window = guiCreateWindow(xscreen * 0.5 - 120, yscreen * 0.5 - 130, 240, 260, "Save Config", false)
    guiWindowSetSizable(save_window, false)
    guiSetFont(guiCreateLabel(0.05, 0.1, 0.25, 0.08, "Name", true, save_window), "default-bold-small")
    local r0_137 = ""
    if isElement(admin_window) then
      local r1_137 = guiGridListGetSelectedItem(config_list)
      if r1_137 > -1 then
        r0_137 = guiGridListGetItemText(config_list, r1_137, 1)
      end
    end
    save_name = guiCreateEdit(0.25, 0.1, 0.75, 0.08, r0_137, true, save_window)
    guiSetFont(guiCreateLabel(0.05, 0.2, 0.25, 0.08, "Tabs", true, save_window), "default-bold-small")
    save_all = guiCreateCheckBox(0.25, 0.2, 0.75, 0.08, "All", true, true, save_window)
    save_maps = guiCreateCheckBox(0.25, 0.28, 0.3, 0.08, "Maps", true, true, save_window)
    guiSetEnabled(save_maps, false)
    save_settings = guiCreateCheckBox(0.25, 0.36, 0.3, 0.08, "Settings", true, true, save_window)
    guiSetEnabled(save_settings, false)
    save_teams = guiCreateCheckBox(0.25, 0.44, 0.3, 0.08, "Teams", true, true, save_window)
    guiSetEnabled(save_teams, false)
    save_weapons = guiCreateCheckBox(0.25, 0.52, 0.3, 0.08, "Weapons", true, true, save_window)
    guiSetEnabled(save_weapons, false)
    save_vehicles = guiCreateCheckBox(0.25, 0.6000000000000001, 0.35, 0.08, "Vehicles", true, true, save_window)
    guiSetEnabled(save_vehicles, false)
    save_weather = guiCreateCheckBox(0.6, 0.28, 0.35, 0.08, "Weather", true, true, save_window)
    guiSetEnabled(save_weather, false)
    save_shooting = guiCreateCheckBox(0.6, 0.36, 0.35, 0.08, "Shooting", true, true, save_window)
    guiSetEnabled(save_shooting, false)
    guiSetVisible(save_shooting, false)
    save_handling = guiCreateCheckBox(0.6, 0.44, 0.35, 0.08, "Handling", true, true, save_window)
    guiSetEnabled(save_handling, false)
    guiSetVisible(save_handling, false)
    save_anticheat = guiCreateCheckBox(0.6, 0.52, 0.35, 0.08, "AC", true, true, save_window)
    guiSetEnabled(save_anticheat, false)
    guiSetVisible(save_anticheat, false)
    save_ok = guiCreateButton(0.05, 0.88, 0.43, 0.07, "Save", true, save_window)
    guiSetFont(save_ok, "default-bold-small")
    save_cancel = guiCreateButton(0.51, 0.88, 0.43, 0.07, "Cancel", true, save_window)
    guiSetFont(save_cancel, "default-bold-small")
    return save_window
  end
  function createAdminScreen()
    -- line: [1228, 1262] id: 138
    screen_window = guiCreateWindow(xscreen * 0.5 - 120, yscreen * 0.5 - 150, 240, 120, "Screen Shot", false)
    guiWindowSetSizable(screen_window, false)
    screen_image = guiCreateStaticImage(10, 25, 1, 1, "images/color_pixel.png", false, screen_window)
    screen_menu = guiCreateStaticImage(0, 0, 320, 32, "images/color_pixel.png", false, screen_image)
    guiSetProperty(screen_menu, "ImageColours", "tl:80000000 tr:80000000 bl:80000000 br:80000000")
    screen_close = guiCreateButton(5, 5, 80, 22, "Close", false, screen_menu)
    guiSetFont(screen_close, "default-bold-small")
    screen_name = guiCreateEdit(90, 5, 170, 22, "", false, screen_menu)
    screen_save = guiCreateButton(265, 5, 50, 22, "Save", false, screen_menu)
    screen_list = guiCreateComboBox(90, 5, 225, 200, "", false, screen_menu)
    guiSetProperty(screen_list, "ClippedByParent", "False")
    local r0_138 = xmlLoadFile("screenshots/_list.xml")
    if r0_138 then
      local r1_138 = nil
      for r5_138, r6_138 in ipairs(xmlNodeGetChildren(r0_138)) do
        r1_138 = xmlNodeGetAttribute(r6_138, "src")
        if r1_138 then
          if fileExists("screenshots/" .. r1_138 .. ".jpg") then
            guiComboBoxAddItem(screen_list, r1_138)
          else
            xmlDestroyNode(r6_138)
          end
        end
      end
      if r1_138 then
        guiSetText(screen_list, r1_138)
      end
      xmlSaveFile(r0_138)
      xmlUnloadFile(r0_138)
    end
    guiSetVisible(screen_list, false)
    guiSetFont(screen_save, "default-bold-small")
    guiEditSetReadOnly(screen_name, true)
    guiSetAlpha(screen_menu, 0.2)
    return screen_window
  end
  function createAdminRedirect()
    -- line: [1263, 1280] id: 139
    redirect_window = guiCreateWindow(xscreen * 0.5 - 120, yscreen * 0.5 - 150, 240, 120, "Redirect", false)
    guiWindowSetSizable(redirect_window, false)
    guiCreateLabel(0.05, 0.2, 0.17, 0.18, "Host:", true, redirect_window)
    redirect_ip = guiCreateEdit(0.2, 0.2, 0.5, 0.18, "", true, redirect_window)
    redirect_port = guiCreateEdit(0.72, 0.2, 0.26, 0.18, "", true, redirect_window)
    guiEditSetMaxLength(redirect_port, 5)
    guiCreateLabel(0.05, 0.4, 0.17, 0.2, "Pass:", true, redirect_window)
    redirect_password = guiCreateEdit(0.2, 0.4, 0.78, 0.18, "", true, redirect_window)
    guiEditSetMasked(redirect_password, true)
    redirect_reconnect = guiCreateCheckBox(0.2, 0.57, 0.78, 0.16, "Reconnect", false, true, redirect_window)
    guiSetEnabled(redirect_reconnect, false)
    redirect_yes = guiCreateButton(0.05, 0.75, 0.4, 0.18, "Connect", true, redirect_window)
    guiSetFont(redirect_yes, "default-bold-small")
    redirect_no = guiCreateButton(0.55, 0.75, 0.4, 0.18, "Close", true, redirect_window)
    guiSetFont(redirect_no, "default-bold-small")
    return redirect_window
  end
  function createAdminRestore()
    -- line: [1281, 1294] id: 140
    restore_window = guiCreateWindow(xscreen * 0.5 - 150, yscreen * 0.5 - 100, 300, 200, "", false)
    guiWindowSetSizable(restore_window, false)
    restore_list = guiCreateGridList(0.01, 0.1, 0.98, 0.7, true, restore_window)
    guiGridListSetSortingEnabled(restore_list, false)
    restore_name = guiGridListAddColumn(restore_list, "Name", 0.6)
    restore_team = guiGridListAddColumn(restore_list, "Team", 0.3)
    restore_yes = guiCreateButton(0.33, 0.85, 0.15, 0.1, "Yes", true, restore_window)
    guiSetFont(restore_yes, "default-bold-small")
    restore_no = guiCreateButton(0.52, 0.85, 0.15, 0.1, "No", true, restore_window)
    guiSetFont(restore_no, "default-bold-small")
    restore_player = false
    return restore_window
  end
  function createAdminRules()
    -- line: [1295, 1311] id: 141
    rules_window = guiCreateWindow(xscreen * 0.5 - 120, yscreen * 0.5 - 50, 240, 100, "Change rule", false)
    guiWindowSetSizable(rules_window, false)
    rules_label = guiCreateLabel(12, 25, 216, 20, "", false, rules_window)
    rules_edit = guiCreateEdit(24, 45, 192, 20, "", false, rules_window)
    rules_list = guiCreateGridList(24, 45, 192, 20, false, rules_window)
    guiGridListSetSortingEnabled(rules_list, false)
    guiGridListAddColumn(rules_list, "Values", 0.8)
    rules_time = guiCreateEdit(60, 55, 100, 20, "00:00:00.0", false, rules_window)
    rules_time_up = guiCreateStaticImage(160, 55, 20, 10, "images/numericup.png", false, rules_window)
    rules_time_down = guiCreateStaticImage(160, 65, 20, 10, "images/numericdown.png", false, rules_window)
    rules_ok = guiCreateButton(60, 70, 57.6, 20, "Edit", false, rules_window)
    guiSetFont(rules_ok, "default-bold-small")
    rules_cancel = guiCreateButton(122.4, 70, 57.6, 20, "Cancel", false, rules_window)
    guiSetFont(rules_cancel, "default-bold-small")
    return rules_window
  end
  function createAdminPalette()
    -- line: [1312, 1352] id: 142
    palette_window = guiCreateWindow(xscreen * 0.5 - 150, yscreen * 0.5 - 165, 300, 330, "Color Palette", false)
    guiWindowSetSizable(palette_window, false)
    guiSetAlpha(palette_window, 1)
    palette_hue = guiCreateStaticImage(0.05, 0.09, 0.75, 0.65, "images/color_hue.png", true, palette_window)
    palette_color2 = guiCreateStaticImage(0.05, 0.76, 0.25, 0.12, "images/color_pixel.png", true, palette_window)
    palette_color1 = guiCreateStaticImage(0.83, 0.09, 0.1, 0.65, "images/color_pixel.png", true, palette_window)
    palette_light = guiCreateStaticImage(0.83, 0.09, 0.1, 0.65, "images/color_light.png", true, palette_window)
    palette_aim = guiCreateStaticImage(0.03, 0.07, 0.04, 0.04, "images/color_aim.png", true, palette_window)
    palette_aim2 = guiCreateStaticImage(0.93, 0.07, 0.04, 0.04, "images/color_aim2.png", true, palette_window)
    palette_element = nil
    palette_L = 0
    palette_S = 0
    palette_H = 0
    temp = guiCreateLabel(0.32, 0.76, 0.1, 0.06, "R", true, palette_window)
    guiSetFont(temp, "default-bold-small")
    guiLabelSetColor(temp, 255, 0, 0)
    palette_rr = guiCreateEdit(0.35, 0.76, 0.17, 0.06, "", true, palette_window)
    guiEditSetMaxLength(palette_rr, 3)
    temp = guiCreateLabel(0.53, 0.76, 0.1, 0.06, "G", true, palette_window)
    guiSetFont(temp, "default-bold-small")
    guiLabelSetColor(temp, 0, 255, 0)
    palette_gg = guiCreateEdit(0.56, 0.76, 0.17, 0.06, "", true, palette_window)
    guiEditSetMaxLength(palette_gg, 3)
    temp = guiCreateLabel(0.74, 0.76, 0.1, 0.06, "B", true, palette_window)
    guiSetFont(temp, "default-bold-small")
    guiLabelSetColor(temp, 0, 0, 255)
    palette_bb = guiCreateEdit(0.77, 0.76, 0.17, 0.06, "", true, palette_window)
    guiEditSetMaxLength(palette_bb, 3)
    temp = guiCreateLabel(0.32, 0.83, 0.1, 0.06, "A", true, palette_window)
    guiSetFont(temp, "default-bold-small")
    guiLabelSetColor(temp, 255, 255, 255)
    palette_aa = guiCreateEdit(0.35, 0.83, 0.17, 0.06, "255", true, palette_window)
    guiEditSetMaxLength(palette_aa, 3)
    temp = guiCreateLabel(0.53, 0.83, 0.1, 0.06, "Hex", true, palette_window)
    guiSetFont(temp, "default-bold-small")
    palette_hex = guiCreateEdit(0.62, 0.83, 0.32, 0.06, "", true, palette_window)
    guiEditSetMaxLength(palette_hex, 8)
    palette_ok = guiCreateButton(0.25, 0.91, 0.24, 0.06, "OK", true, palette_window)
    guiSetFont(palette_ok, "default-bold-small")
    palette_cancel = guiCreateButton(0.51, 0.91, 0.24, 0.06, "Close", true, palette_window)
    guiSetFont(palette_cancel, "default-bold-small")
    return palette_window
  end
  function createAdminMods()
    -- line: [1353, 1369] id: 143
    mods_window = guiCreateWindow(xscreen * 0.5 - 150, yscreen * 0.5 - 60, 300, 120, "Change mod", false)
    guiWindowSetSizable(mods_window, false)
    guiSetFont(guiCreateLabel(12, 25, 275, 50, "Name", false, mods_window), "default-bold-small")
    mods_name = guiCreateEdit(62, 25, 275, 20, "", false, mods_window)
    mods_label = guiCreateLabel(12, 45, 275, 20, "Use \'*\' for group of any character", false, mods_window)
    guiSetFont(guiCreateLabel(12, 65, 275, 50, "Search", false, mods_window), "default-bold-small")
    mods_edit = guiCreateEdit(62, 65, 275, 20, "", false, mods_window)
    mods_type_name = guiCreateRadioButton(12, 90, 50, 20, "Name", false, mods_window)
    mods_type_hash = guiCreateRadioButton(64, 90, 50, 20, "Hash", false, mods_window)
    guiRadioButtonSetSelected(mods_type_name, true)
    mods_ok = guiCreateButton(150, 90, 67, 20, "Set", false, mods_window)
    guiSetFont(mods_ok, "default-bold-small")
    mods_cancel = guiCreateButton(222, 90, 67, 20, "Cancel", false, mods_window)
    guiSetFont(mods_cancel, "default-bold-small")
    return mods_window
  end
  function refreshAnticheatSearch()
    -- line: [1370, 1384] id: 144
    if not isElement(admin_window) then
      return 
    end
    local r0_144 = getTacticsData("anticheat", "modslist") or {}
    local r1_144 = guiGridListGetRowCount(anticheat_modslist)
    for r5_144 = 0, math.max(r1_144, #r0_144), 1 do
      if r5_144 < #r0_144 then
        if r1_144 <= r5_144 then
          guiGridListAddRow(anticheat_modslist)
        end
        guiGridListSetItemText(anticheat_modslist, r5_144, 1, tostring(r0_144[r5_144 + 1].name), false, false)
        guiGridListSetItemText(anticheat_modslist, r5_144, 2, tostring(r0_144[r5_144 + 1].search), false, false)
        guiGridListSetItemData(anticheat_modslist, r5_144, 2, tostring(r0_144[r5_144 + 1].type))
      else
        guiGridListRemoveRow(anticheat_modslist, r5_144)
      end
    end
  end
  function refreshSettingsConfig()
    -- line: [1385, 1426] id: 145
    if not isElement(admin_window) then
      return 
    end
    local r0_145 = guiGridListGetSelectedItem(modes_list)
    local r1_145 = false
    if r0_145 ~= -1 then
      r1_145 = guiGridListGetItemText(modes_list, r0_145, 1)
    end
    guiGridListClear(modes_list)
    guiGridListSetItemText(modes_list, guiGridListAddRow(modes_list), 1, "Tactics", true, false)
    guiGridListSetItemText(modes_list, guiGridListAddRow(modes_list), 1, "settings", false, false)
    if r1_145 == "settings" then
      guiGridListSetSelectedItem(modes_list, guiGridListGetRowCount(modes_list) - 1, 1)
    end
    guiGridListSetItemText(modes_list, guiGridListAddRow(modes_list), 1, "glitches", false, false)
    if r1_145 == "glitches" then
      guiGridListSetSelectedItem(modes_list, guiGridListGetRowCount(modes_list) - 1, 1)
    end
    guiGridListSetItemText(modes_list, guiGridListAddRow(modes_list), 1, "cheats", false, false)
    if r1_145 == "cheats" then
      guiGridListSetSelectedItem(modes_list, guiGridListGetRowCount(modes_list) - 1, 1)
    end
    guiGridListSetItemText(modes_list, guiGridListAddRow(modes_list), 1, "limites", false, false)
    if r1_145 == "limites" then
      guiGridListSetSelectedItem(modes_list, guiGridListGetRowCount(modes_list) - 1, 1)
    end
    guiGridListSetItemText(modes_list, guiGridListAddRow(modes_list), 1, "Modes", true, false)
    local r2_145 = {}
    for r6_145, r7_145 in pairs(getTacticsData("modes") or {}) do
      table.insert(r2_145, {
        r6_145,
        r7_145
      })
    end
    table.sort(r2_145, function(r0_146, r1_146)
      -- line: [1413, 1413] id: 146
      return r0_146[1] < r1_146[1]
    end)
    for r6_145, r7_145 in ipairs(r2_145) do
      local r8_145 = tostring(r7_145[1])
      local r9_145 = r7_145[2] or {}
      local r10_145 = guiGridListAddRow(modes_list)
      guiGridListSetItemText(modes_list, r10_145, 1, r8_145, false, false)
      if r9_145.enable == "false" then
        guiGridListSetItemColor(modes_list, r10_145, 1, 255, 0, 0)
      end
      if r1_145 == r8_145 then
        guiGridListSetSelectedItem(modes_list, r10_145, 1)
      end
    end
    triggerEvent("onClientGUIClick", modes_list, "left")
  end
  function refreshWeatherConfig()
    -- line: [1427, 1451] id: 147
    if not isElement(admin_window) then
      return 
    end
    while 0 < guiGridListGetColumnCount(weather_record) do
      guiGridListRemoveColumn(weather_record, 1)
    end
    local r0_147 = 0
    local r1_147 = getTacticsData("Weather") or {}
    local r2_147 = getTime()
    for r6_147 = 0, 23, 1 do
      if r1_147[r6_147] then
        local r7_147 = guiGridListAddColumn(weather_record, tostring(r6_147) .. "h", 0.08)
        guiGridListAddRow(weather_record)
        guiGridListAddRow(weather_record)
        guiGridListSetItemText(weather_record, 0, r7_147, " ", false, false)
        guiGridListSetItemText(weather_record, 1, r7_147, " ", false, false)
        guiGridListSetItemData(weather_record, 1, r7_147, tostring(r6_147))
        if tonumber(r6_147) <= r2_147 then
          r0_147 = r7_147
        end
      end
    end
    if guiGridListGetSelectedItem(weather_record) < 0 then
      if r0_147 == 0 then
        r0_147 = guiGridListGetColumnCount(weather_record)
      end
      guiGridListSetSelectedItem(weather_record, 0, r0_147)
      triggerEvent("onClientGUIDoubleClick", weather_record, "left")
    end
  end
  function refreshConfiglist(r0_148)
    -- line: [1452, 1461] id: 148
    if not isElement(admin_window) then
      return 
    end
    guiGridListClear(config_list)
    for r4_148, r5_148 in ipairs(r0_148) do
      row = guiGridListAddRow(config_list)
      guiGridListSetItemText(config_list, row, 1, r5_148[1], false, false)
      guiGridListSetItemData(config_list, row, 1, r5_148[3])
      guiGridListSetItemColor(config_list, row, 1, r5_148[2], 255, r5_148[2])
    end
  end
  function updateAdmin()
    -- line: [1462, 1533] id: 149
    -- notice: unreachable block#47
    if not isElement(admin_window) then
      return 
    end
    local r0_149 = {}
    for r4_149, r5_149 in ipairs(getElementsByType("player")) do
      if not getPlayerTeam(r5_149) then
        table.insert(r0_149, {
          r5_149,
          nil
        })
      end
    end
    for r4_149, r5_149 in ipairs(getElementsByType("team")) do
      for r9_149, r10_149 in ipairs(getPlayersInTeam(r5_149)) do
        table.insert(r0_149, {
          r10_149,
          r5_149
        })
      end
    end
    local r1_149 = guiGridListGetRowCount(player_list)
    local r2_149 = {}
    for r6_149, r7_149 in ipairs(guiGridListGetSelectedItems(player_list)) do
      if r7_149.column == player_id then
        r2_149[guiGridListGetItemText(player_list, r7_149.row, player_id)] = true
      end
    end
    guiGridListSetSelectedItem(player_list, 0, 0)
    for r6_149 = 0, math.max(r1_149, #r0_149), 1 do
      if r6_149 < #r0_149 then
        local r7_149 = r0_149[r6_149 + 1][1]
        local r8_149 = r0_149[r6_149 + 1][2]
        if r1_149 <= r6_149 then
          guiGridListAddRow(player_list)
        end
        guiGridListSetItemText(player_list, r6_149, player_id, getElementID(r7_149), false, false)
        if r2_149[getElementID(r7_149)] then
          guiGridListSetSelectedItem(player_list, r6_149, player_id, false)
        end
        guiGridListSetItemText(player_list, r6_149, player_name, removeColorCoding(getPlayerName(r7_149)), false, false)
        if not r8_149 then
          guiGridListSetItemColor(player_list, r6_149, player_name, 255, 255, 255)
        else
          guiGridListSetItemColor(player_list, r6_149, player_name, getTeamColor(r8_149))
        end
        local r9_149 = getElementData(r7_149, "Status") or ""
        if r9_149 == "Play" and getTacticsData("settings", "player_information") == "true" then
          r9_149 = tostring(math.floor(getElementHealth(r7_149) + getPedArmor(r7_149)))
        end
        if r9_149 == "Spectate" then
          r9_149 = ""
        end
        guiGridListSetItemText(player_list, r6_149, player_status, r9_149, false, false)
      else
        guiGridListRemoveRow(player_list, #r0_149)
      end
    end
    local r3_149 = guiGridListGetSelectedItems(player_list)
    if #r3_149 == 3 then
      local r4_149 = getElementByID(guiGridListGetItemText(player_list, r3_149[1].row, player_id))
      if r4_149 and isElement(r4_149) then
        local r5_149 = "Nickname: " .. getPlayerName(r4_149) .. "\nSerial: " .. tostring(getElementData(r4_149, "Serial")) .. "\nIP: " .. tostring(getElementData(r4_149, "IP")) .. "\nVersion: " .. tostring(getElementData(r4_149, "Version")) .. "\n"
        if guiGetText(player_info) ~= r5_149 then
          guiSetText(player_info, r5_149)
        end
        if getElementData(r4_149, "Status") == "Play" and guiGetText(player_add) ~= "Remove" then
          guiSetText(player_add, "Remove")
        elseif guiGetText(player_add) ~= "Add" then
          guiSetText(player_add, "Add")
        end
        local r6_149 = guiCheckBoxSetSelected
        local r7_149 = player_specskin
        local r8_149 = getElementData(r4_149, "spectateskin")
        if r8_149 then
          r8_149 = true
        else
          r8_149 = false
        end
        r6_149(r7_149, r8_149)
      end
    else
      if guiGetText(player_info) ~= "" then
        guiSetText(player_info, "")
      end
      if guiGetText(player_add) ~= "Add/Remove" then
        guiSetText(player_add, "Add/Remove")
      end
      if guiCheckBoxGetSelected(player_specskin) then
        guiCheckBoxSetSelected(player_specskin, false)
      end
    end
    local r4_149, r5_149 = isRoundPaused()
    if r4_149 then
      if r5_149 then
        guiSetText(player_pause, "Unpause ... " .. string.format("%.0f", r5_149 / 1000))
      else
        guiSetText(player_pause, "Unpause")
      end
      guiSetProperty(player_pause, "NormalTextColour", "C00080FF")
    end
  end
  function refreshCyclerResources()
    -- line: [1534, 1564] id: 150
    if not isElement(admin_window) then
      return 
    end
    local r0_150 = getTacticsData("Resources")
    if r0_150 and 0 < #r0_150 then
      local r1_150 = getTacticsData("ResourceCurrent")
      local r2_150 = guiGridListGetRowCount(server_cycler)
      for r6_150 = 1, math.max(r2_150, #r0_150), 1 do
        if r6_150 <= #r0_150 then
          local r7_150 = r0_150[r6_150][1]
          local r8_150 = r0_150[r6_150][2]
          local r9_150 = r0_150[r6_150][3]
          if r2_150 < r6_150 then
            guiGridListAddRow(server_cycler)
          end
          guiGridListSetItemText(server_cycler, r6_150 - 1, 1, tostring(r6_150), true, false)
          guiGridListSetItemText(server_cycler, r6_150 - 1, 2, r8_150, false, false)
          guiGridListSetItemData(server_cycler, r6_150 - 1, 2, r7_150)
          guiGridListSetItemText(server_cycler, r6_150 - 1, 3, r9_150, false, false)
          if r1_150 == r6_150 then
            guiGridListSetItemColor(server_cycler, r6_150 - 1, 1, 255, 40, 0)
            guiGridListSetItemColor(server_cycler, r6_150 - 1, 2, 255, 40, 0)
            guiGridListSetItemColor(server_cycler, r6_150 - 1, 3, 255, 40, 0)
          else
            guiGridListSetItemColor(server_cycler, r6_150 - 1, 1, 255, 255, 255)
            guiGridListSetItemColor(server_cycler, r6_150 - 1, 2, 255, 255, 255)
            guiGridListSetItemColor(server_cycler, r6_150 - 1, 3, 255, 255, 255)
          end
        else
          guiGridListRemoveRow(server_cycler, #r0_150)
        end
      end
    else
      guiGridListClear(server_cycler)
    end
  end
  function refreshRestores()
    -- line: [1565, 1575] id: 151
    if not isElement(restore_window) then
      return 
    end
    guiGridListClear(restore_list)
    local r0_151 = getTacticsData("Restores")
    if not r0_151 then
      return 
    end
    for r4_151, r5_151 in ipairs(r0_151) do
      local r6_151 = guiGridListAddRow(restore_list)
      guiGridListSetItemText(restore_list, r6_151, restore_name, tostring(r5_151[1]), false, false)
      guiGridListSetItemText(restore_list, r6_151, restore_team, getTeamName(r5_151[2]), false, false)
    end
  end
  function refreshTeamConfig()
    -- line: [1576, 1628] id: 152
    if not isElement(admin_window) then
      return 
    end
    for r3_152, r4_152 in ipairs(teams_teams) do
      destroyElement(r4_152.name)
      destroyElement(r4_152.color)
      if r3_152 > 1 then
        destroyElement(r4_152.side)
        destroyElement(r4_152.skin)
        destroyElement(r4_152.score)
        destroyElement(r4_152.remove)
      end
      teams_teams[r3_152] = nil
    end
    teams_teams = {}
    local r0_152 = 0
    local r1_152 = getElementsByType("team")
    for r5_152, r6_152 in ipairs(r1_152) do
      local r7_152 = nil
      local r8_152 = nil
      local r9_152 = nil
      local r10_152 = nil
      local r11_152 = guiCreateEdit(53, r0_152 * 25, 120, 21, getTeamName(r6_152), false, teams_scroller)
      if r5_152 > 1 then
        local r12_152 = getElementData(r6_152, "Side") or r5_152
        r7_152 = guiCreateEdit(8, r0_152 * 25, 40, 21, tostring(r12_152), false, teams_scroller)
        guiEditSetReadOnly(r7_152, true)
        guiSetProperty(r7_152, "WantsMultiClickEvents", "False")
        if r1_152[r12_152 + 1] then
          guiSetProperty(r7_152, "ReadOnlyBGColour", string.format("FF%02X%02X%02X", getTeamColor(r1_152[r12_152 + 1])))
        end
        local r13_152 = ""
        for r17_152, r18_152 in ipairs(getElementData(r6_152, "Skins") or {}) do
          if r17_152 > 1 then
            r13_152 = r13_152 .. "," .. tostring(r18_152)
          else
            r13_152 = tostring(r18_152)
          end
        end
        r8_152 = guiCreateEdit(178, r0_152 * 25, 80, 21, tostring(r13_152), false, teams_scroller)
        r9_152 = guiCreateEdit(263, r0_152 * 25, 50, 21, tostring(getElementData(r6_152, "Score") or 0), false, teams_scroller)
      end
      local r12_152 = guiCreateEdit(318, r0_152 * 25, 50, 21, "", false, teams_scroller)
      guiEditSetReadOnly(r12_152, true)
      guiSetProperty(r12_152, "ReadOnlyBGColour", string.format("FF%02X%02X%02X", getTeamColor(r6_152)))
      if r5_152 > 1 then
        r10_152 = guiCreateButton(373, r0_152 * 25, 70, 21, "Remove", false, teams_scroller)
        guiSetFont(r10_152, "default-bold-small")
        guiSetProperty(r10_152, "NormalTextColour", "C0FF0000")
      end
      if r5_152 > 1 then
        table.insert(teams_teams, {
          name = r11_152,
          color = r12_152,
          side = r7_152,
          skin = r8_152,
          score = r9_152,
          remove = r10_152,
        })
      else
        table.insert(teams_teams, {
          name = r11_152,
          color = r12_152,
        })
      end
      r0_152 = r0_152 + 1
    end
    guiSetPosition(teams_apply, 298, r0_152 * 25, false)
    guiSetPosition(teams_addteam, 373, r0_152 * 25, false)
  end
  function refreshVehicleConfig()
    -- line: [1629, 1679] id: 153
    if not isElement(admin_window) then
      return 
    end
    local r0_153 = {}
    local r1_153 = {}
    local r2_153 = getTacticsData("disabled_vehicles") or {}
    for r6_153 = 400, 611, 1 do
      if #getVehicleNameFromModel(r6_153) > 0 then
        if r2_153[r6_153] then
          table.insert(r1_153, {
            r6_153,
            getVehicleNameFromModel(r6_153)
          })
        else
          table.insert(r0_153, {
            r6_153,
            getVehicleNameFromModel(r6_153)
          })
        end
      end
    end
    table.sort(r0_153, function(r0_154, r1_154)
      -- line: [1643, 1643] id: 154
      return r0_154[2] < r1_154[2]
    end)
    table.sort(r1_153, function(r0_155, r1_155)
      -- line: [1644, 1644] id: 155
      return r0_155[2] < r1_155[2]
    end)
    local r3_153 = guiGridListGetRowCount(vehicles_disabled)
    local r4_153 = guiGridListGetRowCount(vehicles_enabled)
    for r8_153 = 0, math.max(#r1_153, r3_153), 1 do
      if r8_153 < #r1_153 then
        local r9_153, r10_153 = unpack(r1_153[r8_153 + 1])
        if r8_153 < r3_153 then
          guiGridListSetItemText(vehicles_disabled, r8_153, 1, r10_153, false, false)
          guiGridListSetItemData(vehicles_disabled, r8_153, 1, tostring(r9_153))
        else
          local r11_153 = guiGridListAddRow(vehicles_disabled)
          guiGridListSetItemText(vehicles_disabled, r11_153, 1, r10_153, false, false)
          guiGridListSetItemData(vehicles_disabled, r11_153, 1, tostring(r9_153))
          guiGridListSetItemColor(vehicles_disabled, r11_153, 1, 255, 0, 0)
        end
      else
        guiGridListRemoveRow(vehicles_disabled, #r1_153)
      end
    end
    for r8_153 = 0, math.max(#r0_153, r4_153), 1 do
      if r8_153 < #r0_153 then
        local r9_153, r10_153 = unpack(r0_153[r8_153 + 1])
        if r8_153 < r4_153 then
          guiGridListSetItemText(vehicles_enabled, r8_153, 1, r10_153, false, false)
          guiGridListSetItemData(vehicles_enabled, r8_153, 1, tostring(r9_153))
        else
          local r11_153 = guiGridListAddRow(vehicles_enabled)
          guiGridListSetItemText(vehicles_enabled, r11_153, 1, r10_153, false, false)
          guiGridListSetItemData(vehicles_enabled, r11_153, 1, tostring(r9_153))
          guiGridListSetItemColor(vehicles_enabled, r11_153, 1, 0, 255, 0)
        end
      else
        guiGridListRemoveRow(vehicles_enabled, #r0_153)
      end
    end
  end
  function toggleAdmin()
    -- line: [1680, 1711] id: 156
    if guiGetInputEnabled() then
      return 
    end
    if not isElement(admin_window) or not guiGetVisible(admin_window) then
      callServerFunction("showAdminPanel", localPlayer)
    else
      if isTimer(r2_130) then
        killTimer(r2_130)
      end
      if guiCheckBoxGetSelected(config_performance_adminpanel) then
        destroyElement(admin_window)
        if isElement(restore_window) then
          destroyElement(restore_window)
        end
        if isElement(redirect_window) then
          destroyElement(redirect_window)
        end
        if isElement(save_window) then
          destroyElement(save_window)
        end
        if isElement(add_window) then
          destroyElement(add_window)
        end
        if isElement(rules_window) then
          destroyElement(rules_window)
        end
        if isElement(palette_window) then
          destroyElement(palette_window)
        end
        if isElement(rename_window) then
          destroyElement(rename_window)
        end
        if isElement(screen_window) then
          destroyElement(screen_window)
        end
        if isElement(mods_window) then
          destroyElement(mods_window)
        end
      else
        guiSetVisible(admin_window, false)
        guiSetVisible(restore_window, false)
        guiSetVisible(redirect_window, false)
        guiSetVisible(save_window, false)
        guiSetVisible(add_window, false)
        guiSetVisible(rules_window, false)
        guiSetVisible(palette_window, false)
        guiSetVisible(rename_window, false)
        guiSetVisible(screen_window, false)
        guiSetVisible(mods_window, false)
      end
      if isAllGuiHidden() then
        showCursor(false)
      end
    end
  end
  function showClientAdminPanel(r0_157)
    -- line: [1712, 1737] id: 157
    if not isElement(admin_window) or not guiGetVisible(admin_window) then
      if not isElement(admin_window) then
        createAdminPanel()
      end
      callServerFunction("refreshConfiglist", localPlayer)
      if isTimer(r2_130) then
        killTimer(r2_130)
      end
      r2_130 = setTimer(updateAdmin, 500, 0)
      guiSetEnabled(config_list, r0_157.configs)
      guiSetEnabled(config_delete, r0_157.configs)
      guiSetEnabled(config_save, r0_157.configs)
      guiSetEnabled(config_rename, r0_157.configs)
      guiSetEnabled(config_add, r0_157.configs)
      guiSetEnabled(admin_tab_players, r0_157.tab_players)
      guiSetEnabled(admin_tab_maps, r0_157.tab_maps)
      guiSetEnabled(admin_tab_settings, r0_157.tab_settings)
      guiSetEnabled(admin_tab_teams, r0_157.tab_teams)
      guiSetEnabled(admin_tab_weapons, r0_157.tab_weapons)
      guiSetEnabled(admin_tab_vehicles, r0_157.tab_vehicles)
      guiSetEnabled(admin_tab_weather, r0_157.tab_weather)
      guiSetEnabled(admin_tab_shooting, r0_157.tab_shooting)
      guiSetEnabled(admin_tab_handling, r0_157.tab_handling)
      guiSetEnabled(admin_tab_anticheat, r0_157.tab_anticheat)
      guiBringToFront(admin_window)
      guiSetVisible(admin_window, true)
      showCursor(true)
    end
  end
  function onClientGUIAccepted(r0_158)
    -- line: [1738, 1742] id: 158
    if source == rules_edit then
      triggerEvent("onClientGUIClick", rules_ok, "left", "up")
    end
  end
  function onClientGUIScroll(r0_159)
    -- line: [1743, 1776] id: 159
    if source == wind_slide then
      guiSetText(wind_speed, string.format("%.1f", 0.5 * guiScrollBarGetScrollPosition(wind_slide)))
    end
    if source == rain_slide then
      guiSetText(rain_level, string.format("%.1f", 0.02 * guiScrollBarGetScrollPosition(rain_slide)))
    end
    if source == sun_sizeslide then
      guiSetText(sun_size, string.format("%.1f", 0.5 * guiScrollBarGetScrollPosition(sun_sizeslide)))
    end
    if source == farclip_slide then
      guiSetText(farclip_distance, string.format("%.1f", 30 * guiScrollBarGetScrollPosition(farclip_slide)))
    end
    if source == fog_slide then
      guiSetText(fog_distance, string.format("%.1f", 40 * guiScrollBarGetScrollPosition(fog_slide) - 1000))
    end
    if source == heat_levelslide then
      guiSetText(heat_level, string.format("%.1f", 2.55 * guiScrollBarGetScrollPosition(heat_levelslide)))
    end
    if source == wave_heightslide then
      guiSetText(wave_height, string.format("%.1f", 0.1 * guiScrollBarGetScrollPosition(wave_heightslide)))
    end
    if source == water_levelslide then
      guiSetText(water_level, string.format("%.1f", 4 * guiScrollBarGetScrollPosition(water_levelslide) - 200))
    end
  end
  function onClientGUIClick(r0_160, r1_160, r2_160, r3_160)
    -- line: [1777, 3195] id: 160
    -- notice: unreachable block#609
    if isElement(admin_window) and guiGetVisible(player_list) then
      r3_130 = {}
      local r4_160 = guiGridListGetSelectedItems(player_list)
      if r4_160 then
        for r8_160, r9_160 in ipairs(r4_160) do
          if r9_160.column == player_id then
            local r10_160 = getElementByID(tostring(guiGridListGetItemText(player_list, r9_160.row, player_id)))
            if r10_160 == localPlayer then
              table.insert(r3_130, r10_160)
            else
              table.insert(r3_130, 1, r10_160)
            end
          end
        end
      end
      if #r3_130 == 0 then
        r3_130 = nil
      end
    end
    if source == rules_time_up or source == rules_time_down then
      local r4_160 = guiGetText(rules_time)
      local r5_160 = tonumber(guiGetProperty(rules_time, "CaratIndex"))
      local r6_160 = gettok(r4_160, 1, string.byte("."))
      local r7_160 = tonumber(gettok(r6_160, 1, string.byte(":"))) or 0
      local r8_160 = tonumber(gettok(r6_160, 2, string.byte(":"))) or 0
      local r9_160 = tonumber(gettok(r6_160, 3, string.byte(":"))) or 0
      local r10_160 = tonumber(gettok(r4_160, 2, string.byte("."))) or 0
      if r5_160 < 3 then
        if source == rules_time_up then
          r7_160 = (r7_160 + 1) % 24
        else
          r7_160 = (r7_160 - 1) % 24
        end
        guiSetText(rules_time, string.format("%02i:%02i:%02i.%i", r7_160, r8_160, r9_160, r10_160))
        guiEditSetCaretIndex(rules_time, 2)
        guiSetProperty(rules_time, "SelectionLength", "-2")
      elseif r5_160 < 6 then
        if source == rules_time_up then
          r8_160 = (r8_160 + 1) % 60
        else
          r8_160 = (r8_160 - 1) % 60
        end
        guiSetText(rules_time, string.format("%02i:%02i:%02i.%i", r7_160, r8_160, r9_160, r10_160))
        guiEditSetCaretIndex(rules_time, 5)
        guiSetProperty(rules_time, "SelectionLength", "-2")
      elseif r5_160 < 9 then
        if source == rules_time_up then
          r9_160 = (r9_160 + 1) % 60
        else
          r9_160 = (r9_160 - 1) % 60
        end
        guiSetText(rules_time, string.format("%02i:%02i:%02i.%i", r7_160, r8_160, r9_160, r10_160))
        guiEditSetCaretIndex(rules_time, 8)
        guiSetProperty(rules_time, "SelectionLength", "-2")
      else
        if source == rules_time_up then
          r10_160 = (r10_160 + 1) % 10
        else
          r10_160 = (r10_160 - 1) % 10
        end
        guiSetText(rules_time, string.format("%02i:%02i:%02i.%i", r7_160, r8_160, r9_160, r10_160))
        guiEditSetCaretIndex(rules_time, 10)
        guiSetProperty(rules_time, "SelectionLength", "-1")
      end
      guiBringToFront(rules_time)
    end
    if r0_160 ~= "left" and isElement(admin_window) and guiGetVisible(admin_tab_teams) then
      for r7_160, r8_160 in ipairs(teams_teams) do
        if source == r8_160.side then
          local r9_160 = getElementsByType("team")
          table.remove(r9_160, 1)
          local r10_160 = tonumber(guiGetText(source))
          if r10_160 <= 1 then
            r10_160 = #r9_160 or r10_160 - 1
          else
            goto label_300	-- block#48 is visited secondly
          end
          guiSetText(source, tostring(r10_160))
          guiSetProperty(source, "ReadOnlyBGColour", string.format("FF%02X%02X%02X", getTeamColor(r9_160[r10_160])))
        end
        return 
      end
    end
    if source == window_updates then
      callServerFunction("onPlayerCheckUpdates", localPlayer)
      return 
    end
    if source == window_close then
      toggleAdmin()
      return 
    end
    if source == player_list then
      updateAdmin()
      return 
    end
    if source == player_setteam then
      if not r3_130 then
        return 
      end
      local r4_160 = getTeamFromName(guiGetText(player_setteam))
      for r8_160, r9_160 in ipairs(r3_130) do
        triggerServerEvent("onPlayerTeamSelect", r9_160, r4_160)
      end
      return 
    end
    if source == player_balance then
      callServerFunction("balanceTeams", localPlayer)
      return 
    end
    if source == player_specskinbtn then
      if not r3_130 or 1 < #r3_130 then
        return 
      end
      guiCheckBoxSetSelected(player_specskin, not guiCheckBoxGetSelected(player_specskin))
      callServerFunction("setElementData", r3_130[1], "spectateskin", guiCheckBoxGetSelected(player_specskin))
      return 
    end
    if source == player_specskin then
      if not r3_130 or 1 < #r3_130 then
        return 
      end
      callServerFunction("setElementData", r3_130[1], "spectateskin", guiCheckBoxGetSelected(player_specskin))
      return 
    end
    if source == player_heal then
      if not r3_130 then
        return 
      end
      for r7_160, r8_160 in ipairs(r3_130) do
        callServerFunction("setElementHealth", r8_160, 200)
        callServerFunction("callClientFunction", root, "outputLangString", "player_healed", getPlayerName(r8_160))
      end
      return 
    end
    if source == player_fix then
      if not r3_130 then
        return 
      end
      for r7_160, r8_160 in ipairs(r3_130) do
        local r9_160 = getPedOccupiedVehicle(r8_160)
        if r9_160 then
          callServerFunction("fixVehicle", r9_160)
          callServerFunction("callClientFunction", root, "outputLangString", "vehicle_healed", getPlayerName(r8_160))
        end
      end
      return 
    end
    if source == player_healall then
      for r7_160, r8_160 in ipairs(getElementsByType("player")) do
        callServerFunction("setElementHealth", r8_160, 1000)
      end
      callServerFunction("callClientFunction", root, "outputLangString", "player_all_healed")
      return 
    end
    if source == player_fixall then
      for r7_160, r8_160 in ipairs(getElementsByType("player")) do
        local r9_160 = getPedOccupiedVehicle(r8_160)
        if r9_160 then
          callServerFunction("fixVehicle", r9_160)
        end
      end
      callServerFunction("callClientFunction", root, "outputLangString", "vehicle_all_healed")
      return 
    end
    if source == player_swapsides then
      callServerFunction("swapTeams")
      callServerFunction("callClientFunction", root, "outputLangString", "team_swaped")
      return 
    end
    if source == player_add then
      if not r3_130 then
        return 
      end
      for r7_160, r8_160 in ipairs(r3_130) do
        if getPlayerTeam(r8_160) and getPlayerTeam(r8_160) ~= getElementsByType("team")[1] and not getElementData(r8_160, "Loading") then
          if getElementData(r8_160, "Status") == "Play" then
            callServerFunction("removePlayer", localPlayer, "", getElementID(r8_160))
          else
            callServerFunction("addPlayer", localPlayer, "", getElementID(r8_160))
          end
        end
      end
      return 
    end
    if source == player_restore then
      if not r3_130 or 1 < #r3_130 then
        return 
      end
      callServerFunction("restorePlayer", localPlayer, "", getElementID(r3_130[1]))
      return 
    end
    if source == restore_yes then
      local r4_160 = guiGridListGetSelectedItem(restore_list)
      if r4_160 == -1 then
        return 
      end
      callServerFunction("restorePlayerLoad", restore_player, r4_160 + 1)
      if guiCheckBoxGetSelected(config_performance_adminpanel) then
        destroyElement(restore_window)
      else
        guiSetVisible(restore_window, false)
      end
      restore_player = false
      return 
    end
    if source == restore_no then
      if guiCheckBoxGetSelected(config_performance_adminpanel) then
        destroyElement(restore_window)
      else
        guiSetVisible(restore_window, false)
      end
      restore_player = false
      if isAllGuiHidden() then
        showCursor(false)
      end
      return 
    end
    if source == player_gunmenu then
      if not r3_130 then
        return 
      end
      for r7_160, r8_160 in ipairs(r3_130) do
        callServerFunction("setElementData", r8_160, "Weapons", true)
        callServerFunction("callClientFunction", root, "outputLangString", "player_can_weapon_choice", getPlayerName(r8_160))
      end
      return 
    end
    if source == player_pause then
      togglePause()
      return 
    end
    if source == maps_refresh then
      callServerFunction("refreshMaps", localPlayer, true)
      return 
    end
    if source == maps_include then
      updateAdminMaps()
      return 
    end
    if source == maps_next then
      local r4_160 = guiGridListGetSelectedItems(server_maps)
      if #r4_160 ~= 2 then
        return 
      end
      callServerFunction("setNextMap", tostring(guiGridListGetItemData(server_maps, r4_160[1].row, 1)))
      return 
    end
    if source == maps_cancelnext then
      callServerFunction("cancelNextMap")
      return 
    end
    if source == maps_switch then
      local r4_160 = guiGridListGetSelectedItems(server_maps)
      if not r4_160 then
        return 
      end
      local r5_160 = getTacticsData("Resources") or {}
      local r6_160 = 1
      for r10_160, r11_160 in ipairs(r4_160) do
        if r11_160.column == 1 then
          local r12_160 = guiGridListGetItemData(server_maps, r11_160.row, 1)
          local r13_160 = guiGridListGetItemText(server_maps, r11_160.row, 1)
          local r14_160 = guiGridListGetItemText(server_maps, r11_160.row, 2)
          local r15_160 = guiGridListGetSelectedItems(server_cycler)
          if #r15_160 == 2 then
            table.insert(r5_160, r15_160[1].row + r6_160, {
              r12_160,
              r13_160,
              r14_160
            })
          else
            table.insert(r5_160, {
              r12_160,
              r13_160,
              r14_160
            })
          end
          r6_160 = r6_160 + 1
        end
      end
      setTacticsData(r5_160, "Resources")
      return 
    end
    if source == maps_disable then
      local r4_160 = guiGridListGetSelectedItems(server_maps)
      if not r4_160 then
        return 
      end
      local r5_160 = getTacticsData("map_disabled") or {}
      local r6_160 = 1
      for r10_160, r11_160 in ipairs(r4_160) do
        if r11_160.column == 1 then
          local r12_160 = guiGridListGetItemData(server_maps, r11_160.row, 1)
          if #guiGridListGetItemText(server_maps, r11_160.row, 1) < #r12_160 then
            local r14_160 = guiGridListGetItemColor(server_maps, r11_160.row, 1)
            if not r5_160[r12_160] then
              r5_160[r12_160] = true
            else
              r5_160[r12_160] = nil
            end
          end
        end
      end
      setTacticsData(r5_160, "map_disabled")
      return 
    end
    if source == maps_end then
      callServerFunction("onRoundStop", localPlayer)
      return 
    end
    if source == cycler_switch then
      local r4_160 = guiGridListGetSelectedItems(server_cycler)
      if not r4_160 then
        return 
      end
      local r5_160 = getTacticsData("Resources") or {}
      local r6_160 = 1
      for r10_160, r11_160 in ipairs(r4_160) do
        if r11_160.column == 1 then
          table.remove(r5_160, r11_160.row + r6_160)
          r6_160 = r6_160 - 1
        end
      end
      setTacticsData(r5_160, "Resources")
      return 
    end
    if source == cycler_moveup then
      local r4_160 = guiGridListGetSelectedItem(server_cycler)
      if r4_160 and 0 < r4_160 then
        local r5_160 = getTacticsData("Resources") or {}
        local r6_160 = r5_160[r4_160 + 1]
        if r6_160 then
          table.remove(r5_160, r4_160 + 1)
          table.insert(r5_160, r4_160, r6_160)
          setTacticsData(r5_160, "Resources")
          guiGridListSetSelectedItem(server_cycler, r4_160 - 1, 2)
        end
      end
      return 
    end
    if source == cycler_movedown then
      local r4_160 = guiGridListGetSelectedItem(server_cycler)
      if r4_160 > -1 then
        local r5_160 = getTacticsData("Resources") or {}
        if r4_160 + 1 < #r5_160 then
          local r6_160 = r5_160[r4_160 + 1]
          if r6_160 then
            table.remove(r5_160, r4_160 + 1)
            table.insert(r5_160, r4_160 + 2, r6_160)
            setTacticsData(r5_160, "Resources")
            guiGridListSetSelectedItem(server_cycler, r4_160 + 1, 2)
          end
        end
      end
      return 
    end
    if source == cycler_clear then
      setTacticsData({}, "Resources")
      return 
    end
    if source == cycler_randomize then
      local r4_160 = getTacticsData("Resources") or {}
      local r5_160 = {}
      while 0 < #r4_160 do
        local r6_160 = math.random(#r4_160)
        table.insert(r5_160, r4_160[r6_160])
        table.remove(r4_160, r6_160)
      end
      setTacticsData(r5_160, "Resources")
      return 
    end
    if source == player_resetstats then
      callServerFunction("resetStats", localPlayer)
      return 
    end
    if source == player_redirect then
      if not isElement(redirect_window) then
        createAdminRedirect()
      end
      guiBringToFront(redirect_window)
      guiSetVisible(redirect_window, true)
      return 
    end
    if source == redirect_reconnect then
      if guiCheckBoxGetSelected(redirect_reconnect) then
        guiSetEnabled(redirect_ip, false)
        guiSetEnabled(redirect_port, false)
        guiSetEnabled(redirect_password, false)
      else
        guiSetEnabled(redirect_ip, true)
        guiSetEnabled(redirect_port, true)
        guiSetEnabled(redirect_password, true)
      end
      return 
    end
    if source == redirect_yes then
      if not r3_130 then
        return 
      end
      local r4_160 = nil
      local r5_160 = nil
      local r6_160 = nil
      if not guiCheckBoxGetSelected(redirect_reconnect) then
        r4_160 = guiGetText(redirect_ip)
        r5_160 = guiGetText(redirect_port)
        r6_160 = guiGetText(redirect_password)
        if #r6_160 == 0 then
          r6_160 = false
        end
      end
      callServerFunction("connectPlayers", localPlayer, r3_130, r4_160, r5_160, r6_160)
      if guiCheckBoxGetSelected(config_performance_adminpanel) then
        destroyElement(redirect_window)
      else
        guiSetVisible(redirect_window, false)
      end
      return 
    end
    if source == redirect_no then
      if guiCheckBoxGetSelected(config_performance_adminpanel) then
        destroyElement(redirect_window)
      else
        guiSetVisible(redirect_window, false)
      end
      return 
    end
    if isElement(admin_window) and guiGetVisible(admin_tab_teams) then
      for r7_160, r8_160 in ipairs(teams_teams) do
        if source == r8_160.side then
          local r9_160 = getElementsByType("team")
          table.remove(r9_160, 1)
          local r10_160 = tonumber(guiGetText(source))
          if #r9_160 <= r10_160 then
            r10_160 = 1 or r10_160 + 1
          else
            goto label_1258	-- block#250 is visited secondly
          end
          guiSetText(source, tostring(r10_160))
          guiSetProperty(source, "ReadOnlyBGColour", string.format("FF%02X%02X%02X", getTeamColor(r9_160[r10_160])))
          return 
        end
        if source == r8_160.color then
          if not isElement(palette_window) then
            createAdminPalette()
          end
          palette_element = source
          local r10_160, r11_160, r12_160 = getColorFromString("#" .. string.sub(guiGetProperty(source, "ReadOnlyBGColour"), 3, -1))
          guiSetText(palette_rr, tostring(r10_160))
          guiSetText(palette_gg, tostring(r11_160))
          guiSetText(palette_bb, tostring(r12_160))
          guiBringToFront(palette_window)
          guiSetVisible(palette_window, true)
          return 
        end
        if source == r8_160.remove then
          callServerFunction("removeServerTeam", getElementsByType("team")[r7_160])
          callServerFunction("callClientFunction", root, "refreshTeamConfig")
          return 
        end
      end
    end
    if source == palette_ok then
      if guiCheckBoxGetSelected(config_performance_adminpanel) then
        destroyElement(palette_window)
      else
        guiSetVisible(palette_window, false)
      end
      if isElement(palette_element) then
        guiSetProperty(palette_element, "ReadOnlyBGColour", guiGetText(palette_hex))
        guiBringToFront(palette_element)
        triggerEvent("onPaletteSetColor", palette_element, guiGetText(palette_hex))
      end
      palette_element = nil
      return 
    end
    if source == palette_cancel then
      if guiCheckBoxGetSelected(config_performance_adminpanel) then
        destroyElement(palette_window)
      else
        guiSetVisible(palette_window, false)
      end
      return 
    end
    if source == teams_apply then
      local r4_160 = {}
      for r8_160, r9_160 in ipairs(getElementsByType("team")) do
        local r10_160 = {}
        if r8_160 > 1 then
          r10_160.side = guiGetText(teams_teams[r8_160].side)
          r10_160.skin = guiGetText(teams_teams[r8_160].skin)
          r10_160.score = tonumber(guiGetText(teams_teams[r8_160].score))
        end
        r10_160.name = guiGetText(teams_teams[r8_160].name)
        _, r10_160.rr, r10_160.gg, r10_160.bb = getColorFromString("#" .. guiGetProperty(teams_teams[r8_160].color, "ReadOnlyBGColour"))
        table.insert(r4_160, r10_160)
      end
      callServerFunction("saveTeamsConfig", r4_160)
      return 
    end
    if source == teams_addteam then
      callServerFunction("addServerTeam")
      callServerFunction("callClientFunction", root, "refreshTeamConfig")
      return 
    end
    if source == vehicles_enable then
      local r4_160 = guiGridListGetSelectedItems(vehicles_disabled)
      if not r4_160 then
        return 
      end
      local r5_160 = getTacticsData("disabled_vehicles") or {}
      for r9_160, r10_160 in ipairs(r4_160) do
        r5_160[tonumber(guiGridListGetItemData(vehicles_disabled, r10_160.row, 1))] = nil
      end
      setTacticsData(r5_160, "disabled_vehicles")
      return 
    end
    if source == vehicles_disable then
      local r4_160 = guiGridListGetSelectedItems(vehicles_enabled)
      if not r4_160 then
        return 
      end
      local r5_160 = getTacticsData("disabled_vehicles") or {}
      for r9_160, r10_160 in ipairs(r4_160) do
        r5_160[tonumber(guiGridListGetItemData(vehicles_enabled, r10_160.row, 1))] = true
      end
      setTacticsData(r5_160, "disabled_vehicles")
      return 
    end
    if source == config_save then
      if not isElement(save_window) then
        createAdminSaveConfig()
      end
      guiBringToFront(save_window)
      guiSetVisible(save_window, true)
      return 
    end
    if source == config_rename then
      if not isElement(admin_window) then
        return 
      end
      local r4_160 = guiGridListGetSelectedItem(config_list)
      if r4_160 == -1 then
        return 
      end
      local r5_160 = guiGridListGetItemText(config_list, r4_160, 1)
      if r5_160 == "_default" then
        return outputChatBox("Not available", 255, 0, 0)
      end
      if not isElement(rename_window) then
        createAdminRenameConfig()
      end
      guiSetText(rename_name, r5_160)
      guiBringToFront(rename_window)
      guiSetVisible(rename_window, true)
      return 
    end
    if source == rename_ok then
      local r4_160 = guiGridListGetSelectedItem(config_list)
      if r4_160 == -1 then
        return 
      end
      local r5_160 = guiGridListGetItemText(config_list, r4_160, 1)
      if r5_160 == "_default" then
        return outputChatBox("Not available", 255, 0, 0)
      end
      local r6_160 = guiGetText(rename_name)
      if #r6_160 == 0 or not r6_160 then
        return 
      end
      callServerFunction("renameConfig", r5_160, r6_160, localPlayer)
      if guiCheckBoxGetSelected(config_performance_adminpanel) then
        destroyElement(rename_window)
      else
        guiSetVisible(rename_window, false)
      end
      return 
    end
    if source == rename_cancel then
      if guiCheckBoxGetSelected(config_performance_adminpanel) then
        destroyElement(rename_window)
      else
        guiSetVisible(rename_window, false)
      end
      return 
    end
    if source == config_add then
      if not isElement(add_window) then
        createAdminAddConfig()
      end
      guiBringToFront(add_window)
      guiSetVisible(add_window, true)
      return 
    end
    if source == add_ok then
      local r4_160 = guiGetText(add_name)
      if #r4_160 == 0 or not r4_160 then
        return 
      end
      callServerFunction("addConfig", r4_160, localPlayer)
      if guiCheckBoxGetSelected(config_performance_adminpanel) then
        destroyElement(add_window)
      else
        guiSetVisible(add_window, false)
      end
      return 
    end
    if source == add_cancel then
      if guiCheckBoxGetSelected(config_performance_adminpanel) then
        destroyElement(add_window)
      else
        guiSetVisible(add_window, false)
      end
      return 
    end
    if source == save_ok then
      if not isElement(save_window) then
        createAdminSaveConfig()
      end
      local r4_160 = guiGetText(save_name)
      if #r4_160 == 0 or not r4_160 then
        return 
      end
      if r4_160 == "_default" then
        return outputChatBox("Not available", 255, 0, 0)
      end
      local r5_160 = {}
      if guiCheckBoxGetSelected(save_all) then
        r5_160 = {
          Maps = true,
          Settings = true,
          Teams = true,
          Weapons = true,
          Vehicles = true,
          Weather = true,
          Shooting = true,
          Handling = true,
          AC = true,
        }
      else
        r5_160 = {
          Maps = guiCheckBoxGetSelected(save_maps),
          Settings = guiCheckBoxGetSelected(save_settings),
          Teams = guiCheckBoxGetSelected(save_teams),
          Weapons = guiCheckBoxGetSelected(save_weapons),
          Vehicles = guiCheckBoxGetSelected(save_vehicles),
          Weather = guiCheckBoxGetSelected(save_weather),
          Shooting = guiCheckBoxGetSelected(save_shooting),
          Handling = guiCheckBoxGetSelected(save_handling),
          AC = guiCheckBoxGetSelected(save_anticheat),
        }
      end
      if not guiCheckBoxGetSelected(window_expert) then
        r5_160.Shooting = false
        r5_160.Handling = false
        r5_160.AC = false
      end
      callServerFunction("saveConfig", r4_160, localPlayer, r5_160)
      if guiCheckBoxGetSelected(config_performance_adminpanel) then
        destroyElement(save_window)
      else
        guiSetVisible(save_window, false)
      end
      return 
    end
    if source == save_all then
      if guiCheckBoxGetSelected(save_all) then
        guiSetEnabled(save_maps, false)
        guiSetEnabled(save_settings, false)
        guiSetEnabled(save_teams, false)
        guiSetEnabled(save_weapons, false)
        guiSetEnabled(save_vehicles, false)
        guiSetEnabled(save_weather, false)
        guiSetEnabled(save_shooting, false)
        guiSetEnabled(save_handling, false)
        guiSetEnabled(save_anticheat, false)
      else
        guiSetEnabled(save_maps, true)
        guiSetEnabled(save_settings, true)
        guiSetEnabled(save_teams, true)
        guiSetEnabled(save_weapons, true)
        guiSetEnabled(save_vehicles, true)
        guiSetEnabled(save_weather, true)
        guiSetEnabled(save_shooting, true)
        guiSetEnabled(save_handling, true)
        guiSetEnabled(save_anticheat, true)
      end
      return 
    end
    if source == save_cancel then
      if guiCheckBoxGetSelected(config_performance_adminpanel) then
        destroyElement(save_window)
      else
        guiSetVisible(save_window, false)
      end
      return 
    end
    if source == config_delete then
      local r4_160 = guiGridListGetSelectedItem(config_list)
      if r4_160 == -1 then
        return 
      end
      local r5_160 = guiGridListGetItemText(config_list, r4_160, 1)
      if r5_160 == "_default" then
        return outputChatBox("Not available", 255, 0, 0)
      end
      callServerFunction("deleteConfig", r5_160, localPlayer)
      return 
    end
    if source == config_list then
      local r4_160 = guiGridListGetSelectedItem(config_list)
      if r4_160 == -1 then
        guiSetText(config_flags, "")
        return 
      end
      local r5_160 = guiGridListGetItemText(config_list, r4_160, 1)
      local r6_160 = guiGridListGetItemData(config_list, r4_160, 1)
      if isElement(save_window) then
        guiSetText(save_name, r5_160)
      end
      guiSetText(config_flags, r6_160)
      return 
    end
    if source == modes_list then
      local r4_160 = guiGridListGetSelectedItem(modes_list)
      if r4_160 == -1 then
        return guiGridListClear(modes_rules)
      end
      local r5_160 = guiGridListGetItemText(modes_list, r4_160, 1)
      local r6_160 = {}
      if r5_160 == "settings" then
        for r10_160, r11_160 in pairs(getTacticsData("settings") or {}) do
          local r12_160 = string.find(tostring(r11_160), "|")
          if r12_160 then
            table.insert(r6_160, {
              r10_160,
              string.sub(r11_160, 1, r12_160 - 1),
              r11_160
            })
          else
            table.insert(r6_160, {
              r10_160,
              r11_160,
              r11_160
            })
          end
        end
      elseif r5_160 == "glitches" then
        for r10_160, r11_160 in pairs(getTacticsData("glitches") or {}) do
          local r12_160 = string.find(tostring(r11_160), "|")
          if r12_160 then
            table.insert(r6_160, {
              r10_160,
              string.sub(r11_160, 1, r12_160 - 1),
              r11_160
            })
          else
            table.insert(r6_160, {
              r10_160,
              r11_160,
              r11_160
            })
          end
        end
      elseif r5_160 == "cheats" then
        for r10_160, r11_160 in pairs(getTacticsData("cheats") or {}) do
          local r12_160 = string.find(tostring(r11_160), "|")
          if r12_160 then
            table.insert(r6_160, {
              r10_160,
              string.sub(r11_160, 1, r12_160 - 1),
              r11_160
            })
          else
            table.insert(r6_160, {
              r10_160,
              r11_160,
              r11_160
            })
          end
        end
      elseif r5_160 == "limites" then
        for r10_160, r11_160 in pairs(getTacticsData("limites") or {}) do
          local r12_160 = string.find(tostring(r11_160), "|")
          if r12_160 then
            table.insert(r6_160, {
              r10_160,
              string.sub(r11_160, 1, r12_160 - 1),
              r11_160
            })
          else
            table.insert(r6_160, {
              r10_160,
              r11_160,
              r11_160
            })
          end
        end
      else
        for r10_160, r11_160 in pairs(getTacticsData("modes", r5_160) or {}) do
          if r10_160 ~= "name" then
            local r12_160 = string.find(tostring(r11_160), "|")
            if r12_160 then
              table.insert(r6_160, {
                r10_160,
                string.sub(r11_160, 1, r12_160 - 1),
                r11_160
              })
            else
              table.insert(r6_160, {
                r10_160,
                r11_160,
                r11_160
              })
            end
          end
        end
      end
      table.sort(r6_160, function(r0_161, r1_161)
        -- line: [2450, 2450] id: 161
        return r0_161[1] < r1_161[1]
      end)
      local r7_160 = guiGridListGetRowCount(modes_rules)
      for r11_160 = 0, math.max(r7_160, #r6_160), 1 do
        if r11_160 < #r6_160 then
          local r12_160 = tostring(r6_160[r11_160 + 1][1])
          local r13_160 = tostring(r6_160[r11_160 + 1][2])
          local r14_160 = tostring(r6_160[r11_160 + 1][3])
          if r11_160 < r7_160 then
            guiGridListSetItemText(modes_rules, r11_160, 1, r12_160, false, false)
            guiGridListSetItemText(modes_rules, r11_160, 2, r13_160, false, false)
            guiGridListSetItemData(modes_rules, r11_160, 2, r14_160)
            if r13_160 == "true" then
              guiGridListSetItemColor(modes_rules, r11_160, 2, 0, 255, 0)
            elseif r13_160 == "false" then
              guiGridListSetItemColor(modes_rules, r11_160, 2, 255, 0, 0)
            elseif r13_160 ~= r14_160 then
              guiGridListSetItemColor(modes_rules, r11_160, 2, 255, 255, 0)
            else
              guiGridListSetItemColor(modes_rules, r11_160, 2, 255, 255, 255)
            end
          else
            local r15_160 = guiGridListAddRow(modes_rules)
            guiGridListSetItemText(modes_rules, r15_160, 1, r12_160, false, false)
            guiGridListSetItemText(modes_rules, r15_160, 2, r13_160, false, false)
            guiGridListSetItemData(modes_rules, r15_160, 2, r14_160)
            if r13_160 == "true" then
              guiGridListSetItemColor(modes_rules, r15_160, 2, 0, 255, 0)
            elseif r13_160 == "false" then
              guiGridListSetItemColor(modes_rules, r15_160, 2, 255, 0, 0)
            elseif r13_160 ~= r14_160 then
              guiGridListSetItemColor(modes_rules, r15_160, 2, 255, 255, 0)
            else
              guiGridListSetItemColor(modes_rules, r15_160, 2, 255, 255, 255)
            end
          end
        else
          guiGridListRemoveRow(modes_rules, #r6_160, 1)
        end
      end
      return 
    end
    if source == rules_ok then
      local r4_160 = guiGridListGetSelectedItem(modes_list)
      local r5_160 = guiGridListGetSelectedItem(modes_rules)
      local r6_160 = nil
      if guiGetVisible(rules_edit) then
        r6_160 = guiGetText(rules_edit)
        if getDataType(r6_160) ~= "string" then
          r6_160 = nil
        end
      elseif guiGetVisible(rules_list) then
        local r7_160 = guiGridListGetSelectedItem(rules_list)
        if r7_160 > -1 then
          r6_160 = guiGridListGetItemText(rules_list, r7_160, 1)
        end
      elseif guiGetVisible(rules_time) then
        local r7_160 = guiGetText(rules_time)
        local r8_160 = tonumber(gettok(r7_160, 1, string.byte(":"))) or 0
        local r9_160 = tonumber(gettok(r7_160, 2, string.byte(":"))) or 0
        local r10_160 = gettok(r7_160, 3, string.byte(":")) or "0"
        local r11_160 = tonumber(gettok(r10_160, 2, string.byte("."))) or 0
        r6_160 = string.format("%02i", tonumber(gettok(r10_160, 1, string.byte("."))) or 0)
        if r8_160 > 0 then
          r6_160 = string.format("%i:%02i:", r8_160, r9_160) .. r6_160
        else
          r6_160 = string.format("%i:", r9_160) .. r6_160
        end
        if r11_160 > 0 then
          r6_160 = r6_160 .. string.format(".%i", r11_160)
        end
      end
      if guiCheckBoxGetSelected(config_performance_adminpanel) then
        destroyElement(rules_window)
      else
        guiSetVisible(rules_window, false)
      end
      if r6_160 ~= nil and isElement(admin_window) then
        if r4_160 == -1 or r5_160 == -1 then
          return 
        end
        local r7_160 = guiGridListGetItemText(modes_list, r4_160, 1)
        local r8_160 = guiGridListGetItemText(modes_rules, r5_160, 1)
        if r7_160 == "settings" then
          setTacticsData(r6_160, "settings", r8_160, true)
        elseif r7_160 == "glitches" then
          setTacticsData(r6_160, "glitches", r8_160, true)
        elseif r7_160 == "cheats" then
          setTacticsData(r6_160, "cheats", r8_160, true)
        elseif r7_160 == "limites" then
          setTacticsData(r6_160, "limites", r8_160, true)
        else
          setTacticsData(r6_160, "modes", r7_160, r8_160, true)
        end
      end
      return 
    end
    if source == rules_cancel then
      if guiCheckBoxGetSelected(config_performance_adminpanel) then
        destroyElement(rules_window)
      else
        guiSetVisible(rules_window, false)
      end
      return 
    end
    if source == modes_disable then
      local r4_160 = guiGridListGetSelectedItem(modes_list)
      if r4_160 == -1 then
        return 
      end
      local r5_160 = guiGridListGetItemText(modes_list, r4_160, 1)
      if getTacticsData("modes", r5_160, "enable") == "true" then
        setTacticsData("false", "modes", r5_160, "enable", true)
      elseif getTacticsData("modes", r5_160) then
        setTacticsData("true", "modes", r5_160, "enable", true)
      end
      return 
    end
    if source == sky_topcolor or source == sky_bottomcolor or source == sun_colora or source == sun_colorb or source == water_color then
      if not isElement(palette_window) then
        createAdminPalette()
      end
      palette_element = source
      local r5_160, r6_160, r7_160, r8_160 = getColorFromString("#" .. string.sub(guiGetProperty(source, "ReadOnlyBGColour"), 1, -1))
      guiSetText(palette_rr, tostring(r6_160))
      guiSetText(palette_gg, tostring(r7_160))
      guiSetText(palette_bb, tostring(r8_160))
      guiSetText(palette_aa, tostring(r5_160))
      guiBringToFront(palette_window)
      guiSetVisible(palette_window, true)
      return 
    end
    if source == sky_clouds then
      guiSetVisible(sky_clouds_img, guiCheckBoxGetSelected(sky_clouds))
      return 
    end
    if source == sky_birds then
      guiSetVisible(sky_birds_img, guiCheckBoxGetSelected(sky_birds))
      return 
    end
    if source == weather_load then
      local r4_160 = guiComboBoxGetSelected(weather_default)
      if not weatherSAData[(r4_160 + 1)] then
        return 
      end
      local r5_160 = getTacticsData("Weather") or {}
      local r6_160 = {
        [0] = true,
        [10] = true,
        [8] = true,
        [19] = true,
        [9] = true,
      }
      local r7_160 = {}
      for r11_160, r12_160 in pairs(weatherSAData[r4_160 + 1].hours) do
        local r13_160 = 0
        local r14_160 = 0
        local r15_160 = 0
        if r5_160[r11_160] then
          r13_160, r14_160, r15_160 = unpack(r5_160[r11_160].wind)
        end
        local r16_160, r17_160, r18_160, r19_160, r20_160, r21_160 = unpack(r12_160.sky)
        local r22_160, r23_160, r24_160, r25_160, r26_160, r27_160, r28_160 = unpack(r12_160.sun)
        local r29_160, r30_160, r31_160, r32_160 = unpack(r12_160.water)
        local r33_160 = {}
        local r34_160 = "wind"
        local r35_160 = {}
        local r36_160 = r13_160 or 0
        local r37_160 = r14_160 or 0
        local r38_160 = r15_160 or 0
        -- setlist for #35 failed
        r33_160[r34_160] = r35_160
        r33_160.rain = tonumber(r12_160.rain or 0)
        r33_160.far = tonumber(r12_160.far)
        r33_160.fog = tonumber(r12_160.fog)
        r33_160.sky = {
          r16_160,
          r17_160,
          r18_160,
          r19_160,
          r20_160,
          r21_160
        }
        r33_160.clouds = true
        r33_160.birds = true
        r33_160.sun = {
          r22_160,
          r23_160,
          r24_160,
          r25_160,
          r26_160,
          r27_160
        }
        r33_160.sunsize = tonumber(r28_160)
        r33_160.water = {
          r29_160,
          r30_160,
          r31_160,
          r32_160
        }
        r33_160.level = 0
        r33_160.wave = 0
        r33_160.heat = 0
        r34_160 = "effect"
        r35_160 = r6_160[r4_160]
        if r35_160 then
          r35_160 = r4_160 or 0
        else
          goto label_3060	-- block#536 is visited secondly
        end
        r33_160[r34_160] = r35_160
        r7_160[r11_160] = r33_160
      end
      setTacticsData(r7_160, "Weather")
      return 
    end
    if source == weather_loadhour then
      local r4_160 = guiComboBoxGetSelected(weather_default)
      if not weatherSAData[(r4_160 + 1)] then
        return 
      end
      local r5_160, r6_160 = guiGridListGetSelectedItem(weather_record)
      if r6_160 < 1 then
        return 
      end
      local r7_160 = tonumber(guiGridListGetItemData(weather_record, 1, r6_160))
      if not r7_160 then
        return 
      end
      if not weatherSAData[(r4_160 + 1)].hours[r7_160] then
        return 
      end
      local r8_160 = getTacticsData("Weather") or {}
      local r9_160 = {
        [0] = true,
        [10] = true,
        [8] = true,
        [19] = true,
        [9] = true,
      }
      local r10_160 = {}
      local r11_160 = weatherSAData[r4_160 + 1].hours[r7_160]
      local r12_160, r13_160, r14_160 = unpack(r8_160[r7_160].wind)
      local r15_160, r16_160, r17_160, r18_160, r19_160, r20_160 = unpack(r11_160.sky)
      local r21_160, r22_160, r23_160, r24_160, r25_160, r26_160, r27_160 = unpack(r11_160.sun)
      local r28_160, r29_160, r30_160, r31_160 = unpack(r11_160.water)
      local r32_160 = {}
      local r33_160 = "wind"
      local r34_160 = {}
      local r35_160 = r12_160 or 0
      local r36_160 = r13_160 or 0
      local r37_160 = r14_160 or 0
      -- setlist for #34 failed
      r32_160[r33_160] = r34_160
      r32_160.rain = tonumber(r11_160.rain or 0)
      r32_160.far = tonumber(r11_160.far)
      r32_160.fog = tonumber(r11_160.fog)
      r32_160.sky = {
        r15_160,
        r16_160,
        r17_160,
        r18_160,
        r19_160,
        r20_160
      }
      r32_160.clouds = true
      r32_160.birds = true
      r32_160.sun = {
        r21_160,
        r22_160,
        r23_160,
        r24_160,
        r25_160,
        r26_160
      }
      r32_160.sunsize = tonumber(r27_160)
      r32_160.water = {
        r28_160,
        r29_160,
        r30_160,
        r31_160
      }
      r32_160.level = 0
      r32_160.wave = 0
      r32_160.heat = 0
      r33_160 = "effect"
      r34_160 = r9_160[r4_160]
      if r34_160 then
        r34_160 = r4_160 or 0
      else
        goto label_3247	-- block#561 is visited secondly
      end
      r32_160[r33_160] = r34_160
      r8_160[r7_160] = r32_160
      setTacticsData(r8_160, "Weather")
      return 
    end
    if source == weather_insert then
      local r4_160 = tonumber(guiGetText(weather_hour))
      if not r4_160 then
        return 
      end
      local r5_160 = getTacticsData("Weather") or {}
      if r5_160[r4_160] then
        return 
      end
      local r6_160 = {
        [0] = true,
        [10] = true,
        [8] = true,
        [19] = true,
        [9] = true,
      }
      local r7_160 = {
        wind = {
          getWindVelocity()
        },
        rain = getRainLevel(),
        far = getFarClipDistance(),
        fog = getFogDistance(),
        sky = {
          getSkyGradient()
        },
        clouds = getCloudsEnabled(),
        birds = getBirdsEnabled(),
        sun = {
          getSunColor()
        },
        sunsize = getSunSize(),
        water = {
          getWaterColor()
        },
        wave = getWaveHeight(),
        level = getWaterLevel(3000, 3000, 0),
        heat = ({
          getHeatHaze()
        })[1] or 0,
      }
      local r8_160 = "effect"
      local r9_160 = r6_160[getWeather()]
      if r9_160 then
        r9_160 = getWeather() or 0
      else
        goto label_3374	-- block#574 is visited secondly
      end
      r7_160[r8_160] = r9_160
      r5_160[r4_160] = r7_160
      setTacticsData(r5_160, "Weather")
      return 
    end
    if source == weather_delete then
      local r4_160, r5_160 = guiGridListGetSelectedItem(weather_record)
      if r5_160 < 1 then
        return 
      end
      local r6_160 = tonumber(guiGridListGetItemData(weather_record, 1, r5_160))
      if not r6_160 then
        return 
      end
      local r7_160 = getTacticsData("Weather") or {}
      r7_160[r6_160] = nil
      setTacticsData(r7_160, "Weather")
      return 
    end
    if source == weather_save then
      local r4_160, r5_160 = guiGridListGetSelectedItem(weather_record)
      if r5_160 < 1 then
        return 
      end
      local r6_160 = tonumber(guiGridListGetItemData(weather_record, 1, r5_160))
      if not r6_160 then
        return 
      end
      local r7_160 = getTacticsData("Weather") or {}
      local r8_160 = math.rad(tonumber(guiGetText(wind_vector))) or 0
      local r9_160 = tonumber(guiGetText(wind_speed)) * 3.6 / 200 or 0
      local r10_160 = -r9_160 * math.sin(r8_160)
      local r11_160 = r9_160 * math.cos(r8_160)
      local r12_160 = 0
      local r13_160, r14_160, r15_160 = getColorFromString("#" .. string.sub(guiGetProperty(sky_topcolor, "ReadOnlyBGColour"), 3, -1))
      local r16_160, r17_160, r18_160 = getColorFromString("#" .. string.sub(guiGetProperty(sky_bottomcolor, "ReadOnlyBGColour"), 3, -1))
      local r19_160, r20_160, r21_160 = getColorFromString("#" .. string.sub(guiGetProperty(sun_colora, "ReadOnlyBGColour"), 3, -1))
      local r22_160, r23_160, r24_160 = getColorFromString("#" .. string.sub(guiGetProperty(sun_colorb, "ReadOnlyBGColour"), 3, -1))
      local r25_160, r26_160, r27_160, r28_160 = getColorFromString("#" .. string.sub(guiGetProperty(water_color, "ReadOnlyBGColour"), 1, -1))
      local r30_160 = {
        wind = {
          r10_160,
          r11_160,
          r12_160
        },
        rain = tonumber(guiGetText(rain_level)),
        far = tonumber(guiGetText(farclip_distance)),
        fog = tonumber(guiGetText(fog_distance)),
        sky = {
          r13_160,
          r14_160,
          r15_160,
          r16_160,
          r17_160,
          r18_160
        },
        clouds = guiCheckBoxGetSelected(sky_clouds),
        birds = guiCheckBoxGetSelected(sky_birds),
        sun = {
          r19_160,
          r20_160,
          r21_160,
          r22_160,
          r23_160,
          r24_160
        },
        sunsize = tonumber(guiGetText(sun_size)),
        water = {
          r26_160,
          r27_160,
          r28_160,
          r25_160
        },
        level = tonumber(guiGetText(water_level)),
        wave = tonumber(guiGetText(wave_height)),
        heat = tonumber(guiGetText(heat_level)),
        effect = ({
          Clear = 0,
          Cloudy = 10,
          Thunder = 8,
          Storm = 19,
          Fog = 9,
        })[guiGetText(weather_effect)] or tonumber(guiGetText(weather_effect)),
      }
      r7_160[r6_160] = r30_160
      setTacticsData(r7_160, "Weather")
      return 
    end
    if source == shooting_ok then
      local r4_160 = getWeaponIDFromName(guiGetText(shooting_weapon))
      local r5_160 = guiGetText(shooting_weapon_range)
      local r6_160 = guiGetText(shooting_target_range)
      local r7_160 = guiGetText(shooting_accuracy)
      local r8_160 = guiGetText(shooting_damage)
      local r9_160 = guiGetText(shooting_maximum_clip)
      local r10_160 = guiGetText(shooting_move_speed)
      local r11_160 = guiGetText(shooting_anim_loop_start)
      local r12_160 = guiGetText(shooting_anim_loop_stop)
      local r13_160 = guiGetText(shooting_anim_loop_bullet_fire)
      local r14_160 = guiGetText(shooting_anim2_loop_start)
      local r15_160 = guiGetText(shooting_anim2_loop_stop)
      local r16_160 = guiGetText(shooting_anim2_loop_bullet_fire)
      local r17_160 = guiGetText(shooting_anim_breakout_time)
      local r18_160 = {
        {},
        {},
        {},
        {},
        {}
      }
      for r22_160 = 1, 4, 1 do
        r18_160[r22_160][1] = guiCheckBoxGetSelected(shooting_flags[r22_160][1])
        r18_160[r22_160][2] = guiCheckBoxGetSelected(shooting_flags[r22_160][2])
        r18_160[r22_160][4] = guiCheckBoxGetSelected(shooting_flags[r22_160][4])
        r18_160[r22_160][8] = guiCheckBoxGetSelected(shooting_flags[r22_160][8])
      end
      callServerFunction("changeWeaponProperty", localPlayer, r4_160, r5_160, r6_160, r7_160, r8_160, r9_160, r10_160, r11_160, r12_160, r13_160, r14_160, r15_160, r16_160, r17_160, r18_160)
      return 
    end
    if source == shooting_reset then
      callServerFunction("resetWeaponProperty", localPlayer, getWeaponIDFromName(guiGetText(shooting_weapon)))
      return 
    end
    if source == handling_ok then
      local r4_160 = {}
      local r5_160 = getVehicleModelFromName(guiGetText(handling_model))
      r4_160.mass = tonumber(guiGetText(handling_mass))
      r4_160.turnMass = tonumber(guiGetText(handling_turnmass))
      r4_160.dragCoeff = tonumber(guiGetText(handling_dragcoeff))
      r4_160.centerOfMass = {
        tonumber(guiGetText(handling_centerofmass_x)),
        tonumber(guiGetText(handling_centerofmass_y)),
        tonumber(guiGetText(handling_centerofmass_z))
      }
      r4_160.percentSubmerged = tonumber(guiGetText(handling_percentsubmerged))
      r4_160.tractionMultiplier = tonumber(guiGetText(handling_tractionmultiplier))
      r4_160.tractionLoss = tonumber(guiGetText(handling_tractionloss))
      r4_160.tractionBias = tonumber(guiGetText(handling_tractionbias))
      r4_160.numberOfGears = tonumber(guiGetText(handling_numberofgears))
      r4_160.maxVelocity = tonumber(guiGetText(handling_maxvelocity))
      r4_160.engineAcceleration = tonumber(guiGetText(handling_engineacceleration))
      r4_160.engineInertia = tonumber(guiGetText(handling_engineinertia))
      r4_160.driveType = ({
        ["4x4"] = "awd",
        Front = "fwd",
        Rear = "rwd",
      })[guiGetText(handling_drivetype)]
      r4_160.engineType = ({
        Petrol = "petrol",
        Diesel = "diesel",
        Electric = "electric",
      })[guiGetText(handling_enginetype)]
      r4_160.brakeDeceleration = tonumber(guiGetText(handling_brakedeceleration))
      r4_160.brakeBias = tonumber(guiGetText(handling_brakebias))
      local r6_160 = "ABS"
      local r7_160 = guiGetText(handling_abs)
      if r7_160 == "Enable" then
        r7_160 = true
      else
        r7_160 = false
      end
      r4_160[r6_160] = r7_160
      r4_160.steeringLock = tonumber(guiGetText(handling_steeringlock))
      r4_160.suspensionForceLevel = tonumber(guiGetText(handling_suspensionforcelevel))
      r4_160.suspensionDamping = tonumber(guiGetText(handling_suspensiondamping))
      r4_160.suspensionHighSpeedDamping = tonumber(guiGetText(handling_suspensionhighspeeddamping))
      r4_160.suspensionUpperLimit = tonumber(guiGetText(handling_suspensionupperlimit))
      r4_160.suspensionLowerLimit = tonumber(guiGetText(handling_suspensionlowerlimit))
      r4_160.suspensionFrontRearBias = tonumber(guiGetText(handling_suspensionfrontrearbias))
      r4_160.suspensionAntiDiveMultiplier = tonumber(guiGetText(handling_suspensionantidivemultiplier))
      r4_160.seatOffsetDistance = tonumber(guiGetText(handling_seatoffsetdistance))
      r4_160.collisionDamageMultiplier = tonumber(guiGetText(handling_collisiondamagemultiplier))
      r6_160 = ""
      for r10_160 = 1, 8, 1 do
        local r11_160 = 0
        if guiCheckBoxGetSelected(handling_modelflags[r10_160][8]) then
          r11_160 = r11_160 + 8
        end
        if guiCheckBoxGetSelected(handling_modelflags[r10_160][4]) then
          r11_160 = r11_160 + 4
        end
        if guiCheckBoxGetSelected(handling_modelflags[r10_160][2]) then
          r11_160 = r11_160 + 2
        end
        if guiCheckBoxGetSelected(handling_modelflags[r10_160][1]) then
          r11_160 = r11_160 + 1
        end
        r6_160 = string.format("%01X", r11_160) .. r6_160
      end
      r4_160.modelFlags = "0x" .. r6_160
      r7_160 = ""
      for r11_160 = 1, 8, 1 do
        local r12_160 = 0
        if guiCheckBoxGetSelected(handling_handlingflags[r11_160][8]) then
          r12_160 = r12_160 + 8
        end
        if guiCheckBoxGetSelected(handling_handlingflags[r11_160][4]) then
          r12_160 = r12_160 + 4
        end
        if guiCheckBoxGetSelected(handling_handlingflags[r11_160][2]) then
          r12_160 = r12_160 + 2
        end
        if guiCheckBoxGetSelected(handling_handlingflags[r11_160][1]) then
          r12_160 = r12_160 + 1
        end
        r7_160 = string.format("%01X", r12_160) .. r7_160
      end
      r4_160.handlingFlags = "0x" .. r7_160
      r4_160.sirens = {}
      r4_160.sirens.count = tonumber(guiGetText(sirens_count)) or 0
      r4_160.sirens.type = ({
        Invisible = 1,
        Single = 2,
        Dual = 3,
        Triple = 4,
        Quadruple = 5,
        Quinary = 6,
      })[guiGetText(sirens_type)]
      r4_160.sirens.flags = {
        ["360"] = guiCheckBoxGetSelected(sirens_360),
        DoLOSCheck = guiCheckBoxGetSelected(sirens_LOS),
        UseRandomiser = guiCheckBoxGetSelected(sirens_randomiser),
        Silent = guiCheckBoxGetSelected(sirens_silent),
      }
      for r11_160 = 1, 8, 1 do
        r4_160.sirens[r11_160] = {
          x = guiGetText(sirens_xcenter[r11_160]),
          y = guiGetText(sirens_ycenter[r11_160]),
          z = guiGetText(sirens_zcenter[r11_160]),
          color = guiGetProperty(sirens_color[r11_160], "ReadOnlyBGColour"),
          minalpha = guiGetText(sirens_minalpha[r11_160]),
        }
      end
      callServerFunction("changeVehicleHandling", localPlayer, r5_160, r4_160)
      return 
    end
    if source == handling_reset then
      callServerFunction("resetVehicleHandling", localPlayer, getVehicleModelFromName(guiGetText(handling_model)))
      return 
    end
    if source == window_expert then
      if guiCheckBoxGetSelected(window_expert) then
        guiSetVisible(admin_tab_anticheat, true)
        guiSetVisible(admin_tab_shooting, true)
        guiSetVisible(admin_tab_handling, true)
        guiSetEnabled(maps_refresh, true)
        if isElement(save_window) then
          guiSetVisible(save_shooting, true)
          guiSetVisible(save_handling, true)
          guiSetVisible(save_anticheat, true)
        end
      else
        guiSetVisible(admin_tab_anticheat, false)
        guiSetVisible(admin_tab_shooting, false)
        guiSetVisible(admin_tab_handling, false)
        guiSetEnabled(maps_refresh, false)
        if isElement(save_window) then
          guiSetVisible(save_shooting, false)
          guiSetVisible(save_handling, false)
          guiSetVisible(save_anticheat, false)
        end
        local r4_160 = guiGetSelectedTab(admin_tabs)
        if r4_160 == admin_tab_shooting or r4_160 == admin_tab_handling or r4_160 == admin_tab_anticheat then
          guiSetSelectedTab(admin_tabs, admin_tab_players)
        end
      end
      return 
    end
    if source == anticheat_modsadd then
      if not isElement(mods_window) then
        createAdminMods()
      end
      guiSetText(mods_name, "")
      guiSetText(mods_edit, "")
      guiSetText(mods_ok, "Add")
      guiRadioButtonSetSelected(mods_type_name, true)
      guiBringToFront(mods_window)
      guiSetVisible(mods_window, true)
      return 
    end
    if source == mods_ok then
      if guiGetText(mods_ok) == "Add" then
        local r4_160 = guiGetText(mods_name)
        local r5_160 = guiGetText(mods_edit)
        if #r4_160 == 0 or #r5_160 == 0 then
          return 
        end
        local r6_160 = guiRadioButtonGetSelected(mods_type_name)
        if r6_160 then
          r6_160 = "name" or "hash"
        else
          goto label_4449	-- block#663 is visited secondly
        end
        callServerFunction("addAnticheatModsearch", r4_160, r5_160, r6_160)
        if guiCheckBoxGetSelected(config_performance_adminpanel) then
          destroyElement(mods_window)
        else
          guiSetVisible(mods_window, false)
        end
      elseif guiGetText(mods_ok) == "Set" then
        local r4_160 = guiGridListGetSelectedItem(anticheat_modslist)
        if r4_160 == -1 then
          return 
        end
        local r5_160 = guiGetText(mods_name)
        local r6_160 = guiGetText(mods_edit)
        if #r5_160 == 0 or #r6_160 == 0 then
          return 
        end
        local r7_160 = guiRadioButtonGetSelected(mods_type_name)
        if r7_160 then
          r7_160 = "name" or "hash"
        else
          goto label_4506	-- block#675 is visited secondly
        end
        callServerFunction("setAnticheatModsearch", r4_160, r5_160, r6_160, r7_160)
        if guiCheckBoxGetSelected(config_performance_adminpanel) then
          destroyElement(mods_window)
        else
          guiSetVisible(mods_window, false)
        end
      end
      return 
    end
    if source == mods_cancel then
      if guiCheckBoxGetSelected(config_performance_adminpanel) then
        destroyElement(mods_window)
      else
        guiSetVisible(mods_window, false)
      end
      return 
    end
    if source == anticheat_modsdel then
      local r4_160 = guiGridListGetSelectedItem(anticheat_modslist)
      if r4_160 == -1 then
        return 
      end
      callServerFunction("removeAnticheatModsearch", r4_160)
      return 
    end
    if source == player_infocopy then
      setClipboard(guiGetText(player_info))
      return 
    end
    if source == player_takescreen then
      if not r3_130 or 1 < #r3_130 then
        return 
      end
      callServerFunction("takePlayerScreenShot", r3_130[1], 320, 240, getPlayerName(localPlayer) .. " 320 240 " .. getPlayerName(r3_130[1]), 30, 5000)
      guiSetEnabled(player_takescreen, false)
      guiSetEnabled(player_takescreencombobox, false)
      screenTimeout = setTimer(function()
        -- line: [2912, 2915] id: 162
        guiSetEnabled(player_takescreen, true)
        guiSetEnabled(player_takescreencombobox, true)
      end, 30000, 1)
      return 
    end
    if source == screen_save then
      local r4_160 = guiGetText(screen_name)
      local r5_160 = fileExists("screenshots/" .. r4_160 .. ".jpg")
      if r5_160 then
        fileDelete("screenshots/" .. r4_160 .. ".jpg")
      end
      local r6_160 = fileOpen("screenshots/_screen.jpg")
      local r7_160 = fileCreate("screenshots/" .. r4_160 .. ".jpg")
      while not fileIsEOF(r6_160) do
        fileWrite(r7_160, fileRead(r6_160, 500))
      end
      fileClose(r6_160)
      fileClose(r7_160)
      if not r5_160 then
        local r8_160 = xmlLoadFile("screenshots/_list.xml") or xmlCreateFile("screenshots/_list.xml", "screenshots")
        xmlNodeSetAttribute(xmlCreateChild(r8_160, "screenshot"), "src", r4_160)
        xmlSaveFile(r8_160)
        xmlUnloadFile(r8_160)
        guiComboBoxAddItem(screen_list, r4_160)
      end
      guiSetVisible(screen_name, false)
      guiSetVisible(screen_save, false)
      guiSetText(screen_list, r4_160)
      guiSetVisible(screen_list, true)
      return 
    end
    if source == screen_close then
      if guiCheckBoxGetSelected(config_performance_adminpanel) then
        destroyElement(screen_window)
      else
        guiSetVisible(screen_window, false)
      end
      if isAllGuiHidden() then
        showCursor(false)
      end
      return 
    end
    if source == shooting_general then
      guiSetProperty(shooting_general, "NormalTextColour", "FFFFFFFF")
      guiSetProperty(shooting_animation, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(shooting_flag, "NormalTextColour", "FF7C7C7C")
      guiSetVisible(shooting_generalpane, true)
      guiSetVisible(shooting_animationpane, false)
      guiSetVisible(shooting_flagpane, false)
      return 
    end
    if source == shooting_animation then
      guiSetProperty(shooting_general, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(shooting_animation, "NormalTextColour", "FFFFFFFF")
      guiSetProperty(shooting_flag, "NormalTextColour", "FF7C7C7C")
      guiSetVisible(shooting_generalpane, false)
      guiSetVisible(shooting_animationpane, true)
      guiSetVisible(shooting_flagpane, false)
      return 
    end
    if source == shooting_flag then
      guiSetProperty(shooting_general, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(shooting_animation, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(shooting_flag, "NormalTextColour", "FFFFFFFF")
      guiSetVisible(shooting_generalpane, false)
      guiSetVisible(shooting_animationpane, false)
      guiSetVisible(shooting_flagpane, true)
      return 
    end
    if source == handling_general then
      guiSetProperty(handling_general, "NormalTextColour", "FFFFFFFF")
      guiSetProperty(handling_engine, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_wheels, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_suspension, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_modelflag, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_handlingflag, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_sirens, "NormalTextColour", "FF7C7C7C")
      guiSetVisible(handling_generalpane, true)
      guiSetVisible(handling_enginepane, false)
      guiSetVisible(handling_wheelspane, false)
      guiSetVisible(handling_suspensionpane, false)
      guiSetVisible(handling_modelflagpane, false)
      guiSetVisible(handling_handlingflagpane, false)
      guiSetVisible(handling_sirenspane, false)
      return 
    end
    if source == handling_engine then
      guiSetProperty(handling_general, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_engine, "NormalTextColour", "FFFFFFFF")
      guiSetProperty(handling_wheels, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_suspension, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_modelflag, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_handlingflag, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_sirens, "NormalTextColour", "FF7C7C7C")
      guiSetVisible(handling_generalpane, false)
      guiSetVisible(handling_enginepane, true)
      guiSetVisible(handling_wheelspane, false)
      guiSetVisible(handling_suspensionpane, false)
      guiSetVisible(handling_modelflagpane, false)
      guiSetVisible(handling_handlingflagpane, false)
      guiSetVisible(handling_sirenspane, false)
      return 
    end
    if source == handling_wheels then
      guiSetProperty(handling_general, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_engine, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_wheels, "NormalTextColour", "FFFFFFFF")
      guiSetProperty(handling_suspension, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_modelflag, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_handlingflag, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_sirens, "NormalTextColour", "FF7C7C7C")
      guiSetVisible(handling_generalpane, false)
      guiSetVisible(handling_enginepane, false)
      guiSetVisible(handling_wheelspane, true)
      guiSetVisible(handling_suspensionpane, false)
      guiSetVisible(handling_modelflagpane, false)
      guiSetVisible(handling_handlingflagpane, false)
      guiSetVisible(handling_sirenspane, false)
      return 
    end
    if source == handling_suspension then
      guiSetProperty(handling_general, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_engine, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_wheels, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_suspension, "NormalTextColour", "FFFFFFFF")
      guiSetProperty(handling_modelflag, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_handlingflag, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_sirens, "NormalTextColour", "FF7C7C7C")
      guiSetVisible(handling_generalpane, false)
      guiSetVisible(handling_enginepane, false)
      guiSetVisible(handling_wheelspane, false)
      guiSetVisible(handling_suspensionpane, true)
      guiSetVisible(handling_modelflagpane, false)
      guiSetVisible(handling_handlingflagpane, false)
      guiSetVisible(handling_sirenspane, false)
      return 
    end
    if source == handling_modelflag then
      guiSetProperty(handling_general, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_engine, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_wheels, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_suspension, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_modelflag, "NormalTextColour", "FFFFFFFF")
      guiSetProperty(handling_handlingflag, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_sirens, "NormalTextColour", "FF7C7C7C")
      guiSetVisible(handling_generalpane, false)
      guiSetVisible(handling_enginepane, false)
      guiSetVisible(handling_wheelspane, false)
      guiSetVisible(handling_suspensionpane, false)
      guiSetVisible(handling_modelflagpane, true)
      guiSetVisible(handling_handlingflagpane, false)
      guiSetVisible(handling_sirenspane, false)
      return 
    end
    if source == handling_handlingflag then
      guiSetProperty(handling_general, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_engine, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_wheels, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_suspension, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_modelflag, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_handlingflag, "NormalTextColour", "FFFFFFFF")
      guiSetProperty(handling_sirens, "NormalTextColour", "FF7C7C7C")
      guiSetVisible(handling_generalpane, false)
      guiSetVisible(handling_enginepane, false)
      guiSetVisible(handling_wheelspane, false)
      guiSetVisible(handling_suspensionpane, false)
      guiSetVisible(handling_modelflagpane, false)
      guiSetVisible(handling_handlingflagpane, true)
      guiSetVisible(handling_sirenspane, false)
      return 
    end
    if source == handling_sirens then
      guiSetProperty(handling_general, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_engine, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_wheels, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_suspension, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_modelflag, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_handlingflag, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(handling_sirens, "NormalTextColour", "FFFFFFFF")
      guiSetVisible(handling_generalpane, false)
      guiSetVisible(handling_enginepane, false)
      guiSetVisible(handling_wheelspane, false)
      guiSetVisible(handling_suspensionpane, false)
      guiSetVisible(handling_modelflagpane, false)
      guiSetVisible(handling_handlingflagpane, false)
      guiSetVisible(handling_sirenspane, true)
      return 
    end
    if isElement(admin_window) and guiGetVisible(admin_tab_handling) and guiGetVisible(handling_sirenspane) then
      for r7_160, r8_160 in ipairs(sirens_color) do
        if source == r8_160 then
          if not isElement(palette_window) then
            createAdminPalette()
          end
          palette_element = source
          local r10_160, r11_160, r12_160 = getColorFromString("#" .. string.sub(guiGetProperty(source, "ReadOnlyBGColour"), 3, -1))
          guiSetText(palette_rr, tostring(r10_160))
          guiSetText(palette_gg, tostring(r11_160))
          guiSetText(palette_bb, tostring(r12_160))
          guiBringToFront(palette_window)
          guiSetVisible(palette_window, true)
          return 
        end
      end
    end
    if isElement(admin_window) and guiGetVisible(admin_tab_weapons) then
      if source == weapons_adding then
        local r4_160 = getTacticsData("weaponspack") or {}
        local r5_160 = getTacticsData("weapon_balance") or {}
        local r6_160 = getTacticsData("weapon_cost") or {}
        local r7_160 = getTacticsData("weapon_slot") or {}
        for r11_160, r12_160 in ipairs(sortWeaponNames) do
          if not r4_160[r12_160] then
            guiSetText(weapons_addname, r12_160)
            local r13_160 = convertWeaponNamesToID[r12_160]
            local r14_160 = 22
            if r14_160 <= r13_160 then
              r14_160 = 39
              if r13_160 <= r14_160 then
                r14_160 = tonumber(getWeaponProperty(r13_160, "pro", "maximum_clip_ammo")) or 1
              end
            else
              goto label_5453	-- block#759 is visited secondly
            end
            guiSetText(weapons_addammo, tostring(r14_160))
            guiSetText(weapons_addlimit, r5_160[r12_160] or "")
            guiSetText(weapons_addcost, r6_160[r12_160] or "$")
            local r15_160 = guiSetText
            local r16_160 = weapons_addslot
            local r17_160 = r7_160[r12_160]
            if not r17_160 then
              if r13_160 then
                r17_160 = tostring(getSlotFromWeapon(r13_160)) or "13"
              else
                goto label_5488	-- block#767 is visited secondly
              end
            end
            r15_160(r16_160, r17_160)
            break
          end
        end
        return 
      end
      if source == weapons_save then
        local r4_160 = guiGetText(weapons_addname)
        local r5_160 = convertWeaponNamesToID[r4_160]
        local r6_160 = guiGetText(weapons_addammo)
        if #r4_160 == 0 or #r6_160 == 0 or not tonumber(r6_160) then
          return 
        end
        local r7_160 = guiGetText(weapons_addlimit)
        local r8_160 = guiGetText(weapons_addcost)
        local r10_160 = "gsub"
        r10_160 = "%$"
        r8_160 = r8_160:[r10_160](r10_160, "")
        local r9_160 = guiGetText(weapons_addslot)
        setTacticsData(tostring(r6_160), "weaponspack", tostring(r4_160))
        if 0 < #r7_160 and tonumber(r7_160) then
          setTacticsData(tostring(r7_160), "weapon_balance", tostring(r4_160))
        else
          setTacticsData(nil, "weapon_balance", tostring(r4_160))
        end
        if 0 < #r8_160 and tonumber(r8_160) then
          setTacticsData(tostring(r8_160), "weapon_cost", tostring(r4_160))
        else
          setTacticsData(nil, "weapon_cost", tostring(r4_160))
        end
        if 0 < #r9_160 and tonumber(r9_160) and (r5_160 and tonumber(r9_160) ~= getSlotFromWeapon(r5_160) or tonumber(r9_160) ~= 13) then
          setTacticsData(tostring(r9_160), "weapon_slot", tostring(r4_160))
        else
          setTacticsData(nil, "weapon_slot", tostring(r4_160))
        end
        return 
      end
      if source == weapons_remove then
        local r4_160 = guiGetText(weapons_addname)
        if #r4_160 == 0 then
          return 
        end
        setTacticsData(nil, "weaponspack", tostring(r4_160))
        return 
      end
      if source == weapons_apply then
        local r4_160 = guiGetText(weapons_slots)
        if #r4_160 == 0 or not tonumber(r4_160) then
          return 
        end
        setTacticsData(tonumber(r4_160), "weapon_slots")
        return 
      end
      for r7_160, r8_160 in ipairs(weapons_items) do
        if source == r8_160.gui then
          local r9_160 = guiGetText(r8_160.name)
          local r10_160 = 0
          for r14_160, r15_160 in ipairs(split(guiGetText(r8_160.ammo), string.byte("-"))) do
            r10_160 = r10_160 + tonumber(r15_160)
          end
          r10_160 = tostring(math.max(r10_160, 1))
          local r11_160 = guiGetText(r8_160.limit)
          if #r11_160 > 1 then
            r11_160 = string.sub(r11_160, 2)
          end
          guiSetText(weapons_addname, r9_160)
          guiSetText(weapons_addammo, r10_160)
          guiSetText(weapons_addlimit, r11_160)
          local r12_160 = convertWeaponNamesToID[r9_160]
          local r13_160 = getTacticsData("weapon_cost") or {}
          local r14_160 = getTacticsData("weapon_slot") or {}
          guiSetText(weapons_addcost, r13_160[r9_160] or "")
          local r15_160 = guiSetText
          local r16_160 = weapons_addslot
          local r17_160 = r14_160[r9_160]
          if not r17_160 then
            if r12_160 then
              r17_160 = tostring(getSlotFromWeapon(r12_160)) or "13"
            else
              goto label_5784	-- block#817 is visited secondly
            end
          end
          r15_160(r16_160, r17_160)
          return 
        end
      end
    end
  end
  function onClientGUIChanged(r0_163)
    -- line: [3196, 3453] id: 163
    -- notice: unreachable block#233
    -- notice: unreachable block#225
    -- notice: unreachable block#221
    -- notice: unreachable block#237
    -- notice: unreachable block#229
    local r3_163 = nil	-- notice: implicit variable refs by block#[247]
    if source == rules_time then
      local r1_163 = guiGetText(rules_time):gsub("[^0-9:.]+", "")
      local r2_163 = gettok(r1_163, 1, string.byte("."))
      r3_163 = tonumber(gettok(r2_163, 1, string.byte(":"))) or 0
      local r4_163 = tonumber(gettok(r2_163, 2, string.byte(":"))) or 0
      local r5_163 = tonumber(gettok(r2_163, 3, string.byte(":"))) or 0
      local r6_163 = tonumber(gettok(r1_163, 2, string.byte("."))) or 0
      if 0 <= r3_163 and r3_163 < 24 and 0 <= r4_163 and r4_163 < 60 and 0 <= r5_163 and r5_163 < 60 and 0 <= r6_163 and r6_163 < 10 then
        return 
      end
      r3_163 = r3_163 % 24
      local r7_163 = tonumber(guiGetProperty(rules_time, "CaratIndex"))
      guiSetText(rules_time, string.format("%02i:%02i:%02i.%i", r3_163, r4_163 % 60, r5_163 % 60, r6_163 % 10))
      guiEditSetCaretIndex(rules_time, r7_163)
      return 
    end
    if source == maps_search then
      updateAdminMaps()
      return 
    end
    if source == palette_rr or source == palette_gg or source == palette_bb then
      local r1_163 = tonumber(guiGetText(palette_rr))
      local r2_163 = tonumber(guiGetText(palette_gg))
      r3_163 = tonumber(guiGetText(palette_bb))
      local r4_163 = tonumber(guiGetText(palette_aa))
      if type(r1_163) ~= "number" then
        r1_163 = 0
      end
      if type(r2_163) ~= "number" then
        r2_163 = 0
      end
      if type(r3_163) ~= "number" then
        r3_163 = 0
      end
      if type(r4_163) ~= "number" then
        r4_163 = 0
      end
      guiSetText(palette_hex, string.format("%02X%02X%02X%02X", r4_163, r1_163, r2_163, r3_163))
      return 
    end
    if source == palette_hex and not palette_mode then
      local r1_163 = guiGetText(palette_hex)
      local r2_163, r3_163, r4_163, r5_163 = getColorFromString("#" .. r1_163)
      if type(r3_163) ~= "number" then
        r3_163 = 0
      end
      if type(r4_163) ~= "number" then
        r4_163 = 0
      end
      if type(r5_163) ~= "number" then
        r5_163 = 0
      end
      palette_H, palette_S, palette_L = RGBtoHSL(r3_163, r4_163, r5_163)
      guiSetPosition(palette_aim, 0.03 + 0.75 * palette_H / 360, 0.07 + 0.65 * (1 - palette_S), true)
      guiSetPosition(palette_aim2, 0.93, 0.07 + 0.65 * (1 - palette_L), true)
      local r6_163 = string.format("%02X%02X%02X%02X", r2_163, HSLtoRGB(palette_H, palette_S, 0.5))
      guiSetProperty(palette_color1, "ImageColours", string.format("tl:%s tr:%s bl:%s br:%s", r6_163, r6_163, r6_163, r6_163))
      guiSetProperty(palette_color2, "ImageColours", string.format("tl:%s tr:%s bl:%s br:%s", r1_163, r1_163, r1_163, r1_163))
      return 
    end
    if source == wind_vector then
      local r1_163 = tonumber(guiGetText(wind_vector)) or 0
      local r2_163, r3_163 = guiGetPosition(wind_radar, false)
      guiSetPosition(wind_aim, r2_163 + 32 - 32 * math.sin(math.rad(r1_163)) - 6, r3_163 + 32 - 32 * math.cos(math.rad(r1_163)) - 6, false)
      return 
    end
    if source == fog_distance or source == farclip_distance then
      local r1_163 = tonumber(guiGetText(farclip_distance)) or 0
      local r2_163 = tonumber(guiGetText(fog_distance)) or 0
      r3_163 = r1_163 - 0.1
      if r3_163 < r2_163 then
        guiSetText(fog_distance, string.format("%.1f", r1_163 - 0.1))
      end
      return 
    end
    if source == handling_mass then
      if tonumber(guiGetText(handling_mass)) < 1 then
        guiSetText(handling_mass, "1.0")
      end
      if tonumber(guiGetText(handling_mass)) > 100000 then
        guiSetText(handling_mass, "100000.0")
      end
      return 
    end
    if source == handling_turnmass then
      if tonumber(guiGetText(handling_turnmass)) < 0 then
        guiSetText(handling_turnmass, "0.0")
      end
      if tonumber(guiGetText(handling_turnmass)) > 1000000 then
        guiSetText(handling_turnmass, "1000000.0")
      end
      return 
    end
    if source == handling_dragcoeff then
      if tonumber(guiGetText(handling_dragcoeff)) < -200 then
        guiSetText(handling_dragcoeff, "-200.0")
      end
      if tonumber(guiGetText(handling_dragcoeff)) > 200 then
        guiSetText(handling_dragcoeff, "200.0")
      end
      return 
    end
    if source == handling_centerofmass_x then
      if tonumber(guiGetText(handling_centerofmass_x)) < -10 then
        guiSetText(handling_centerofmass_x, "-10.0")
      end
      if tonumber(guiGetText(handling_centerofmass_x)) > 10 then
        guiSetText(handling_centerofmass_x, "10.0")
      end
      return 
    end
    if source == handling_centerofmass_y then
      if tonumber(guiGetText(handling_centerofmass_y)) < -10 then
        guiSetText(handling_centerofmass_y, "-10.0")
      end
      if tonumber(guiGetText(handling_centerofmass_y)) > 10 then
        guiSetText(handling_centerofmass_y, "10.0")
      end
      return 
    end
    if source == handling_centerofmass_z then
      if tonumber(guiGetText(handling_centerofmass_z)) < -10 then
        guiSetText(handling_centerofmass_z, "-10.0")
      end
      if tonumber(guiGetText(handling_centerofmass_z)) > 10 then
        guiSetText(handling_centerofmass_z, "10.0")
      end
      return 
    end
    if source == handling_percentsubmerged then
      if tonumber(guiGetText(handling_percentsubmerged)) < 1 then
        guiSetText(handling_percentsubmerged, "1")
      end
      if tonumber(guiGetText(handling_percentsubmerged)) > 99999 then
        guiSetText(handling_percentsubmerged, "99999")
      end
      return 
    end
    if source == handling_tractionmultiplier then
      if tonumber(guiGetText(handling_tractionmultiplier)) < -100000 then
        guiSetText(handling_tractionmultiplier, "-100000.0")
      end
      if tonumber(guiGetText(handling_tractionmultiplier)) > 100000 then
        guiSetText(handling_tractionmultiplier, "100000.0")
      end
      return 
    end
    if source == handling_tractionloss then
      if tonumber(guiGetText(handling_tractionloss)) < 0 then
        guiSetText(handling_tractionloss, "0.0")
      end
      if tonumber(guiGetText(handling_tractionloss)) > 100 then
        guiSetText(handling_tractionloss, "100.0")
      end
      return 
    end
    if source == handling_tractionbias then
      if tonumber(guiGetText(handling_tractionbias)) < 0 then
        guiSetText(handling_tractionbias, "0.0")
      end
      if tonumber(guiGetText(handling_tractionbias)) > 1 then
        guiSetText(handling_tractionbias, "1.0")
      end
      return 
    end
    if source == handling_numberofgears then
      if tonumber(guiGetText(handling_numberofgears)) < 1 then
        guiSetText(handling_numberofgears, "1")
      end
      if tonumber(guiGetText(handling_numberofgears)) > 5 then
        guiSetText(handling_numberofgears, "5")
      end
      return 
    end
    if source == handling_maxvelocity then
      if tonumber(guiGetText(handling_maxvelocity)) < 0.1 then
        guiSetText(handling_maxvelocity, "0.1")
      end
      if tonumber(guiGetText(handling_maxvelocity)) > 200000 then
        guiSetText(handling_maxvelocity, "200000.0")
      end
      return 
    end
    if source == handling_engineacceleration then
      if tonumber(guiGetText(handling_engineacceleration)) < 0 then
        guiSetText(handling_engineacceleration, "0.0")
      end
      if tonumber(guiGetText(handling_engineacceleration)) > 100000 then
        guiSetText(handling_engineacceleration, "100000.0")
      end
      return 
    end
    if source == handling_engineinertia then
      if tonumber(guiGetText(handling_engineinertia)) < -1000 then
        guiSetText(handling_engineinertia, "-1000.0")
      end
      if tonumber(guiGetText(handling_engineinertia)) > 1000 then
        guiSetText(handling_engineinertia, "1000.0")
      end
      return 
    end
    if source == handling_brakedeceleration then
      if tonumber(guiGetText(handling_brakedeceleration)) < 0.1 then
        guiSetText(handling_brakedeceleration, "0.1")
      end
      if tonumber(guiGetText(handling_brakedeceleration)) > 100000 then
        guiSetText(handling_brakedeceleration, "100000.0")
      end
      return 
    end
    if source == handling_brakebias then
      if tonumber(guiGetText(handling_brakebias)) < 0 then
        guiSetText(handling_brakebias, "0.0")
      end
      if tonumber(guiGetText(handling_brakebias)) > 1 then
        guiSetText(handling_brakebias, "1.0")
      end
      return 
    end
    if source == handling_steeringlock then
      if tonumber(guiGetText(handling_steeringlock)) < 0 then
        guiSetText(handling_steeringlock, "0.0")
      end
      if tonumber(guiGetText(handling_steeringlock)) > 360 then
        guiSetText(handling_steeringlock, "360.0")
      end
      return 
    end
    if source == handling_suspensionforcelevel then
      if tonumber(guiGetText(handling_suspensionforcelevel)) < 0 then
        guiSetText(handling_suspensionforcelevel, "0.0")
      end
      if tonumber(guiGetText(handling_suspensionforcelevel)) > 100 then
        guiSetText(handling_suspensionforcelevel, "100.0")
      end
      return 
    end
    if source == handling_suspensiondamping then
      if tonumber(guiGetText(handling_suspensiondamping)) < 0 then
        guiSetText(handling_suspensiondamping, "0.0")
      end
      if tonumber(guiGetText(handling_suspensiondamping)) > 100 then
        guiSetText(handling_suspensiondamping, "100.0")
      end
      return 
    end
    if source == handling_suspensionhighspeeddamping then
      if tonumber(guiGetText(handling_suspensionhighspeeddamping)) < 0 then
        guiSetText(handling_suspensionhighspeeddamping, "0.0")
      end
      if tonumber(guiGetText(handling_suspensionhighspeeddamping)) > 600 then
        guiSetText(handling_suspensionhighspeeddamping, "600.0")
      end
      return 
    end
    if source == handling_suspensionupperlimit then
      if tonumber(guiGetText(handling_suspensionupperlimit)) < -50 then
        guiSetText(handling_suspensionupperlimit, "-50.0")
      end
      if tonumber(guiGetText(handling_suspensionupperlimit)) > 50 then
        guiSetText(handling_suspensionupperlimit, "50.0")
      end
      return 
    end
    if source == handling_suspensionlowerlimit then
      if tonumber(guiGetText(handling_suspensionlowerlimit)) < -50 then
        guiSetText(handling_suspensionlowerlimit, "-50.0")
      end
      if tonumber(guiGetText(handling_suspensionlowerlimit)) > 50 then
        guiSetText(handling_suspensionlowerlimit, "50.0")
      end
      return 
    end
    if source == handling_suspensionfrontrearbias then
      if tonumber(guiGetText(handling_suspensionfrontrearbias)) < 0 then
        guiSetText(handling_suspensionfrontrearbias, "0.0")
      end
      if tonumber(guiGetText(handling_suspensionfrontrearbias)) > 1 then
        guiSetText(handling_suspensionfrontrearbias, "1.0")
      end
      return 
    end
    if source == handling_suspensionantidivemultiplier then
      if tonumber(guiGetText(handling_suspensionantidivemultiplier)) < 0 then
        guiSetText(handling_suspensionantidivemultiplier, "0.0")
      end
      if tonumber(guiGetText(handling_suspensionantidivemultiplier)) > 30 then
        guiSetText(handling_suspensionantidivemultiplier, "30.0")
      end
      return 
    end
    if source == handling_seatoffsetdistance then
      if tonumber(guiGetText(handling_seatoffsetdistance)) < -20 then
        guiSetText(handling_seatoffsetdistance, "-20.0")
      end
      if tonumber(guiGetText(handling_seatoffsetdistance)) > 20 then
        guiSetText(handling_seatoffsetdistance, "20.0")
      end
      return 
    end
    if source == handling_collisiondamagemultiplier then
      if tonumber(guiGetText(handling_collisiondamagemultiplier)) < 0 then
        guiSetText(handling_collisiondamagemultiplier, "0.0")
      end
      if tonumber(guiGetText(handling_collisiondamagemultiplier)) > 10 then
        guiSetText(handling_collisiondamagemultiplier, "10.0")
      end
      return 
    end
    if source == sirens_count then
      local r1_163 = tonumber(guiGetText(sirens_count))
      if not r1_163 then
        for r5_163 = 1, 8, 1 do
          guiSetEnabled(sirens_xcenter[r5_163], false)
          guiSetEnabled(sirens_ycenter[r5_163], false)
          guiSetEnabled(sirens_zcenter[r5_163], false)
          guiSetEnabled(sirens_color[r5_163], false)
          guiSetEnabled(sirens_minalpha[r5_163], false)
        end
      else
        for r5_163 = 1, 8, 1 do
          guiSetEnabled(sirens_xcenter[r5_163], r5_163 <= r1_163)
          guiSetEnabled(sirens_ycenter[r5_163], r5_163 <= r1_163)
          guiSetEnabled(sirens_zcenter[r5_163], r5_163 <= r1_163)
          guiSetEnabled(sirens_color[r5_163], r5_163 <= r1_163)
          guiSetEnabled(sirens_minalpha[r5_163], r5_163 <= r1_163)
        end
      end
      return 
    end
    if source == weapons_addname then
      local r1_163 = guiGetText(weapons_addname)
      guiSetText(weapons_addnames, r1_163)
      local r2_163 = convertWeaponNamesToID[r1_163]
      if r2_163 then
        if 16 <= r2_163 and r2_163 <= 43 then
          r3_163 = getWeaponProperty(r2_163, "pro", "maximum_clip_ammo")
          if not r3_163 then
            ::label_1194::
            r3_163 = 1
          end
        else
          goto label_1194	-- block#246 is visited secondly
        end
        local r4_163 = getSlotFromWeapon(r2_163)
        guiSetText(weapons_addammo, tostring(r3_163))
        guiSetText(weapons_addlimit, "")
        guiSetText(weapons_addcost, "$")
        guiSetText(weapons_addslot, tostring(r4_163))
      end
      r3_163 = fileExists("images/hud/" .. r1_163 .. ".png")
      if r3_163 then
        guiStaticImageLoadImage(weapons_addicon, "images/hud/" .. r1_163 .. ".png")
      else
        guiStaticImageLoadImage(weapons_addicon, "images/color_pixel.png")
      end
      return 
    end
    if source == weapons_addcost then
      guiSetText(weapons_addcost, "$" .. guiGetText(weapons_addcost):gsub("%$", ""))
      if tonumber(guiGetProperty(weapons_addcost, "CaratIndex")) < 1 then
        guiEditSetCaretIndex(weapons_addcost, 1)
      end
      return 
    end
    if source == weapons_addslot then
      local r1_163 = 0
      local r2_163 = {}
      r3_163 = getTacticsData("weapon_slot") or {}
      for r7_163, r8_163 in ipairs(weapons_items) do
        local r9_163 = guiGetText(r8_163.name)
        local r10_163 = convertWeaponNamesToID[r9_163]
        local r11_163 = tonumber(r3_163[r9_163])
        if not r11_163 then
          if r10_163 then
            r11_163 = getSlotFromWeapon(r10_163) or 13
          else
            goto label_1302	-- block#263 is visited secondly
          end
        end
        if not r2_163[r11_163] then
          r1_163 = r1_163 + 1
          r2_163[r11_163] = r1_163
        end
      end
      local r4_163 = guiGetText(weapons_addslot)
      if not r2_163[r4_163] then
        r1_163 = r1_163 + 1
        r2_163[r4_163] = r1_163
      end
      local r5_163 = string.format("%02X%02X%02X", HSLtoRGB(360 * r2_163[r4_163] / r1_163, 0.5, 0.5))
      guiSetProperty(weapons_addicon, "ImageColours", "tl:FF" .. r5_163 .. " tr:FF" .. r5_163 .. " bl:FF" .. r5_163 .. " br:FF" .. r5_163 .. "")
      return 
    end
  end
  function onClientGUIMouseUp(r0_164, r1_164, r2_164)
    -- line: [3454, 3457] id: 164
    local r3_164 = nil	-- notice: implicit variable refs by block#[0]
    palette_mode = r3_164
    r3_164 = nil
    wind_mode = r3_164
  end
  function onClientGUIFocus()
    -- line: [3458, 3476] id: 165
    if source == player_setteamcombobox then
      guiComboBoxClear(player_setteamcombobox)
      local r0_165 = getElementsByType("team")
      table.insert(r0_165, r0_165[1])
      table.remove(r0_165, 1)
      for r4_165, r5_165 in ipairs(r0_165) do
        guiComboBoxAddItem(player_setteamcombobox, getTeamName(r5_165))
      end
      return 
    end
    if source == weapons_addcost then
      if tonumber(guiGetProperty(weapons_addcost, "CaratIndex")) < 1 then
        guiEditSetCaretIndex(weapons_addcost, 1)
      end
      return 
    end
  end
  function onClientGUIMouseDown(r0_166, r1_166, r2_166)
    -- line: [3477, 3497] id: 166
    if source == palette_aim or source == palette_hue then
      palette_mode = 1
      guiBringToFront(palette_light)
      guiBringToFront(palette_aim)
      guiBringToFront(palette_aim2)
      return 
    end
    if source == palette_aim2 or source == palette_light or source == palette_color1 then
      palette_mode = 2
      guiBringToFront(palette_light)
      guiBringToFront(palette_aim)
      guiBringToFront(palette_aim2)
      return 
    end
    if source == wind_aim or source == wind_radar then
      wind_mode = 1
      guiBringToFront(wind_aim)
      return 
    end
  end
  function onClientCursorMove(r0_167, r1_167, r2_167, r3_167, r4_167, r5_167, r6_167)
    -- line: [3498, 3540] id: 167
    if isElement(palette_window) and guiGetVisible(palette_window) then
      if palette_mode == 1 then
        local r7_167, r8_167 = guiGetPosition(palette_window, false)
        local r9_167, r10_167 = guiGetSize(palette_window, false)
        palette_H = 360 * math.min(math.max((r2_167 - r7_167 - 0.05 * r9_167) / 0.75 * r9_167, 0), 1)
        palette_S = 1 - math.min(math.max((r3_167 - r8_167 - 0.09 * r10_167) / 0.65 * r10_167, 0), 1)
        guiSetPosition(palette_aim, 0.03 + 0.75 * palette_H / 360, 0.07 + 0.65 * (1 - palette_S), true)
        local r13_167 = string.format("%02X%02X%02X", HSLtoRGB(palette_H, palette_S, 0.5))
        local r14_167, r15_167, r16_167 = HSLtoRGB(palette_H, palette_S, palette_L)
        local r17_167 = string.format("%02X%02X%02X", r14_167, r15_167, r16_167)
        guiSetProperty(palette_color1, "ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", r13_167, r13_167, r13_167, r13_167))
        guiSetProperty(palette_color2, "ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", r17_167, r17_167, r17_167, r17_167))
        guiSetText(palette_rr, tostring(r14_167))
        guiSetText(palette_gg, tostring(r15_167))
        guiSetText(palette_bb, tostring(r16_167))
        return 
      elseif palette_mode == 2 then
        local r7_167, r8_167 = guiGetPosition(palette_window, false)
        local r9_167, r10_167 = guiGetSize(palette_window, false)
        palette_L = 1 - math.min(math.max((r3_167 - r8_167 - 0.09 * r10_167) / 0.65 * r10_167, 0), 1)
        guiSetPosition(palette_aim2, 0.93, 0.07 + 0.65 * (1 - palette_L), true)
        local r12_167 = string.format("%02X%02X%02X", HSLtoRGB(palette_H, palette_S, 0.5))
        local r13_167, r14_167, r15_167 = HSLtoRGB(palette_H, palette_S, palette_L)
        local r16_167 = string.format("%02X%02X%02X", r13_167, r14_167, r15_167)
        guiSetProperty(palette_color1, "ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", r12_167, r12_167, r12_167, r12_167))
        guiSetProperty(palette_color2, "ImageColours", string.format("tl:FF%s tr:FF%s bl:FF%s br:FF%s", r16_167, r16_167, r16_167, r16_167))
        guiSetText(palette_rr, tostring(r13_167))
        guiSetText(palette_gg, tostring(r14_167))
        guiSetText(palette_bb, tostring(r15_167))
        return 
      elseif wind_mode == 1 then
        local r7_167, r8_167 = guiGetPosition(admin_window, false)
        local r9_167, r10_167 = guiGetPosition(wind_radar, false)
        guiSetText(wind_vector, string.format("%.1f", getAngleBetweenPoints2D(r7_167 + 160 + r9_167 + 32, r3_167, r2_167, r8_167 + 50 + r10_167 + 32)))
        return 
      end
    end
  end
  function onPaletteSetColor(r0_168)
    -- line: [3541, 3550] id: 168
    if source == sky_topcolor then
      local r1_168 = guiGetProperty(sky_bottomcolor, "ReadOnlyBGColour")
      guiSetProperty(sky_gradient, "ImageColours", string.format("tl:%s tr:%s bl:%s br:%s", r0_168, r0_168, r1_168, r1_168))
    end
    if source == sky_bottomcolor then
      local r1_168 = guiGetProperty(sky_topcolor, "ReadOnlyBGColour")
      guiSetProperty(sky_gradient, "ImageColours", string.format("tl:%s tr:%s bl:%s br:%s", r1_168, r1_168, r0_168, r0_168))
    end
  end
  function onClientGUIDoubleClick(r0_169, r1_169, r2_169, r3_169)
    -- line: [3551, 3774] id: 169
    if r0_169 ~= "left" then
      return 
    end
    if source == weather_record then
      local r4_169, r5_169 = guiGridListGetSelectedItem(weather_record)
      if r5_169 < 1 then
        return 
      end
      local r6_169 = tonumber(guiGridListGetItemData(weather_record, 1, r5_169))
      if not r6_169 then
        return 
      end
      local r7_169 = getTacticsData("Weather") or {}
      if not r7_169[r6_169] then
        return 
      end
      r7_169 = r7_169[r6_169]
      guiSetText(wind_vector, string.format("%.1f", getAngleBetweenPoints2D(0, 0, r7_169.wind[1], r7_169.wind[2])))
      guiSetText(wind_speed, string.format("%.1f", 200 * math.sqrt((r7_169.wind[1] ^ 2 + r7_169.wind[2] ^ 2)) / 3.6))
      guiScrollBarSetScrollPosition(wind_slide, math.min(200 * math.sqrt((r7_169.wind[1] ^ 2 + r7_169.wind[2] ^ 2)) / 3.6 * 2, 100))
      guiScrollBarSetScrollPosition(heat_levelslide, math.min(r7_169.heat / 2.55, 100))
      guiSetText(heat_level, string.format("%.1f", r7_169.heat))
      guiScrollBarSetScrollPosition(rain_slide, math.min(50 * r7_169.rain, 100))
      guiSetText(rain_level, string.format("%.1f", r7_169.rain))
      guiScrollBarSetScrollPosition(farclip_slide, math.min(r7_169.far / 30, 100))
      guiSetText(farclip_distance, string.format("%.1f", r7_169.far))
      guiScrollBarSetScrollPosition(fog_slide, math.min((r7_169.fog + 1000) / 40, 100))
      guiSetText(fog_distance, string.format("%.1f", r7_169.fog))
      guiSetProperty(sky_topcolor, "ReadOnlyBGColour", string.format("FF%02X%02X%02X", r7_169.sky[1], r7_169.sky[2], r7_169.sky[3]))
      guiBringToFront(sky_topcolor)
      guiSetProperty(sky_bottomcolor, "ReadOnlyBGColour", string.format("FF%02X%02X%02X", r7_169.sky[4], r7_169.sky[5], r7_169.sky[6]))
      guiBringToFront(sky_bottomcolor)
      guiSetProperty(sky_gradient, "ImageColours", string.format("tl:FF%02X%02X%02X tr:FF%02X%02X%02X bl:FF%02X%02X%02X br:FF%02X%02X%02X", r7_169.sky[1], r7_169.sky[2], r7_169.sky[3], r7_169.sky[1], r7_169.sky[2], r7_169.sky[3], r7_169.sky[4], r7_169.sky[5], r7_169.sky[6], r7_169.sky[4], r7_169.sky[5], r7_169.sky[6]))
      guiSetVisible(sky_clouds_img, r7_169.clouds)
      guiCheckBoxSetSelected(sky_clouds, r7_169.clouds)
      guiSetVisible(sky_birds_img, r7_169.birds)
      guiCheckBoxSetSelected(sky_birds, r7_169.birds)
      guiScrollBarSetScrollPosition(sun_sizeslide, math.min(r7_169.sunsize * 2, 100))
      guiSetText(sun_size, string.format("%.1f", r7_169.sunsize))
      guiSetProperty(sun_colora, "ReadOnlyBGColour", string.format("FF%02X%02X%02X", r7_169.sun[1], r7_169.sun[2], r7_169.sun[3]))
      guiBringToFront(sun_colora)
      guiSetProperty(sun_colorb, "ReadOnlyBGColour", string.format("FF%02X%02X%02X", r7_169.sun[4], r7_169.sun[5], r7_169.sun[6]))
      guiBringToFront(sun_colorb)
      guiSetProperty(water_color, "ReadOnlyBGColour", string.format("%02X%02X%02X%02X", r7_169.water[4], r7_169.water[1], r7_169.water[2], r7_169.water[3]))
      guiBringToFront(water_color)
      guiScrollBarSetScrollPosition(water_levelslide, math.min((r7_169.level + 200) / 4, 100))
      guiSetText(water_level, string.format("%.1f", r7_169.level))
      guiScrollBarSetScrollPosition(wave_heightslide, math.min(r7_169.wave * 10, 100))
      guiSetText(wave_height, string.format("%.1f", r7_169.wave))
      guiSetText(weather_effect, ({
        [0] = "Clear",
        [10] = "Cloudy",
        [8] = "Thunder",
        [19] = "Storm",
        [9] = "Fog",
      })[r7_169.effect] or tostring(r7_169.effect))
    end
    if source == server_maps then
      local r4_169 = guiGridListGetSelectedItem(server_maps)
      if r4_169 == -1 then
        return 
      end
      callServerFunction("startMap", guiGridListGetItemData(server_maps, r4_169, 1))
    end
    if source == server_cycler then
      local r4_169 = guiGridListGetSelectedItem(server_cycler)
      if r4_169 == -1 then
        return 
      end
      callServerFunction("startMap", guiGridListGetItemData(server_cycler, r4_169, 2), r4_169 + 1)
    end
    if source == config_list then
      local r4_169 = guiGridListGetSelectedItem(config_list)
      if r4_169 == -1 then
        return 
      end
      callServerFunction("startConfig", guiGridListGetItemText(config_list, r4_169, 1))
    end
    if source == restore_list then
      local r4_169 = guiGridListGetSelectedItem(restore_list)
      if r4_169 == -1 then
        return 
      end
      callServerFunction("restorePlayerLoad", restore_player, r4_169 + 1)
      if guiCheckBoxGetSelected(config_performance_adminpanel) then
        destroyElement(restore_window)
      else
        guiSetVisible(restore_window, false)
      end
      restore_player = false
    end
    if source == vehicles_disabled then
      local r4_169 = guiGridListGetSelectedItem(vehicles_disabled)
      if r4_169 == -1 then
        return 
      end
      setTacticsData(nil, "disabled_vehicles", tonumber(guiGridListGetItemData(vehicles_disabled, r4_169, 1)))
    end
    if source == vehicles_enabled then
      local r4_169 = guiGridListGetSelectedItem(vehicles_enabled)
      if r4_169 == -1 then
        return 
      end
      setTacticsData(true, "disabled_vehicles", tonumber(guiGridListGetItemData(vehicles_enabled, r4_169, 1)))
    end
    if source == modes_rules then
      local r4_169 = guiGridListGetSelectedItem(modes_list)
      local r5_169 = guiGridListGetSelectedItem(modes_rules)
      if r5_169 == -1 or r4_169 == -1 then
        return 
      end
      local r6_169 = guiGridListGetItemText(modes_list, r4_169, 1)
      local r7_169 = guiGridListGetItemText(modes_rules, r5_169, 1)
      local r8_169 = guiGridListGetItemData(modes_rules, r5_169, 2)
      if r8_169 == "true" then
        if r6_169 == "settings" then
          setTacticsData("false", "settings", r7_169)
        elseif r6_169 == "glitches" then
          setTacticsData("false", "glitches", r7_169)
        elseif r6_169 == "cheats" then
          setTacticsData("false", "cheats", r7_169)
        elseif r6_169 == "limites" then
          setTacticsData("false", "limites", r7_169)
        else
          setTacticsData("false", "modes", r6_169, r7_169)
        end
      elseif r8_169 == "false" then
        if r6_169 == "settings" then
          setTacticsData("true", "settings", r7_169)
        elseif r6_169 == "glitches" then
          setTacticsData("true", "glitches", r7_169)
        elseif r6_169 == "cheats" then
          setTacticsData("true", "cheats", r7_169)
        elseif r6_169 == "limites" then
          setTacticsData("true", "limites", r7_169)
        else
          setTacticsData("true", "modes", r6_169, r7_169)
        end
      else
        if not isElement(rules_window) then
          createAdminRules()
        end
        if string.find(r8_169, "|") then
          guiSetVisible(rules_edit, false)
          guiSetVisible(rules_list, true)
          guiSetVisible(rules_time, false)
          guiSetVisible(rules_time_up, false)
          guiSetVisible(rules_time_down, false)
          guiGridListClear(rules_list)
          local r9_169 = string.sub(r8_169, 1, string.find(r8_169, "|") - 1)
          local r10_169 = string.sub(r8_169, string.find(r8_169, "|") + 1, -1)
          local r11_169 = {}
          local r12_169 = 1
          local r13_169 = 1
          local r14_169 = nil
          while r13_169 do
            r13_169 = string.find(r10_169, ",", r12_169)
            if r13_169 then
              r11_169 = string.sub(r10_169, r12_169, r13_169 - 1)
              r12_169 = r13_169 + 1
            else
              r11_169 = string.sub(r10_169, r12_169, -1)
            end
            r14_169 = guiGridListAddRow(rules_list)
            guiGridListSetItemText(rules_list, r14_169, 1, r11_169, false, false)
            if r11_169 == r9_169 then
              guiGridListSetSelectedItem(rules_list, r14_169, 1)
            end
          end
          guiSetPosition(rules_window, xscreen * 0.5 - 120, (yscreen - 130 - 14 * r14_169) * 0.5, false)
          guiSetSize(rules_window, 240, 130 + 14 * r14_169, false)
          guiSetPosition(rules_ok, 60, 100 + 14 * r14_169, false)
          guiSetPosition(rules_cancel, 122.4, 100 + 14 * r14_169, false)
          guiSetSize(rules_list, 192, 50 + 14 * r14_169, false)
          guiSetText(rules_label, "Choise new value for \'" .. r7_169 .. "\'")
        elseif string.find(r8_169, ":") then
          guiSetVisible(rules_edit, false)
          guiSetVisible(rules_list, false)
          guiSetVisible(rules_time, true)
          guiSetVisible(rules_time_up, true)
          guiSetVisible(rules_time_down, true)
          guiSetPosition(rules_window, (xscreen - 240) * 0.5, (yscreen - 120) * 0.5, false)
          guiSetSize(rules_window, 240, 120, false)
          guiSetPosition(rules_ok, 60, 90, false)
          guiSetPosition(rules_cancel, 122.4, 90, false)
          guiSetText(rules_label, "Choise new time for \'" .. r7_169 .. "\'")
          local r9_169 = split(tostring(r8_169), string.byte(":"))
          local r10_169 = tonumber(r9_169[#r9_169 - 2]) or 0
          local r11_169 = tonumber(r9_169[#r9_169 - 1]) or 0
          local r12_169 = tonumber(gettok(r9_169[#r9_169], 1, string.byte("."))) or 0
          guiSetText(rules_time, string.format("%02i:%02i:%02i.%i", r10_169, r11_169, r12_169, tonumber(gettok(r9_169[#r9_169], 2, string.byte("."))) or 0))
        else
          guiSetVisible(rules_edit, true)
          guiSetVisible(rules_list, false)
          guiSetVisible(rules_time, false)
          guiSetVisible(rules_time_up, false)
          guiSetVisible(rules_time_down, false)
          guiSetPosition(rules_window, (xscreen - 240) * 0.5, (yscreen - 100) * 0.5, false)
          guiSetSize(rules_window, 240, 100, false)
          guiSetPosition(rules_ok, 60, 70, false)
          guiSetPosition(rules_cancel, 122.4, 70, false)
          guiSetText(rules_label, "Enter new value for \'" .. r7_169 .. "\'")
          guiSetText(rules_edit, tostring(r8_169))
        end
        guiBringToFront(rules_window)
        guiSetVisible(rules_window, true)
      end
    end
    if source == anticheat_modslist then
      if not isElement(mods_window) then
        createAdminMods()
      end
      local r4_169 = guiGridListGetSelectedItem(anticheat_modslist)
      if r4_169 == -1 then
        return 
      end
      local r5_169 = guiGridListGetItemText(anticheat_modslist, r4_169, 1)
      local r6_169 = guiGridListGetItemText(anticheat_modslist, r4_169, 2)
      local r7_169 = guiGridListGetItemData(anticheat_modslist, r4_169, 2)
      guiSetText(mods_name, r5_169)
      guiSetText(mods_edit, r6_169)
      guiSetText(mods_ok, "Set")
      if r7_169 == "name" then
        guiRadioButtonSetSelected(mods_type_name, true)
      end
      if r7_169 == "hash" then
        guiRadioButtonSetSelected(mods_type_hash, true)
      end
      guiBringToFront(mods_window)
      guiSetVisible(mods_window, true)
    end
    if source == rules_list then
      local r4_169 = guiGridListGetSelectedItem(modes_list)
      local r5_169 = guiGridListGetSelectedItem(modes_rules)
      local r6_169 = guiGridListGetSelectedItem(rules_list)
      if guiCheckBoxGetSelected(config_performance_adminpanel) then
        destroyElement(rules_window)
      else
        guiSetVisible(rules_window, false)
      end
      if -1 < r6_169 and isElement(admin_window) then
        local r7_169 = guiGridListGetItemText(rules_list, r6_169, 1)
        if r4_169 == -1 or r5_169 == -1 then
          return 
        end
        local r8_169 = guiGridListGetItemText(modes_list, r4_169, 1)
        local r9_169 = guiGridListGetItemText(modes_rules, r5_169, 1)
        if r8_169 == "settings" then
          setTacticsData(r7_169, "settings", r9_169, true)
        elseif r8_169 == "glitches" then
          setTacticsData(r7_169, "glitches", r9_169, true)
        elseif r8_169 == "cheats" then
          setTacticsData(r7_169, "cheats", r9_169, true)
        elseif r8_169 == "limites" then
          setTacticsData(r7_169, "limites", r9_169, true)
        else
          setTacticsData(r7_169, "modes", r8_169, r9_169, true)
        end
      end
    end
  end
  function onClientGUIComboBoxAccepted(r0_170)
    -- line: [3775, 4029] id: 170
    -- notice: unreachable block#142
    -- notice: unreachable block#134
    -- notice: unreachable block#198
    -- notice: unreachable block#194
    -- notice: unreachable block#190
    -- notice: unreachable block#130
    -- notice: unreachable block#146
    -- notice: unreachable block#206
    -- notice: unreachable block#138
    -- notice: unreachable block#202
    if source == shooting_weapon then
      local r1_170 = getWeaponIDFromName(guiGetText(shooting_weapon))
      guiSetText(shooting_weapon_range, string.format("%.4f", getWeaponProperty(r1_170, "pro", "weapon_range")))
      guiSetText(shooting_target_range, string.format("%.4f", getWeaponProperty(r1_170, "pro", "target_range")))
      guiSetText(shooting_accuracy, string.format("%.4f", getWeaponProperty(r1_170, "pro", "accuracy")))
      guiSetText(shooting_damage, string.format("%.4f", getWeaponProperty(r1_170, "pro", "damage") / 3))
      guiSetText(shooting_maximum_clip, getWeaponProperty(r1_170, "pro", "maximum_clip_ammo"))
      guiSetText(shooting_move_speed, string.format("%.4f", getWeaponProperty(r1_170, "pro", "move_speed")))
      guiSetText(shooting_anim_loop_start, string.format("%.4f", getWeaponProperty(r1_170, "pro", "anim_loop_start")))
      guiSetText(shooting_anim_loop_stop, string.format("%.4f", getWeaponProperty(r1_170, "pro", "anim_loop_stop")))
      guiSetText(shooting_anim_loop_bullet_fire, string.format("%.4f", getWeaponProperty(r1_170, "pro", "anim_loop_bullet_fire")))
      guiSetText(shooting_anim2_loop_start, string.format("%.4f", getWeaponProperty(r1_170, "pro", "anim2_loop_start")))
      guiSetText(shooting_anim2_loop_stop, string.format("%.4f", getWeaponProperty(r1_170, "pro", "anim2_loop_stop")))
      guiSetText(shooting_anim2_loop_bullet_fire, string.format("%.4f", getWeaponProperty(r1_170, "pro", "anim2_loop_bullet_fire")))
      guiSetText(shooting_anim_breakout_time, string.format("%.4f", getWeaponProperty(r1_170, "pro", "anim_breakout_time")))
      local r2_170 = string.reverse(string.format("%06X", getWeaponProperty(r1_170, "pro", "flags")))
      for r6_170 = 1, 4, 1 do
        local r7_170 = tonumber(string.sub(r2_170, r6_170, r6_170), 16)
        if r7_170 then
          if r7_170 >= 8 then
            guiCheckBoxSetSelected(shooting_flags[r6_170][8], true)
            r7_170 = r7_170 - 8
          else
            guiCheckBoxSetSelected(shooting_flags[r6_170][8], false)
          end
          if r7_170 >= 4 then
            guiCheckBoxSetSelected(shooting_flags[r6_170][4], true)
            r7_170 = r7_170 - 4
          else
            guiCheckBoxSetSelected(shooting_flags[r6_170][4], false)
          end
          if r7_170 >= 2 then
            guiCheckBoxSetSelected(shooting_flags[r6_170][2], true)
            r7_170 = r7_170 - 2
          else
            guiCheckBoxSetSelected(shooting_flags[r6_170][2], false)
          end
          if r7_170 >= 1 then
            guiCheckBoxSetSelected(shooting_flags[r6_170][1], true)
            r7_170 = r7_170 - 1
          else
            guiCheckBoxSetSelected(shooting_flags[r6_170][1], false)
          end
        else
          guiCheckBoxSetSelected(shooting_flags[r6_170][1], false)
          guiCheckBoxSetSelected(shooting_flags[r6_170][2], false)
          guiCheckBoxSetSelected(shooting_flags[r6_170][4], false)
          guiCheckBoxSetSelected(shooting_flags[r6_170][8], false)
        end
      end
    end
    if source == handling_model then
      local r1_170 = getVehicleModelFromName(guiGetText(handling_model))
      local r2_170 = (getTacticsData("handlings") or {})[r1_170] or {}
      local r3_170 = getOriginalHandling(r1_170)
      guiSetText(handling_mass, string.format("%.1f", r2_170.mass or r3_170.mass))
      guiSetText(handling_turnmass, string.format("%.1f", r2_170.turnMass or r3_170.turnMass))
      guiSetText(handling_dragcoeff, string.format("%.3f", r2_170.dragCoeff or r3_170.dragCoeff))
      local r4_170 = guiSetText
      local r5_170 = handling_centerofmass_x
      local r6_170 = string.format
      local r7_170 = "%.3f"
      local r8_170 = r2_170.centerOfMass
      if r8_170 then
        r8_170 = r2_170.centerOfMass[1] or r3_170.centerOfMass[1]
      else
        goto label_346	-- block#30 is visited secondly
      end
      r4_170(r5_170, r6_170(r7_170, r8_170))
      r4_170 = guiSetText
      r5_170 = handling_centerofmass_y
      r6_170 = string.format
      r7_170 = "%.3f"
      r8_170 = r2_170.centerOfMass
      if r8_170 then
        r8_170 = r2_170.centerOfMass[2] or r3_170.centerOfMass[2]
      else
        goto label_362	-- block#33 is visited secondly
      end
      r4_170(r5_170, r6_170(r7_170, r8_170))
      r4_170 = guiSetText
      r5_170 = handling_centerofmass_z
      r6_170 = string.format
      r7_170 = "%.3f"
      r8_170 = r2_170.centerOfMass
      if r8_170 then
        r8_170 = r2_170.centerOfMass[3] or r3_170.centerOfMass[3]
      else
        goto label_378	-- block#36 is visited secondly
      end
      r4_170(r5_170, r6_170(r7_170, r8_170))
      guiSetText(handling_percentsubmerged, string.format("%.0f", r2_170.percentSubmerged or r3_170.percentSubmerged))
      guiSetText(handling_tractionmultiplier, string.format("%.3f", r2_170.tractionMultiplier or r3_170.tractionMultiplier))
      guiSetText(handling_tractionloss, string.format("%.3f", r2_170.tractionLoss or r3_170.tractionLoss))
      guiSetText(handling_tractionbias, string.format("%.3f", r2_170.tractionBias or r3_170.tractionBias))
      guiSetText(handling_numberofgears, string.format("%.0f", r2_170.numberOfGears or r3_170.numberOfGears))
      guiSetText(handling_maxvelocity, string.format("%.3f", r2_170.maxVelocity or r3_170.maxVelocity))
      guiSetText(handling_engineacceleration, string.format("%.3f", r2_170.engineAcceleration or r3_170.engineAcceleration))
      guiSetText(handling_engineinertia, string.format("%.3f", r2_170.engineInertia or r3_170.engineInertia))
      r4_170 = guiSetText
      r5_170 = handling_drivetype
      r6_170 = {
        awd = "4x4",
        fwd = "Front",
        rwd = "Rear",
      }
      r4_170(r5_170, r6_170[r2_170.driveType or r3_170.driveType])
      r4_170 = guiSetText
      r5_170 = handling_enginetype
      r6_170 = {
        petrol = "Petrol",
        diesel = "Diesel",
        electric = "Electric",
      }
      r4_170(r5_170, r6_170[r2_170.engineType or r3_170.engineType])
      guiSetText(handling_brakedeceleration, string.format("%.3f", r2_170.brakeDeceleration or r3_170.brakeDeceleration))
      guiSetText(handling_brakebias, string.format("%.3f", r2_170.brakeBias or r3_170.brakeBias))
      r4_170 = guiSetText
      r5_170 = handling_abs
      r6_170 = r2_170.ABS
      if r6_170 ~= nil then
        r6_170 = r2_170.ABS
        if r6_170 then
          r6_170 = "Enable"
          if not r6_170 then
            ::label_527::
            r6_170 = "Disable"
            if not r6_170 then
              ::label_530::
              r6_170 = r3_170.ABS
              if r6_170 then
                r6_170 = "Enable" or "Disable"
              else
                goto label_536	-- block#67 is visited secondly
              end
            end
          end
        else
          goto label_527	-- block#64 is visited secondly
        end
      else
        goto label_530	-- block#65 is visited secondly
      end
      r4_170(r5_170, r6_170)
      guiSetText(handling_steeringlock, string.format("%.3f", r2_170.steeringLock or r3_170.steeringLock))
      guiSetText(handling_suspensionforcelevel, string.format("%.3f", r2_170.suspensionForceLevel or r3_170.suspensionForceLevel))
      guiSetText(handling_suspensiondamping, string.format("%.3f", r2_170.suspensionDamping or r3_170.suspensionDamping))
      guiSetText(handling_suspensionhighspeeddamping, string.format("%.3f", r2_170.suspensionHighSpeedDamping or r3_170.suspensionHighSpeedDamping))
      guiSetText(handling_suspensionupperlimit, string.format("%.3f", r2_170.suspensionUpperLimit or r3_170.suspensionUpperLimit))
      guiSetText(handling_suspensionlowerlimit, string.format("%.3f", r2_170.suspensionLowerLimit or r3_170.suspensionLowerLimit))
      guiSetText(handling_suspensionfrontrearbias, string.format("%.3f", r2_170.suspensionFrontRearBias or r3_170.suspensionFrontRearBias))
      guiSetText(handling_suspensionantidivemultiplier, string.format("%.3f", r2_170.suspensionAntiDiveMultiplier or r3_170.suspensionAntiDiveMultiplier))
      guiSetText(handling_seatoffsetdistance, string.format("%.3f", r2_170.seatOffsetDistance or r3_170.seatOffsetDistance))
      guiSetText(handling_collisiondamagemultiplier, string.format("%.3f", r2_170.collisionDamageMultiplier or r3_170.collisionDamageMultiplier))
      guiSetText(handling_variant1, string.format("%.3f", r2_170.collisionDamageMultiplier or r3_170.collisionDamageMultiplier))
      guiComboBoxClear(handling_variant1)
      guiComboBoxClear(handling_variant2)
      guiComboBoxAddItem(handling_variant1, "Random")
      guiComboBoxAddItem(handling_variant2, "Random")
      for r7_170, r8_170 in pairs(convertVehicleVariant[r1_170] or {}) do
        guiComboBoxAddItem(handling_variant1, tostring(r8_170))
        guiComboBoxAddItem(handling_variant2, tostring(r8_170))
      end
      r4_170 = string.reverse(string.format("%08X", tonumber(r2_170.modelFlags) or r3_170.modelFlags))
      r5_170 = string.reverse(string.format("%08X", tonumber(r2_170.handlingFlags) or r3_170.handlingFlags))
      for r9_170 = 1, 8, 1 do
        local r10_170 = tonumber("0x" .. string.sub(r4_170, r9_170, r9_170)) or 0
        local r11_170 = tonumber("0x" .. string.sub(r5_170, r9_170, r9_170)) or 0
        for r15_170 = 3, 0, -1 do
          local r16_170 = 2 ^ r15_170
          if r16_170 <= r10_170 and 0 <= r10_170 % r16_170 then
            r10_170 = r10_170 - r16_170
            guiCheckBoxSetSelected(handling_modelflags[r9_170][r16_170], true)
          else
            guiCheckBoxSetSelected(handling_modelflags[r9_170][r16_170], false)
          end
          if r16_170 <= r11_170 and 0 <= r11_170 % r16_170 then
            r11_170 = r11_170 - r16_170
            guiCheckBoxSetSelected(handling_handlingflags[r9_170][r16_170], true)
          else
            guiCheckBoxSetSelected(handling_handlingflags[r9_170][r16_170], false)
          end
        end
      end
      if not r2_170.sirens then
        guiSetText(sirens_count, "Original")
        guiSetText(sirens_type, "Dual")
        guiCheckBoxSetSelected(sirens_360, false)
        guiCheckBoxSetSelected(sirens_LOS, false)
        guiCheckBoxSetSelected(sirens_randomiser, false)
        guiCheckBoxSetSelected(sirens_silent, false)
        for r9_170 = 1, 8, 1 do
          guiSetText(sirens_xcenter[r9_170], "0.000")
          guiSetText(sirens_ycenter[r9_170], "0.000")
          guiSetText(sirens_zcenter[r9_170], "0.000")
          guiSetProperty(sirens_color[r9_170], "ReadOnlyBGColour", "FF808080")
          guiBringToFront(sirens_color[r9_170])
          guiSetText(sirens_minalpha[r9_170], "0")
          guiSetEnabled(sirens_xcenter[r9_170], false)
          guiSetEnabled(sirens_ycenter[r9_170], false)
          guiSetEnabled(sirens_zcenter[r9_170], false)
          guiSetEnabled(sirens_color[r9_170], false)
          guiSetEnabled(sirens_minalpha[r9_170], false)
        end
      else
        r6_170 = guiSetText
        r7_170 = sirens_count
        r8_170 = r2_170.sirens.count
        if r8_170 == 0 then
          r8_170 = "Original" or tostring(r2_170.sirens.count)
        else
          goto label_893	-- block#122 is visited secondly
        end
        r6_170(r7_170, r8_170)
        guiSetText(sirens_type, ({
          [1] = "Invisible",
          [2] = "Single",
          [3] = "Dual",
          [4] = "Triple",
          [5] = "Quadruple",
          [6] = "Quinary",
        })[r2_170.sirens.type])
        guiCheckBoxSetSelected(sirens_360, r2_170.sirens.flags["360"])
        guiCheckBoxSetSelected(sirens_LOS, r2_170.sirens.flags.DoLOSCheck)
        guiCheckBoxSetSelected(sirens_randomiser, r2_170.sirens.flags.UseRandomiser)
        guiCheckBoxSetSelected(sirens_silent, r2_170.sirens.flags.Silent)
        for r9_170 = 1, 8, 1 do
          if r9_170 <= r2_170.sirens.count then
            guiSetText(sirens_xcenter[r9_170], string.format("%.3f", r2_170.sirens[r9_170].x))
            guiSetText(sirens_ycenter[r9_170], string.format("%.3f", r2_170.sirens[r9_170].y))
            guiSetText(sirens_zcenter[r9_170], string.format("%.3f", r2_170.sirens[r9_170].z))
            guiSetProperty(sirens_color[r9_170], "ReadOnlyBGColour", r2_170.sirens[r9_170].color)
            guiBringToFront(sirens_color[r9_170])
            guiSetText(sirens_minalpha[r9_170], tostring(r2_170.sirens[r9_170].minalpha))
          else
            guiSetText(sirens_xcenter[r9_170], "0.000")
            guiSetText(sirens_ycenter[r9_170], "0.000")
            guiSetText(sirens_zcenter[r9_170], "0.000")
            guiSetProperty(sirens_color[r9_170], "ReadOnlyBGColour", "FF808080")
            guiBringToFront(sirens_color[r9_170])
            guiSetText(sirens_minalpha[r9_170], "0")
          end
          guiSetEnabled(sirens_xcenter[r9_170], r9_170 <= r2_170.sirens.count)
          guiSetEnabled(sirens_ycenter[r9_170], r9_170 <= r2_170.sirens.count)
          guiSetEnabled(sirens_zcenter[r9_170], r9_170 <= r2_170.sirens.count)
          guiSetEnabled(sirens_color[r9_170], r9_170 <= r2_170.sirens.count)
          guiSetEnabled(sirens_minalpha[r9_170], r9_170 <= r2_170.sirens.count)
        end
      end
    end
    if source == anticheat_action then
      setTacticsData(({
        ["Chat message"] = "chat",
        ["Adminchat message"] = "adminchat",
        Kick = "kick",
      })[guiGetText(anticheat_action)], "anticheat", "action_detection", true)
    end
    if source == anticheat_speedhack then
      setTacticsData(({
        Enabled = "true",
        Disabled = "false",
      })[guiGetText(anticheat_speedhack)], "anticheat", "speedhack")
    end
    if source == anticheat_godmode then
      setTacticsData(({
        Enabled = "true",
        Disabled = "false",
      })[guiGetText(anticheat_godmode)], "anticheat", "godmode")
    end
    if source == anticheat_mods then
      setTacticsData(({
        Enabled = "true",
        Disabled = "false",
      })[guiGetText(anticheat_mods)], "anticheat", "mods")
    end
    if source == player_setteamcombobox then
      local r1_170 = getTeamFromName(guiGetText(player_setteamcombobox))
      guiSetText(player_setteam, guiGetText(player_setteamcombobox))
      if not r3_130 then
        return 
      end
      for r5_170, r6_170 in ipairs(r3_130) do
        triggerServerEvent("onPlayerTeamSelect", r6_170, r1_170)
      end
    end
    if source == player_balancecombobox then
      local r1_170 = guiGetText(player_balancecombobox)
      if r1_170 == "Select" then
        callServerFunction("balanceTeams", localPlayer, r1_170, r3_130)
      else
        callServerFunction("balanceTeams", localPlayer, r1_170)
      end
    end
    if source == screen_list then
      loadScreenShot(guiGetText(screen_list))
    end
    if source == player_takescreencombobox then
      if guiGetText(player_takescreencombobox) == "My screens" then
        guiSetText(player_takescreencombobox, "320x240:30%")
        if not isElement(screen_window) then
          createAdminScreen()
        end
        loadScreenShot(guiGetText(screen_list))
        return 
      end
      if not r3_130 or 1 < #r3_130 then
        return 
      end
      local r1_170 = guiGetText(player_takescreencombobox)
      local r2_170 = gettok(r1_170, 1, string.byte(":"))
      local r3_170 = tonumber(gettok(r2_170, 1, string.byte("x")))
      local r4_170 = tonumber(gettok(r2_170, 2, string.byte("x")))
      local r5_170 = tonumber(({
        gettok(r1_170, 2, string.byte(":")):gsub("%%", "")
      })[1])
      if r2_170 then
        callServerFunction("takePlayerScreenShot", r3_130[1], r3_170, r4_170, getPlayerName(localPlayer) .. " " .. r3_170 .. " " .. r4_170 .. " " .. r5_170, r5_170, 5000)
      end
      guiSetText(player_takescreencombobox, "320x240:30%")
      guiSetEnabled(player_takescreen, false)
      guiSetEnabled(player_takescreencombobox, false)
      screenTimeout = setTimer(function()
        -- line: [3991, 3994] id: 171
        guiSetEnabled(player_takescreen, true)
        guiSetEnabled(player_takescreencombobox, true)
      end, 30000, 1)
    end
    if source == sirens_count then
      local r1_170 = tonumber(guiGetText(sirens_count))
      if not r1_170 then
        for r5_170 = 1, 8, 1 do
          guiSetEnabled(sirens_xcenter[r5_170], false)
          guiSetEnabled(sirens_ycenter[r5_170], false)
          guiSetEnabled(sirens_zcenter[r5_170], false)
          guiSetEnabled(sirens_color[r5_170], false)
          guiSetEnabled(sirens_minalpha[r5_170], false)
        end
      else
        for r5_170 = 1, 8, 1 do
          guiSetEnabled(sirens_xcenter[r5_170], r5_170 <= r1_170)
          guiSetEnabled(sirens_ycenter[r5_170], r5_170 <= r1_170)
          guiSetEnabled(sirens_zcenter[r5_170], r5_170 <= r1_170)
          guiSetEnabled(sirens_color[r5_170], r5_170 <= r1_170)
          guiSetEnabled(sirens_minalpha[r5_170], r5_170 <= r1_170)
        end
      end
    end
    if source == weapons_addnames then
      local r1_170 = guiGetText(weapons_addnames)
      guiStaticImageLoadImage(weapons_addicon, "images/hud/" .. r1_170 .. ".png")
      guiSetText(weapons_addname, r1_170)
      guiEditSetCaretIndex(weapons_addname, 0)
      guiSetProperty(weapons_addname, "SelectionLength", tostring(#r1_170))
      setTimer(guiBringToFront, 50, 1, weapons_addname)
    end
    if source == cycler_automatics then
      setTacticsData(({
        Lobby = "lobby",
        Cycle = "cycler",
        Voting = "voting",
        Random = "random",
      })[guiGetText(cycler_automatics)] or "lobby", "automatics", true)
    end
  end
  function onClientGUITabSwitched(r0_172)
    -- line: [4030, 4038] id: 172
    if r0_172 == admin_tab_settings and guiGridListGetSelectedItem(modes_list) == -1 then
      guiGridListSetSelectedItem(modes_list, 1, 1)
      triggerEvent("onClientGUIClick", modes_list, "left", "up")
    end
  end
  function refreshWeaponProperties()
    -- line: [4039, 4042] id: 173
    if not isElement(admin_window) then
      return 
    end
    triggerEvent("onClientGUIComboBoxAccepted", shooting_weapon)
  end
  r4_130 = {}
  function onClientMapsUpdate(r0_174)
    -- line: [4044, 4047] id: 174
    r4_130 = r0_174
    updateAdminMaps()
  end
  function updateAdminMaps()
    -- line: [4048, 4122] id: 175
    if not isElement(admin_window) then
      return 
    end
    local r0_175 = getTacticsData("map_disabled") or {}
    local r1_175 = guiGetText(maps_search)
    local r2_175 = {}
    for r6_175, r7_175 in ipairs(r4_130) do
      local r8_175 = true
      if #r1_175 > 0 then
        for r12_175 in string.gmatch(r1_175, "[^ ]+") do
          if string.sub(r12_175, 1, 1) == "-" and #r12_175 > 1 then
            r12_175 = string.sub(r12_175, 2, -1)
            if string.find(string.lower(r7_175[2]), string.lower(r12_175)) or string.find(string.lower(r7_175[3]), string.lower(r12_175)) then
              r8_175 = false
            end
          elseif not string.find(string.lower(r7_175[2]), string.lower(r12_175)) and not string.find(string.lower(r7_175[3]), string.lower(r12_175)) then
            r8_175 = false
          end
        end
      end
      if not guiCheckBoxGetSelected(maps_include) and (r0_175[tostring(r7_175[1])] or getTacticsData("modes", string.lower(r7_175[2]), "enable") == "false") then
        r8_175 = false
      end
      if r8_175 then
        table.insert(r2_175, r7_175)
      end
    end
    table.sort(r2_175, function(r0_176, r1_176)
      -- line: [4072, 4072] id: 176
      local r2_176 = r0_176[2]
      if r2_176 >= r1_176[2] then
        r2_176 = r0_176[2]
        if r2_176 == r1_176[2] then
          r2_176 = r0_176[3] < r1_176[3]
        else
          goto label_12	-- block#3 is visited secondly
        end
      else
        goto label_13	-- block#4 is visited secondly
      end
      return r2_176
    end)
    table.insert(r2_175, true)
    local r3_175 = {}
    for r7_175, r8_175 in pairs(getTacticsData("modes_defined")) do
      table.insert(r3_175, {
        r7_175,
        string.upper(string.sub(r7_175, 1, 1)) .. string.sub(r7_175, 2),
        "Random"
      })
    end
    table.sort(r3_175, function(r0_177, r1_177)
      -- line: [4078, 4078] id: 177
      return r0_177[1] < r1_177[1]
    end)
    for r7_175, r8_175 in ipairs(r3_175) do
      table.insert(r2_175, r8_175)
    end
    local r4_175 = getTacticsData("MapResName")
    local r5_175 = guiGridListGetRowCount(server_maps)
    for r9_175 = 1, math.max(r5_175, #r2_175), 1 do
      if r9_175 <= #r2_175 then
        local r10_175 = ""
        local r11_175 = ""
        local r12_175 = "-------------"
        local r13_175 = true
        if type(r2_175[r9_175]) == "table" then
          r10_175, r11_175, r12_175 = unpack(r2_175[r9_175])
          r13_175 = false
        end
        if r5_175 < r9_175 then
          guiGridListAddRow(server_maps)
        end
        guiGridListSetItemText(server_maps, r9_175 - 1, 1, r11_175, r13_175, false)
        guiGridListSetItemData(server_maps, r9_175 - 1, 1, r10_175)
        guiGridListSetItemText(server_maps, r9_175 - 1, 2, r12_175, r13_175, false)
        if r4_175 == r10_175 then
          if getTacticsData("modes", string.lower(r11_175), "enable") == "false" then
            guiGridListSetItemColor(server_maps, r9_175 - 1, 1, 0, 128, 0)
          else
            guiGridListSetItemColor(server_maps, r9_175 - 1, 1, 0, 255, 0)
          end
          if r0_175[r10_175] then
            guiGridListSetItemColor(server_maps, r9_175 - 1, 2, 0, 128, 0)
          else
            guiGridListSetItemColor(server_maps, r9_175 - 1, 2, 0, 255, 0)
          end
        else
          if getTacticsData("modes", string.lower(r11_175), "enable") == "false" then
            guiGridListSetItemColor(server_maps, r9_175 - 1, 1, 128, 128, 128)
          else
            guiGridListSetItemColor(server_maps, r9_175 - 1, 1, 255, 255, 255)
          end
          if r0_175[r10_175] then
            guiGridListSetItemColor(server_maps, r9_175 - 1, 2, 128, 128, 128)
          else
            guiGridListSetItemColor(server_maps, r9_175 - 1, 2, 255, 255, 255)
          end
        end
      else
        guiGridListRemoveRow(server_maps, #r2_175)
      end
    end
  end
  function onClientTacticsChange(r0_178, r1_178)
    -- line: [4123, 4235] id: 178
    if r0_178[1] == "version" then
      if not isElement(admin_window) then
        return 
      end
      guiSetText(admin_window, "Tactics " .. getTacticsData("version") .. " - Gamemode Control Panel")
    end
    if r0_178[1] == "ResourceCurrent" and isElement(server_cycler) then
      if not isElement(admin_window) then
        return 
      end
      for r5_178 = 0, guiGridListGetRowCount(server_cycler), 1 do
        if getTacticsData("ResourceCurrent") == r5_178 + 1 then
          guiGridListSetItemColor(server_cycler, r5_178, 1, 255, 40, 0)
          guiGridListSetItemColor(server_cycler, r5_178, 2, 255, 40, 0)
          guiGridListSetItemColor(server_cycler, r5_178, 3, 255, 40, 0)
        else
          guiGridListSetItemColor(server_cycler, r5_178, 1, 255, 255, 255)
          guiGridListSetItemColor(server_cycler, r5_178, 2, 255, 255, 255)
          guiGridListSetItemColor(server_cycler, r5_178, 3, 255, 255, 255)
        end
      end
    end
    if r0_178[1] == "Resources" then
      refreshCyclerResources()
    end
    if r0_178[1] == "automatics" then
      if not isElement(admin_window) then
        return 
      end
      local r2_178 = ({
        lobby = "Lobby",
        cycler = "Cycle",
        voting = "Voting",
        random = "Random",
      })[getTacticsData("automatics")]
      if r2_178 then
        guiSetText(cycler_automatics, r2_178)
      end
    end
    if r0_178[1] == "disabled_vehicles" then
      refreshVehicleConfig()
    end
    if r0_178[1] == "modes" or r0_178[1] == "settings" or r0_178[1] == "glitches" or r0_178[1] == "cheats" or r0_178[1] == "limites" then
      refreshSettingsConfig()
    end
    if r0_178[1] == "weaponspack" or r0_178[1] == "weapon_balance" or r0_178[1] == "weapon_slot" then
      remakeAdminWeaponsPack()
    end
    if r0_178[1] == "weapon_slots" then
      if not isElement(admin_window) then
        return 
      end
      guiSetText(weapons_slots, tostring(getTacticsData("weapon_slots")) or "0")
    end
    if r0_178[1] == "Weather" then
      refreshWeatherConfig()
    end
    if r0_178[1] == "settings" then
      if r0_178[2] == "dontfire" then
        local r2_178 = getTacticsData("settings", "dontfire")
        if r2_178 == "true" then
          bindKey("fire", "down", dontfireKey)
          bindKey("aim_weapon", "down", dontfireKey)
          addEventHandler("onClientPlayerDamage", localPlayer, dontfireDamage)
        elseif r2_178 == "false" then
          unbindKey("fire", "down", dontfireKey)
          unbindKey("aim_weapon", "down", dontfireKey)
          removeEventHandler("onClientPlayerDamage", localPlayer, dontfireDamage)
        end
      end
      if r0_178[2] == "streetlamps" then
        local r2_178 = {
          1211,
          1214,
          1215,
          1223,
          1226,
          1231,
          1232,
          1257,
          1258,
          1269,
          1270,
          1278,
          1283,
          1284,
          1285,
          1286,
          1287,
          1288,
          1289,
          1290,
          1291,
          1292,
          1293,
          1294,
          1295,
          1296,
          1297,
          1298,
          1306,
          1307,
          1308,
          1315,
          1319,
          1350,
          1351,
          1352,
          1363,
          1366,
          1367,
          1478,
          1568,
          3398,
          3407,
          3408,
          3447,
          3459,
          3460,
          3463,
          3516,
          3853,
          3854,
          3855,
          3875
        }
        if getTacticsData("settings", "streetlamps") == "true" then
          for r6_178, r7_178 in ipairs(r2_178) do
            restoreWorldModel(r7_178, 10000, 0, 0, 0)
          end
        else
          for r6_178, r7_178 in ipairs(r2_178) do
            removeWorldModel(r7_178, 10000, 0, 0, 0)
          end
        end
      end
    end
    if r0_178[1] == "anticheat" then
      if not isElement(admin_window) then
        return 
      end
      if r0_178[2] == "action_detection" then
        guiSetText(anticheat_action, ({
          chat = "Chat message",
          adminchat = "Adminchat message",
          kick = "Kick",
        })[getTacticsData("anticheat", "action_detection")])
      end
      if r0_178[2] == "speedhach" then
        if getTacticsData("anticheat", "speedhach") == "true" then
          guiSetText(anticheat_speedhack, "Enable")
        elseif new == "false" then
          guiSetText(anticheat_speedhack, "Disable")
        end
      end
      if r0_178[2] == "godmode" then
        if getTacticsData("anticheat", "godmode") == "true" then
          guiSetText(anticheat_godmode, "Enable")
        elseif new == "false" then
          guiSetText(anticheat_godmode, "Disable")
        end
      end
      if r0_178[2] == "mods" then
        if getTacticsData("anticheat", "mods") == "true" then
          guiSetText(anticheat_mods, "Enable")
        elseif new == "false" then
          guiSetText(anticheat_mods, "Disable")
        end
      end
      if r0_178[2] == "modslist" then
        refreshAnticheatSearch()
      end
    end
    if r0_178[1] == "handlings" then
      if not isElement(admin_window) then
        return 
      end
      local r2_178 = getTacticsData("handlings")
      local r3_178 = getVehicleModelFromName(guiGetText(handling_model))
      if not r2_178[r3_178] then
        if (r1_178 or {})[r3_178] then
          ::label_437::
          triggerEvent("onClientGUIComboBoxAccepted", handling_model)
        end
      else
        goto label_437	-- block#84 is visited secondly
      end
    end
    if r0_178[1] == "map_disabled" or r0_178[1] == "modes" and r0_178[3] == "enable" then
      updateAdminMaps()
    end
  end
  function dontfireKey(r0_179, r1_179)
    -- line: [4236, 4241] id: 179
    if isPedInWater(localPlayer) then
      return 
    end
    local r2_179 = getPedWeapon(localPlayer)
    if r2_179 == 43 or r2_179 == 44 or r2_179 == 45 or r2_179 == 46 then
      return 
    end
    setControlState(r0_179, false)
  end
  function dontfireDamage()
    -- line: [4242, 4244] id: 180
    cancelEvent()
  end
  function togglePause(r0_181, r1_181)
    -- line: [4245, 4247] id: 181
    triggerServerEvent("onPause", root, r1_181, localPlayer)
  end
  function forcePlay()
    -- line: [4248, 4250] id: 182
    triggerServerEvent("onPlay", root, localPlayer)
  end
  function remakeAdminWeaponsPack()
    -- line: [4251, 4348] id: 183
    if not isElement(admin_window) then
      return 
    end
    local r0_183 = getTacticsData("weaponspack") or {}
    local r1_183 = getTacticsData("weapon_balance") or {}
    if not getTacticsData("weapon_cost") then
      local r2_183 = {}
    end
    local r3_183 = {}
    for r7_183 in pairs(r0_183) do
      if r7_183 ~= nil then
        table.insert(r3_183, r7_183)
      end
    end
    local r4_183 = {
      [2] = 1,
      [3] = 2,
      [4] = 2,
      [5] = 3,
      [6] = 3,
    }
    table.sort(r3_183, function(r0_184, r1_184)
      -- line: [4259, 4267] id: 184
      local r2_184 = convertWeaponNamesToID[r0_184] or 46
      local r3_184 = convertWeaponNamesToID[r1_184] or 46
      local r4_184 = getSlotFromWeapon(r2_184)
      local r5_184 = getSlotFromWeapon(r3_184)
      local r6_184 = r4_183[r4_184] or 4
      local r7_184 = r4_183[r5_184] or 4
      local r8_184 = nil	-- notice: implicit variable refs by block#[13]
      if r6_184 ~= r7_184 or r2_184 >= r3_184 then
        r8_184 = r6_184 < r7_184
      else
        goto label_33	-- block#12 is visited secondly
      end
      return r8_184
    end)
    local r5_183 = 0
    local r6_183 = 0
    for r10_183 = 1, math.max(#weapons_items, #r3_183), 1 do
      if r10_183 <= #r3_183 then
        local r11_183 = r3_183[r10_183]
        local r12_183 = 0
        local r13_183 = convertWeaponNamesToID[r11_183] or 16
        if 16 <= r13_183 and r13_183 <= 18 or 22 <= r13_183 and r13_183 <= 39 or 41 <= r13_183 and r13_183 <= 43 then
          r12_183 = tonumber(getWeaponProperty(r13_183, "pro", "maximum_clip_ammo")) or 1
        end
        local r14_183 = math.max(0, math.floor(tonumber(r0_183[r11_183]) - r12_183))
        local r17_183 = tonumber(r0_183[r11_183])
        r14_183 = r14_183 .. "-" .. math.min(r17_183, r12_183)
        if #weapons_items < r10_183 then
          local r15_183 = guiCreateButton(r5_183, r6_183, 64, 84, "", false, weapons_scroller)
          local r16_183 = guiCreateStaticImage(2, 5, 60, 64, "images/hud/fist.png", false, r15_183)
          guiSetEnabled(r16_183, false)
          r17_183 = guiCreateLabel
          local r18_183 = 1
          local r19_183 = 60
          local r20_183 = 62
          local r21_183 = 20
          local r22_183 = nil	-- notice: implicit variable refs by block#[30]
          if r12_183 > 1 then
            r22_183 = r14_183
            if r22_183 then
              ::label_148::
              if r12_183 == 1 then
                r22_183 = r0_183[r11_183]
                if not r22_183 then
                  ::label_153::
                  r22_183 = ""
                end
              else
                goto label_153	-- block#29 is visited secondly
              end
            end
          else
            goto label_148	-- block#27 is visited secondly
          end
          r17_183 = r17_183(r18_183, r19_183, r20_183, r21_183, r22_183, false, r15_183)
          guiLabelSetHorizontalAlign(r17_183, "center", false)
          guiLabelSetVerticalAlign(r17_183, "center")
          guiSetEnabled(r17_183, false)
          r18_183 = guiCreateLabel(1, 5, 62, 20, r11_183, false, r15_183)
          guiSetFont(r18_183, "default-small")
          guiSetEnabled(r18_183, false)
          r19_183 = guiCreateLabel
          r20_183 = 1
          r21_183 = 5
          r22_183 = 62
          local r23_183 = 20
          local r24_183 = r1_183[r11_183]
          if r24_183 then
            r24_183 = "x" .. r1_183[r11_183] or ""
          else
            goto label_200	-- block#32 is visited secondly
          end
          r19_183 = r19_183(r20_183, r21_183, r22_183, r23_183, r24_183, false, r15_183)
          guiLabelSetHorizontalAlign(r19_183, "right", false)
          guiLabelSetColor(r19_183, 255, 0, 0)
          guiSetEnabled(r19_183, false)
          r22_183 = {
            gui = r15_183,
            icon = r16_183,
            name = r18_183,
            ammo = r17_183,
            limit = r19_183,
          }
          table.insert(weapons_items, r22_183)
        else
          guiSetPosition(weapons_items[r10_183].gui, r5_183, r6_183, false)
          local r15_183 = guiSetText
          local r16_183 = weapons_items[r10_183].ammo
          if r12_183 > 1 then
            r17_183 = r14_183
            if r17_183 then
              ::label_246::
              if r12_183 == 1 then
                r17_183 = r0_183[r11_183] or ""
              else
                goto label_251	-- block#38 is visited secondly
              end
            end
          else
            goto label_246	-- block#36 is visited secondly
          end
          r15_183(r16_183, r17_183)
          guiSetText(weapons_items[r10_183].name, r11_183)
          r15_183 = guiSetText
          r16_183 = weapons_items[r10_183].limit
          r17_183 = r1_183[r11_183]
          if r17_183 then
            r17_183 = "x" .. r1_183[r11_183] or ""
          else
            goto label_271	-- block#41 is visited secondly
          end
          r15_183(r16_183, r17_183)
        end
        if fileExists("images/hud/" .. r11_183 .. ".png") then
          guiStaticImageLoadImage(weapons_items[r10_183].icon, "images/hud/" .. r11_183 .. ".png")
        else
          guiStaticImageLoadImage(weapons_items[r10_183].icon, "images/hud/fist.png")
        end
        guiSetProperty(weapons_items[r10_183].gui, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
        r5_183 = r5_183 + 66
        if r5_183 > 198 then
          r5_183 = 0
          r6_183 = r6_183 + 86
        end
      else
        destroyElement(weapons_items[r10_183].gui)
        weapons_items[r10_183] = nil
      end
    end
    local r7_183 = 0
    local r8_183 = {}
    local r9_183 = getTacticsData("weapon_slot") or {}
    for r13_183, r14_183 in ipairs(weapons_items) do
      local r15_183 = guiGetText(r14_183.name)
      local r16_183 = convertWeaponNamesToID[r15_183]
      local r17_183 = tonumber(r9_183[r15_183])
      if not r17_183 then
        if r16_183 then
          r17_183 = getSlotFromWeapon(r16_183) or 13
        else
          goto label_347	-- block#56 is visited secondly
        end
      end
      if not r8_183[r17_183] then
        r7_183 = r7_183 + 1
        r8_183[r17_183] = r7_183
      end
    end
    for r13_183, r14_183 in ipairs(weapons_items) do
      local r15_183 = guiGetText(r14_183.name)
      local r16_183 = convertWeaponNamesToID[r15_183]
      local r17_183 = tonumber(r9_183[r15_183])
      if not r17_183 then
        if r16_183 then
          r17_183 = getSlotFromWeapon(r16_183) or 13
        else
          goto label_376	-- block#64 is visited secondly
        end
      end
      local r18_183 = string.format("%02X%02X%02X", HSLtoRGB(360 * r8_183[r17_183] / r7_183, 0.5, 0.5))
      guiSetProperty(r14_183.icon, "ImageColours", "tl:FF" .. r18_183 .. " tr:FF" .. r18_183 .. " bl:FF" .. r18_183 .. " br:FF" .. r18_183 .. "")
    end
    guiSetPosition(weapons_adding, r5_183, r6_183 + 10, false)
    guiComboBoxClear(weapons_addnames)
    for r13_183, r14_183 in ipairs(sortWeaponNames) do
      if not r0_183[r14_183] then
        guiComboBoxAddItem(weapons_addnames, r14_183)
      end
    end
  end
  function toRestoreChoise(r0_185)
    -- line: [4349, 4357] id: 185
    if not isElement(restore_window) then
      createAdminRestore()
    end
    restore_player = r0_185
    guiSetText(restore_window, "Restore " .. getPlayerName(r0_185))
    refreshRestores()
    guiBringToFront(restore_window)
    guiSetVisible(restore_window, true)
    showCursor(true)
  end
  function RGBtoHSL(r0_186, r1_186, r2_186)
    -- line: [4358, 4373] id: 186
    local r3_186 = r0_186 / 255
    local r4_186 = r1_186 / 255
    local r5_186 = r2_186 / 255
    local r6_186 = math.max(r3_186, r4_186, r5_186)
    local r7_186 = math.min(r3_186, r4_186, r5_186)
    local r8_186 = nil	-- notice: implicit variable refs by block#[24]
    if r6_186 == r7_186 then
      r8_186 = 0
      if not r8_186 then
        ::label_20::
        if r6_186 == r3_186 and r5_186 <= r4_186 then
          r8_186 = 60 * (r4_186 - r5_186) / (r6_186 - r7_186)
          if not r8_186 then
            ::label_30::
            if r6_186 == r3_186 and r4_186 < r5_186 then
              r8_186 = 60 * (r4_186 - r5_186) / (r6_186 - r7_186) + 360
              if not r8_186 then
                ::label_41::
                if r6_186 == r4_186 then
                  r8_186 = 60 * (r5_186 - r3_186) / (r6_186 - r7_186) + 120
                  if not r8_186 then
                    ::label_50::
                    if r6_186 == r5_186 then
                      r8_186 = 60 * (r3_186 - r4_186) / (r6_186 - r7_186) + 240
                      if not r8_186 then
                        ::label_59::
                        r8_186 = 360
                      end
                    else
                      goto label_59	-- block#12 is visited secondly
                    end
                  end
                else
                  goto label_50	-- block#10 is visited secondly
                end
              end
            else
              goto label_41	-- block#8 is visited secondly
            end
          end
        else
          goto label_30	-- block#5 is visited secondly
        end
      end
    else
      goto label_20	-- block#2 is visited secondly
    end
    local r9_186 = 0.5 * (r6_186 + r7_186)
    local r10_186 = nil	-- notice: implicit variable refs by block#[24]
    if r9_186 == 0 then
      r10_186 = 0
      if not r10_186 then
        ::label_67::
        if r6_186 == r7_186 then
          r10_186 = 0
          if not r10_186 then
            ::label_72::
            if 0 < r9_186 and r9_186 <= 0.5 then
              r10_186 = (r6_186 - r7_186) / 2 * r9_186
              if not r10_186 then
                ::label_81::
                if 0.5 < r9_186 and r9_186 < 1 then
                  r10_186 = (r6_186 - r7_186) / (2 - 2 * r9_186)
                  if not r10_186 then
                    ::label_91::
                    r10_186 = 1
                  end
                else
                  goto label_91	-- block#23 is visited secondly
                end
              end
            else
              goto label_81	-- block#20 is visited secondly
            end
          end
        else
          goto label_72	-- block#17 is visited secondly
        end
      end
    else
      goto label_67	-- block#15 is visited secondly
    end
    return r8_186, r10_186, r9_186
  end
  function HSLtoRGB(r0_187, r1_187, r2_187)
    -- line: [4374, 4398] id: 187
    local r3_187 = nil	-- notice: implicit variable refs by block#[3, 16, 19, 22, 25, 28, 31, 34, 37, 40]
    if r2_187 < 0.5 then
      r3_187 = r2_187 * (1 + r1_187)
      if not r3_187 then
        ::label_6::
        r3_187 = r2_187 + r1_187 - r2_187 * r1_187
      end
    else
      goto label_6	-- block#2 is visited secondly
    end
    local r4_187 = 2 * r2_187 - r3_187
    local r5_187 = r0_187 / 360
    local r6_187 = r5_187 + 0.3333333333333333
    local r7_187 = r5_187
    local r8_187 = r5_187 - 0.3333333333333333
    if r6_187 < 0 then
      r6_187 = r6_187 + 1
    end
    if r7_187 < 0 then
      r7_187 = r7_187 + 1
    end
    if r8_187 < 0 then
      r8_187 = r8_187 + 1
    end
    if r6_187 > 1 then
      r6_187 = r6_187 - 1
    end
    if r7_187 > 1 then
      r7_187 = r7_187 - 1
    end
    if r8_187 > 1 then
      r8_187 = r8_187 - 1
    end
    local r9_187 = nil	-- notice: implicit variable refs by block#[42]
    local r10_187 = nil	-- notice: implicit variable refs by block#[42]
    if r6_187 < 0.16666666666666666 then
      r9_187 = r4_187 + (r3_187 - r4_187) * 6 * r6_187
      if not r9_187 then
        ::label_41::
        if 0.16666666666666666 <= r6_187 and r6_187 < 0.5 then
          r9_187 = r3_187
          if r9_187 then
            ::label_47::
            if 0.5 <= r6_187 and r6_187 < 0.6666666666666666 then
              r10_187 = 0.6666666666666666 - r6_187
              r9_187 = r4_187 + (r3_187 - r4_187) * r10_187 * 6
              if not r9_187 then
                ::label_58::
                r9_187 = r4_187
              end
            else
              goto label_58	-- block#23 is visited secondly
            end
          end
        else
          goto label_47	-- block#20 is visited secondly
        end
      end
    else
      goto label_41	-- block#17 is visited secondly
    end
    local r11_187 = nil	-- notice: implicit variable refs by block#[42]
    if r7_187 < 0.16666666666666666 then
      r10_187 = r4_187 + (r3_187 - r4_187) * 6 * r7_187
      if not r10_187 then
        ::label_67::
        if 0.16666666666666666 <= r7_187 and r7_187 < 0.5 then
          r10_187 = r3_187
          if r10_187 then
            ::label_73::
            if 0.5 <= r7_187 and r7_187 < 0.6666666666666666 then
              r11_187 = 0.6666666666666666 - r7_187
              r10_187 = r4_187 + (r3_187 - r4_187) * r11_187 * 6
              if not r10_187 then
                ::label_84::
                r10_187 = r4_187
              end
            else
              goto label_84	-- block#32 is visited secondly
            end
          end
        else
          goto label_73	-- block#29 is visited secondly
        end
      end
    else
      goto label_67	-- block#26 is visited secondly
    end
    if r8_187 < 0.16666666666666666 then
      r11_187 = r4_187 + (r3_187 - r4_187) * 6 * r8_187
      if not r11_187 then
        ::label_93::
        if 0.16666666666666666 <= r8_187 and r8_187 < 0.5 then
          r11_187 = r3_187
          if r11_187 then
            ::label_99::
            if 0.5 <= r8_187 and r8_187 < 0.6666666666666666 then
              r11_187 = r4_187 + (r3_187 - r4_187) * (0.6666666666666666 - r8_187) * 6
              if not r11_187 then
                ::label_110::
                r11_187 = r4_187
              end
            else
              goto label_110	-- block#41 is visited secondly
            end
          end
        else
          goto label_99	-- block#38 is visited secondly
        end
      end
    else
      goto label_93	-- block#35 is visited secondly
    end
    local r12_187 = math.floor(255 * r9_187)
    local r13_187 = math.floor(255 * r10_187)
    r11_187 = math.floor(255 * r11_187)
    r10_187 = r13_187
    r9_187 = r12_187
    return r9_187, r10_187, r11_187
  end
  function executeRuncode(r0_188, r1_188, ...)
    -- line: [4399, 4408] id: 188
    local r3_188 = table.concat({
      ...
    }, " ")
    if not r1_188 or not getPlayerFromName(r1_188) then
      r3_188 = r1_188 .. " " .. r3_188
      r1_188 = localPlayer
    else
      r1_188 = getPlayerFromName(r1_188)
    end
    callServerFunction("executeClientRuncode", localPlayer, r1_188, r3_188)
  end
  function stopRuncode(r0_189, r1_189)
    -- line: [4409, 4416] id: 189
    if not r1_189 or not getPlayerFromName(r1_189) then
      r1_189 = localPlayer
    else
      r1_189 = getPlayerFromName(r1_189)
    end
    callServerFunction("stopClientRuncode", localPlayer, r1_189)
  end
  local r5_130 = {}
  local r6_130 = {}
  local r7_130 = {}
  local r8_130 = {}
  local r9_130 = {}
  function createAddEventHandlerFunction(r0_190)
    -- line: [4422, 4435] id: 190
    return function(r0_191, r1_191, r2_191, r3_191)
      -- line: [4423, 4434] id: 191
      if type(r0_191) == "string" and isElement(r1_191) and type(r2_191) == "function" then
        if r3_191 == nil or type(r3_191) ~= "boolean" then
          r3_191 = true
        end
        if addEventHandler(r0_191, r1_191, r2_191, r3_191) then
          table.insert(r6_130[r0_190], {
            r0_191,
            r1_191,
            r2_191
          })
          return true
        end
      end
      return false
    end
  end
  function createBindKeyFunction(r0_192)
    -- line: [4436, 4453] id: 192
    return function(...)
      -- line: [4437, 4452] id: 193
      local r1_193 = {
        ...
      }
      local r2_193 = table.remove(r1_193, 1)
      local r3_193 = table.remove(r1_193, 1)
      local r4_193 = table.remove(r1_193, 1)
      local r5_193 = r1_193
      if type(r2_193) ~= "string" or type(r3_193) ~= "string" or type(r4_193) ~= "string" and type(r4_193) ~= "function" then
        return false
      end
      r1_193 = {
        r2_193,
        r3_193,
        r4_193,
        unpack(r5_193)
      }
      if bindKey(unpack(r1_193)) then
        table.insert(r7_130[r0_192], r1_193)
        return true
      end
      return false
    end
  end
  function createAddCommandHandlerFunction(r0_194)
    -- line: [4454, 4471] id: 194
    return function(r0_195, r1_195, r2_195, r3_195)
      -- line: [4455, 4470] id: 195
      if type(r0_195) == "string" and type(r1_195) == "function" then
        local r4_195 = nil
        if type(r2_195) == "boolean" then
          r3_195 = r2_195
        else
          r3_195 = true
        end
        r4_195 = {
          r0_195,
          r1_195,
          r3_195
        }
        if addCommandHandler(unpack(r4_195)) then
          table.insert(r8_130[r0_194], r4_195)
          return true
        end
      end
      return false
    end
  end
  function createSetTimerFunction(r0_196)
    -- line: [4472, 4483] id: 196
    return function(r0_197, r1_197, r2_197, ...)
      -- line: [4473, 4482] id: 197
      if type(r0_197) == "function" and type(r1_197) == "number" and type(r2_197) == "number" then
        local r4_197 = setTimer(r0_197, r1_197, r2_197, ...)
        if r4_197 then
          table.insert(r9_130[r0_196], r4_197)
          return r4_197
        end
      end
      return false
    end
  end
  function createRemoveEventHandlerFunction(r0_198)
    -- line: [4484, 4498] id: 198
    return function(r0_199, r1_199, r2_199)
      -- line: [4485, 4497] id: 199
      if type(r0_199) == "string" and isElement(r1_199) and type(r2_199) == "function" then
        for r6_199, r7_199 in ipairs(r6_130[r0_198]) do
          if r7_199[1] == r0_199 and r7_199[2] == r1_199 and r7_199[3] == r2_199 and removeEventHandler(unpack(r7_199)) then
            table.remove(r6_130[r0_198], r6_199)
            return true
          end
        end
      end
      return false
    end
  end
  function createUnbindKeyFunction(r0_200)
    -- line: [4499, 4522] id: 200
    return function(...)
      -- line: [4500, 4521] id: 201
      local r1_201 = {
        ...
      }
      local r2_201 = table.remove(r1_201, 1)
      local r3_201 = table.remove(r1_201, 1)
      local r4_201 = table.remove(r1_201, 1)
      if type(r2_201) ~= "string" then
        return false
      end
      if type(r3_201) ~= "string" or not r3_201 then
        r3_201 = nil
      end
      if type(r4_201) ~= "string" and type(r4_201) ~= "function" or not r4_201 then
        r4_201 = nil
      end
      r1_201 = {
        r2_201,
        r3_201,
        r4_201
      }
      local r5_201 = false
      for r9_201, r10_201 in ipairs(r7_130[r0_200]) do
        if r10_201[1] == r1_201[1] and (not r1_201[2] or r1_201[2] == r10_201[2]) and (not r1_201[3] or r1_201[3] == r10_201[3]) and unbindKey(unpack(r10_201)) then
          table.remove(r7_130[r0_200], r9_201)
          r5_201 = true
        end
      end
      return r5_201
    end
  end
  function createRemoveCommandHandlerFunction(r0_202)
    -- line: [4523, 4538] id: 202
    return function(r0_203, r1_203)
      -- line: [4524, 4537] id: 203
      local r2_203 = false
      if type(r0_203) == "string" and type(r1_203) == "function" then
        for r6_203, r7_203 in ipairs(r8_130[r0_202]) do
          if r7_203[1] == r0_203 and (not r7_203[2] or r7_203[2] == r1_203) and removeCommandHandler(unpack(r7_203)) then
            table.remove(r8_130[r0_202], r6_203)
            r2_203 = true
          end
        end
      end
      return r2_203
    end
  end
  function createKillTimerFunction(r0_204)
    -- line: [4539, 4552] id: 204
    return function(r0_205)
      -- line: [4540, 4551] id: 205
      local r1_205 = false
      for r5_205, r6_205 in ipairs(r9_130[r0_204]) do
        if r6_205 == r0_205 and killTimer(r0_205) then
          table.remove(r9_130[r0_204], r5_205)
          r1_205 = true
        end
      end
      return r1_205
    end
  end
  function cleanEventHandlerContainer(r0_206)
    -- line: [4553, 4561] id: 206
    if not r6_130[r0_206] then
      return 
    end
    for r4_206, r5_206 in ipairs(r6_130[r0_206]) do
      if isElement(r5_206[2]) then
        removeEventHandler(unpack(r5_206))
      end
    end
    r6_130[r0_206] = nil
  end
  function cleanKeyBindContainer(r0_207)
    -- line: [4562, 4568] id: 207
    if not r7_130[r0_207] then
      return 
    end
    for r4_207, r5_207 in ipairs(r7_130[r0_207]) do
      unbindKey(unpack(r5_207))
    end
    r7_130[r0_207] = nil
  end
  function cleanCommandHandlerContainer(r0_208)
    -- line: [4569, 4575] id: 208
    if not r8_130[r0_208] then
      return 
    end
    for r4_208, r5_208 in ipairs(r8_130[r0_208]) do
      removeCommandHandler(unpack(r5_208))
    end
    r8_130[r0_208] = nil
  end
  function cleanTimerContainer(r0_209)
    -- line: [4576, 4582] id: 209
    if not r9_130[r0_209] then
      return 
    end
    for r4_209, r5_209 in ipairs(r9_130[r0_209]) do
      if isTimer(r5_209) then
        killTimer(r5_209)
      end
    end
    r9_130[r0_209] = nil
  end
  function stopClientRuncode(r0_210)
    -- line: [4583, 4594] id: 210
    if not r5_130[r0_210] then
      callServerFunction("outputChatBox", "Not running!", r0_210, 0, 128, 0, true)
      return 
    end
    cleanEventHandlerContainer(r0_210)
    cleanKeyBindContainer(r0_210)
    cleanCommandHandlerContainer(r0_210)
    cleanTimerContainer(r0_210)
    r5_130[r0_210] = nil
    callServerFunction("outputChatBox", "Stopped!", r0_210, 0, 128, 0, true)
  end
  function executeClientRuncode(r0_211, r1_211)
    -- line: [4595, 4671] id: 211
    if not r6_130[r0_211] then
      r6_130[r0_211] = {}
    end
    if not r7_130[r0_211] then
      r7_130[r0_211] = {}
    end
    if not r8_130[r0_211] then
      r8_130[r0_211] = {}
    end
    if not r9_130[r0_211] then
      r9_130[r0_211] = {}
    end
    if not r5_130[r0_211] then
      r5_130[r0_211] = {
        addEventHandler = createAddEventHandlerFunction(r0_211),
        removeEventHandler = createRemoveEventHandlerFunction(r0_211),
        bindKey = createBindKeyFunction(r0_211),
        unbindKey = createUnbindKeyFunction(r0_211),
        addCommandHandler = createAddCommandHandlerFunction(r0_211),
        removeCommandHandler = createRemoveCommandHandlerFunction(r0_211),
        setTimer = createSetTimerFunction(r0_211),
        killTimer = createKillTimerFunction(r0_211),
      }
      setmetatable(r5_130[r0_211], {
        __index = _G,
      })
    end
    local r2_211 = false
    local r3_211, r4_211 = loadstring("return " .. r1_211)
    if r4_211 then
      r2_211 = true
      r3_211, r4_211 = loadstring(tostring(r1_211))
    end
    if r4_211 then
      callServerFunction("outputChatBox", "ERROR: " .. r4_211, r0_211, 255, 0, 0, true)
      return 
    end
    local r5_211 = {
      pcall(setfenv(r3_211, r5_130[r0_211]))
    }
    if not r5_211[1] then
      callServerFunction("outputChatBox", "ERROR: " .. r5_211[2], r0_211, 255, 0, 0, true)
      return 
    end
    if not r2_211 then
      local r6_211 = ""
      for r10_211 = 2, #r5_211, 1 do
        local r11_211 = ""
        if r10_211 > 2 then
          r6_211 = r6_211 .. "#00FF00, "
        end
        local r12_211 = r5_211[r10_211]
        if type(r12_211) == "table" then
          for r16_211, r17_211 in pairs(r12_211) do
            if #r11_211 > 0 then
              r11_211 = r11_211 .. ", "
            end
            if type(r16_211) == "userdata" then
              if isElement(r16_211) then
                r11_211 = r11_211 .. "#66CC66" .. getElementType(r12_211) .. "#B1B100"
              else
                r11_211 = r11_211 .. "#66CC66element#B1B100"
              end
            elseif type(r16_211) == "string" then
              r11_211 = r11_211 .. "#FF0000\"" .. r16_211 .. "\"#B1B100"
            else
              r11_211 = r11_211 .. "#000099" .. tostring(r16_211) .. "#B1B100"
            end
          end
          r11_211 = "#B1B100{" .. r11_211 .. "}"
        elseif type(r12_211) == "userdata" then
          if isElement(r12_211) then
            r11_211 = "#66CC66" .. getElementType(r12_211) .. string.gsub(tostring(r12_211), "userdata:", "")
          else
            r11_211 = "#66CC66element" .. string.gsub(tostring(r12_211), "userdata:", "")
          end
        elseif type(r12_211) == "string" then
          r11_211 = "#FF0000\"" .. r12_211 .. "\""
        elseif type(r12_211) == "function" then
          r11_211 = "#0000FF" .. tostring(r12_211)
        elseif type(r12_211) == "thread" then
          r11_211 = "#808080" .. tostring(r12_211)
        else
          r11_211 = "#000099" .. tostring(r12_211)
        end
        r6_211 = r6_211 .. r11_211
      end
      callServerFunction("outputChatBox", string.sub("Return: " .. r6_211, 1, 128), r0_211, 0, 255, 0, true)
    elseif not r4_211 then
      callServerFunction("outputChatBox", "Executed!", r0_211, 0, 128, 0, true)
    end
  end
  addEvent("onExecuteClientRuncode", true)
  addEventHandler("onExecuteClientRuncode", root, executeClientRuncode)
  local r10_130 = nil
  function takeDisabledScreenShot(r0_212)
    -- line: [4675, 4681] id: 212
    local r1_212, r2_212, r3_212 = unpack(split(r0_212, " "))
    r10_130 = dxCreateScreenSource(tonumber(r2_212), tonumber(r3_212))
    if not r10_130 then
      return 
    end
    setElementData(r10_130, "ScreenData", r0_212, false)
    addEventHandler("onClientRender", root, onClientRenderDisabledScreenShot)
  end
  function onClientRenderDisabledScreenShot()
    -- line: [4682, 4695] id: 213
    dxUpdateScreenSource(r10_130)
    local r0_213 = dxGetTexturePixels(r10_130)
    if r0_213 then
      outputDebugString("1 = " .. #r0_213)
      local r1_213 = getElementData(r10_130, "ScreenData")
      local r2_213, r3_213, r4_213, r5_213 = unpack(split(r1_213, " "))
      triggerLatentServerEvent("onPlayerDisabledScreenShot", localPlayer, "disabled", "ok", dxConvertPixels(r0_213, "jpeg", tonumber(r5_213)), getRealTime().timestamp, r1_213)
    end
    destroyElement(r10_130)
    r10_130 = nil
    removeEventHandler("onClientRender", root, onClientRenderDisabledScreenShot)
  end
  function onClientPlayerScreenShot(r0_214, r1_214, r2_214, r3_214, r4_214)
    -- line: [4696, 4735] id: 214
    if isTimer(screenTimeout) then
      killTimer(screenTimeout)
    end
    if isElement(admin_window) then
      guiSetEnabled(player_takescreen, true)
      guiSetEnabled(player_takescreencombobox, true)
    end
    if r0_214 == "disabled" then
      outputLangString("screen_disabled")
      return 
    end
    if r0_214 == "minimized" then
      outputLangString("screen_minimized")
      return 
    end
    local r5_214 = fileCreate("screenshots/_screen.jpg")
    if not r5_214 then
      return 
    end
    fileWrite(r5_214, r1_214)
    fileClose(r5_214)
    local r6_214 = r2_214 + 20
    local r7_214 = r3_214 + 53
    if xscreen < r2_214 + 20 then
      r7_214 = xscreen * 0.75 + 15
      r6_214 = xscreen
    end
    if yscreen < r3_214 + 53 then
      r7_214 = yscreen
      r6_214 = yscreen / 0.75 - 15
    end
    if not isElement(screen_window) then
      createAdminScreen()
    end
    guiBringToFront(screen_window)
    guiSetPosition(screen_window, xscreen * 0.5 - r6_214 * 0.5, yscreen * 0.5 - r7_214 * 0.5, false)
    guiSetSize(screen_window, r6_214, r7_214, false)
    guiSetSize(screen_image, r6_214 - 20, r7_214 - 53, false)
    guiStaticImageLoadImage(screen_image, "screenshots/_screen.jpg")
    guiSetAlpha(screen_menu, 0.2)
    guiSetText(screen_name, r4_214)
    guiSetVisible(screen_list, false)
    guiSetVisible(screen_name, true)
    guiSetVisible(screen_save, true)
    guiBringToFront(screen_window)
    guiSetVisible(screen_window, true)
    showCursor(true)
  end
  function loadScreenShot(r0_215)
    -- line: [4736, 4765] id: 215
    if not fileExists(("screenshots/" .. r0_215 .. ".jpg")) then
      return 
    end
    local r1_215 = ""
    local r2_215 = fileOpen("screenshots/" .. r0_215 .. ".jpg", true)
    while not fileIsEOF(r2_215) do
      local r3_215 = r1_215
      local r4_215 = fileRead(r2_215, 500)
      r1_215 = r3_215 .. r4_215
    end
    fileClose(r2_215)
    local r3_215, r4_215 = dxGetPixelsSize(r1_215)
    local r5_215 = r3_215 + 20
    local r6_215 = r4_215 + 35
    if xscreen < r3_215 + 20 then
      r6_215 = xscreen * 0.75 + 15
      r5_215 = xscreen
    end
    if yscreen < r4_215 + 35 then
      r6_215 = yscreen
      r5_215 = yscreen / 0.75 - 15
    end
    if not isElement(screen_window) then
      createAdminScreen()
    end
    guiSetPosition(screen_window, xscreen * 0.5 - r5_215 * 0.5, yscreen * 0.5 - r6_215 * 0.5, false)
    guiSetSize(screen_window, r5_215, r6_215, false)
    guiSetSize(screen_image, r5_215 - 20, r6_215 - 35, false)
    guiStaticImageLoadImage(screen_image, "screenshots/" .. r0_215 .. ".jpg")
    guiSetAlpha(screen_menu, 0.2)
    guiSetText(screen_name, r0_215)
    guiSetVisible(screen_name, false)
    guiSetVisible(screen_save, false)
    guiSetVisible(screen_list, true)
    guiBringToFront(screen_window)
    guiSetVisible(screen_window, true)
    setTimer(guiBringToFront, 50, 1, screen_window)
  end
  function onClientMouseEnter(r0_216, r1_216)
    -- line: [4766, 4773] id: 216
    if source == screen_image then
      guiSetAlpha(screen_menu, 0.2)
    end
    if source == screen_menu or source == screen_name or source == screen_save or source == screen_list then
      guiSetAlpha(screen_menu, 1)
    end
  end
  function onClientMouseLeave(r0_217, r1_217)
    -- line: [4774, 4778] id: 217
    if source == screen_image then
      guiSetAlpha(screen_menu, 1)
    end
  end
  function toggleGangDriveby()
    -- line: [4779, 4785] id: 218
    if getTacticsData("settings", "player_can_driveby") ~= "true" then
      return 
    end
    if getPedWeaponSlot(localPlayer) == 0 then
      switchGangDrivebyWeapon()
    end
    callServerFunction("toggleGangDriveby", localPlayer)
  end
  function switchGangDrivebyWeapon(r0_219)
    -- line: [4786, 4805] id: 219
    if getTacticsData("settings", "player_can_driveby") ~= "true" then
      return 
    end
    if not isPedDoingGangDriveby(localPlayer) and r0_219 then
      return 
    end
    local r1_219 = {}
    local r2_219 = {}
    local r3_219 = -1
    for r7_219 = 0, 12, 1 do
      if getPedWeapon(localPlayer, r7_219) > 0 then
        if r7_219 == getPedWeaponSlot(localPlayer) then
          r3_219 = #r2_219
        end
        table.insert(r2_219, r7_219)
      end
    end
    if #r2_219 < 1 then
      return 
    end
    if r0_219 == "vehicle_look_left" or not r0_219 then
      r3_219 = (r3_219 + 1) % #r2_219
    elseif r0_219 == "vehicle_look_right" then
      r3_219 = (r3_219 - 1) % #r2_219
    end
    setPedWeaponSlot(localPlayer, r2_219[r3_219 + 1])
  end
  function onClientVehicleExit(r0_220)
    -- line: [4806, 4810] id: 220
    if r0_220 == localPlayer and isPedDoingGangDriveby(localPlayer) then
      setPedDoingGangDriveby(localPlayer, false)
    end
  end
  function onClientPauseToggle(r0_221)
    -- line: [4811, 4820] id: 221
    if not isElement(admin_window) then
      return 
    end
    if not r0_221 then
      guiSetText(player_pause, "Pause")
      guiSetProperty(player_pause, "NormalTextColour", "C0FF8000")
    else
      guiSetText(player_pause, "Unpause")
      guiSetProperty(player_pause, "NormalTextColour", "C00080FF")
    end
  end
  function onClientMapStarting()
    -- line: [4821, 4827] id: 222
    updateAdminMaps()
    if isElement(admin_window) then
      guiSetText(player_pause, "Pause")
      guiSetProperty(player_pause, "NormalTextColour", "C0FF8000")
    end
  end
  addEvent("onClientMapsUpdate", true)
  addEvent("onPaletteSetColor")
  addEvent("onClientPlayerScreenShot", true)
  addEvent("takeDisabledScreenShot", true)
  addEventHandler("onClientResourceStart", resourceRoot, onClientResourceStart)
  addEventHandler("onClientGUIClick", root, onClientGUIClick)
  addEventHandler("onClientGUIChanged", root, onClientGUIChanged)
  addEventHandler("onClientGUIAccepted", root, onClientGUIAccepted)
  addEventHandler("onClientGUIScroll", root, onClientGUIScroll)
  addEventHandler("onClientGUIMouseUp", root, onClientGUIMouseUp)
  addEventHandler("onClientGUIMouseDown", root, onClientGUIMouseDown)
  addEventHandler("onClientGUIFocus", root, onClientGUIFocus)
  addEventHandler("onClientCursorMove", root, onClientCursorMove)
  addEventHandler("onClientGUIDoubleClick", root, onClientGUIDoubleClick)
  addEventHandler("onClientGUIComboBoxAccepted", root, onClientGUIComboBoxAccepted)
  addEventHandler("onClientGUITabSwitched", root, onClientGUITabSwitched)
  addEventHandler("onClientMouseEnter", root, onClientMouseEnter)
  addEventHandler("onClientMouseLeave", root, onClientMouseLeave)
  addEventHandler("onClientTacticsChange", root, onClientTacticsChange)
  addEventHandler("onClientMapsUpdate", root, onClientMapsUpdate)
  addEventHandler("onPaletteSetColor", root, onPaletteSetColor)
  addEventHandler("onClientPlayerScreenShot", root, onClientPlayerScreenShot)
  addEventHandler("takeDisabledScreenShot", root, takeDisabledScreenShot)
  addEventHandler("onClientMapStarting", root, onClientMapStarting)
  addEventHandler("onClientVehicleStartExit", root, onClientVehicleExit)
  addEventHandler("onClientVehicleExit", root, onClientVehicleExit)
  addEventHandler("onClientPauseToggle", root, onClientPauseToggle)
  addCommandHandler("play", forcePlay, false)
  addCommandHandler("pause", togglePause, false)
  addCommandHandler("control_panel", toggleAdmin, false)
  addCommandHandler("cexe", executeRuncode, false)
  addCommandHandler("cexestop", stopRuncode, false)
end)()
(function(...)
  -- line: [0, 0] id: 223
  local r0_223 = nil	-- notice: implicit variable refs by block#[0]
  local r1_223 = 0
  local r2_223 = {}
  local r3_223 = {
    hovercars = true,
    aircars = true,
    extrabunny = true,
    extrajump = true,
    knockoffbike = true,
  }
  function onClientTacticsChange(r0_224, r1_224)
    -- line: [10, 58] id: 224
    -- notice: unreachable block#5
    if r0_224[1] == "cheats" then
      local r2_224 = getTacticsData("cheats")
      if r3_223[r0_224[2]] then
        local r3_224 = setWorldSpecialPropertyEnabled
        local r4_224 = r0_224[2]
        local r5_224 = r2_224[r0_224[2]]
        if r5_224 == "true" then
          r5_224 = true
        else
          r5_224 = false
        end
        r3_224(r4_224, r5_224)
      end
      if r0_224[2] == "magnetcars" then
        if r2_224.magnetcars == "true" then
          addEventHandler("onClientPreRender", root, magnetcars_onClientPreRender)
          addEventHandler("onClientPlayerVehicleExit", localPlayer, magnetcars_onClientPlayerVehicleExit)
        else
          removeEventHandler("onClientPreRender", root, magnetcars_onClientPreRender)
          removeEventHandler("onClientPlayerVehicleExit", localPlayer, magnetcars_onClientPlayerVehicleExit)
          local r3_224 = getPedOccupiedVehicle(localPlayer)
          if r3_224 then
            setVehicleGravity(r3_224, 0, 0, -1)
          end
        end
      end
    end
    if r0_224[1] == "anticheat" then
      local r2_224 = getTacticsData("anticheat")
      if r0_224[2] == "speedhack" then
        if r2_224.speedhack == "true" then
          r1_223 = getRealTime().second
          r0_223 = setTimer(checkSH, 60000, 0)
        elseif isTimer(r0_223) then
          killTimer(r0_223)
        end
      end
      if r0_224[2] == "godmode" then
        if r2_224.godmode == "true" then
          addEventHandler("onClientPlayerWeaponFire", root, godmode_onClientPlayerWeaponFire)
          addEventHandler("onClientPlayerDamage", localPlayer, godmode_onClientPlayerDamage)
        else
          removeEventHandler("onClientPlayerWeaponFire", root, godmode_onClientPlayerWeaponFire)
          removeEventHandler("onClientPlayerDamage", localPlayer, godmode_onClientPlayerDamage)
        end
      end
    end
  end
  function walkwater_onClientRender()
    -- line: [59, 84] id: 225
    local r0_225, r1_225, r2_225 = getElementPosition(localPlayer)
    local r3_225 = getWaterLevel(r0_225, r1_225, r2_225, true)
    if r3_225 then
      if r2_225 - 0.5 < r3_225 then
        setElementPosition(localPlayer, r0_225, r1_225, r3_225 + 0.5, false)
      end
      if not isElement(solidwater) then
        solidwater = createObject(8171, getElementPosition(localPlayer))
        setElementAlpha(solidwater, 0)
      end
      r1_225 = 10 * math.floor(r1_225 / 10)
      r0_225 = 10 * math.floor(r0_225 / 10)
      local r4_225, r5_225 = getElementPosition(solidwater)
      setElementPosition(solidwater, r4_225, r5_225, r3_225 - 0.1)
      if r4_225 ~= r0_225 or r5_225 ~= r1_225 then
        destroyElement(solidwater)
        solidwater = createObject(8171, r0_225, r1_225, r3_225 - 0.1)
        setElementAlpha(solidwater, 0)
      end
      setElementInterior(solidwater, getCameraInterior() + 1)
    elseif isElement(solidwater) then
      destroyElement(solidwater)
    end
  end
  function magnetcars_onClientPreRender()
    -- line: [85, 133] id: 226
    local r0_226 = getPedOccupiedVehicle(localPlayer)
    if not r0_226 then
      return 
    end
    local r1_226 = getVehicleType(r0_226)
    if r1_226 ~= "Automobile" and r1_226 ~= "Bike" and r1_226 ~= "BMX" and r1_226 ~= "Monster Truck" and r1_226 ~= "Quad" then
      return 
    end
    local r2_226, r3_226, r4_226 = getElementPosition(r0_226)
    local r5_226, r6_226, r7_226 = getVehicleGravity(r0_226)
    local r8_226 = getElementVector(r0_226, 0, 1, 0, true)
    local r9_226 = getElementVector(r0_226, 0, 0, 1, true)
    local r10_226 = getElementVector(r0_226, 1, 0, 0, true)
    local r11_226 = 50
    local r12_226, r13_226, r14_226, r15_226, r16_226, r17_226, r18_226, r19_226 = processLineOfSight(r2_226, r3_226, r4_226, r2_226 + r11_226 * r8_226[1], r3_226 + r11_226 * r8_226[2], r4_226 + r11_226 * r8_226[3], true, false, false)
    local r20_226 = nil	-- notice: implicit variable refs by block#[26, 27]
    if r13_226 then
      r20_226 = getDistanceBetweenPoints3D(r2_226, r3_226, r4_226, r13_226, r14_226, r15_226)
      if not r20_226 then
        ::label_77::
        r20_226 = 100500
      end
    else
      goto label_77	-- block#10 is visited secondly
    end
    local r21_226, r22_226, r23_226, r24_226, r25_226, r26_226, r27_226, r28_226 = processLineOfSight(r2_226, r3_226, r4_226, r2_226 - r11_226 * r8_226[1], r3_226 - r11_226 * r8_226[2], r4_226 - r11_226 * r8_226[3], true, false, false)
    local r29_226 = nil	-- notice: implicit variable refs by block#[26, 30]
    if r22_226 then
      r29_226 = getDistanceBetweenPoints3D(r2_226, r3_226, r4_226, r22_226, r23_226, r24_226)
      if not r29_226 then
        ::label_107::
        r29_226 = 100500
      end
    else
      goto label_107	-- block#13 is visited secondly
    end
    local r30_226, r31_226, r32_226, r33_226, r34_226, r35_226, r36_226, r37_226 = processLineOfSight(r2_226, r3_226, r4_226, r2_226 + r11_226 * r9_226[1], r3_226 + r11_226 * r9_226[2], r4_226 + r11_226 * r9_226[3], true, false, false)
    local r38_226 = nil	-- notice: implicit variable refs by block#[26, 33]
    if r31_226 then
      r38_226 = getDistanceBetweenPoints3D(r2_226, r3_226, r4_226, r31_226, r32_226, r33_226)
      if not r38_226 then
        ::label_137::
        r38_226 = 100500
      end
    else
      goto label_137	-- block#16 is visited secondly
    end
    local r39_226, r40_226, r41_226, r42_226, r43_226, r44_226, r45_226, r46_226 = processLineOfSight(r2_226, r3_226, r4_226, r2_226 - r11_226 * r9_226[1], r3_226 - r11_226 * r9_226[2], r4_226 - r11_226 * r9_226[3], true, false, false)
    local r47_226 = nil	-- notice: implicit variable refs by block#[26, 36]
    if r40_226 then
      r47_226 = getDistanceBetweenPoints3D(r2_226, r3_226, r4_226, r40_226, r41_226, r42_226)
      if not r47_226 then
        ::label_167::
        r47_226 = 100500
      end
    else
      goto label_167	-- block#19 is visited secondly
    end
    local r48_226, r49_226, r50_226, r51_226, r52_226, r53_226, r54_226, r55_226 = processLineOfSight(r2_226, r3_226, r4_226, r2_226 + r11_226 * r10_226[1], r3_226 + r11_226 * r10_226[2], r4_226 + r11_226 * r10_226[3], true, false, false)
    local r56_226 = nil	-- notice: implicit variable refs by block#[26, 39]
    if r49_226 then
      r56_226 = getDistanceBetweenPoints3D(r2_226, r3_226, r4_226, r49_226, r50_226, r51_226)
      if not r56_226 then
        ::label_197::
        r56_226 = 100500
      end
    else
      goto label_197	-- block#22 is visited secondly
    end
    local r57_226, r58_226, r59_226, r60_226, r61_226, r62_226, r63_226, r64_226 = processLineOfSight(r2_226, r3_226, r4_226, r2_226 - r11_226 * r10_226[1], r3_226 - r11_226 * r10_226[2], r4_226 - r11_226 * r10_226[3], true, false, false)
    local r65_226 = nil	-- notice: implicit variable refs by block#[26, 42]
    if r58_226 then
      r65_226 = getDistanceBetweenPoints3D(r2_226, r3_226, r4_226, r58_226, r59_226, r60_226)
      if not r65_226 then
        ::label_227::
        r65_226 = 100500
      end
    else
      goto label_227	-- block#25 is visited secondly
    end
    local r66_226 = math.min(r20_226, r29_226, r38_226, r47_226, r56_226, r65_226)
    if r66_226 < r11_226 then
      local r67_226 = 0
      local r68_226 = 0
      local r69_226 = -1
      if r66_226 == r20_226 and r13_226 then
        r69_226 = -r19_226
        r68_226 = -r18_226
        r67_226 = -r17_226
      end
      if r66_226 == r29_226 and r22_226 then
        r69_226 = -r28_226
        r68_226 = -r27_226
        r67_226 = -r26_226
      end
      if r66_226 == r38_226 and r31_226 then
        r69_226 = -r37_226
        r68_226 = -r36_226
        r67_226 = -r35_226
      end
      if r66_226 == r47_226 and r40_226 then
        r69_226 = -r46_226
        r68_226 = -r45_226
        r67_226 = -r44_226
      end
      if r66_226 == r56_226 and r49_226 then
        r69_226 = -r55_226
        r68_226 = -r54_226
        r67_226 = -r53_226
      end
      if r66_226 == r65_226 and r58_226 then
        r69_226 = -r64_226
        r68_226 = -r63_226
        r67_226 = -r62_226
      end
      setVehicleGravity(r0_226, r5_226 + 0.05 * (r67_226 - r5_226), r6_226 + 0.05 * (r68_226 - r6_226), r7_226 + 0.05 * (r69_226 - r7_226))
    else
      setVehicleGravity(r0_226, r5_226 + 0.05 * (0 - r5_226), r6_226 + 0.05 * (0 - r6_226), r7_226 + 0.05 * (-1 - r7_226))
    end
  end
  function magnetcars_onClientPlayerVehicleExit(r0_227, r1_227)
    -- line: [134, 139] id: 227
    local r2_227 = getVehicleType(r0_227)
    if r2_227 == "Automobile" or r2_227 == "Bike" or r2_227 == "BMX" or r2_227 == "Monster Truck" or r2_227 == "Quad" then
      setVehicleGravity(source, 0, 0, -1)
    end
  end
  function checkSH()
    -- line: [140, 146] id: 228
    local r0_228 = getRealTime().second
    if 101 < math.floor(100 * (60 + r1_223 - r0_228) / 60) or math.floor(100 * (60 + r1_223 - r0_228) / 60) < 99 then
      local r1_228 = doPunishment
      local r2_228 = string.format
      local r3_228 = "SpeedHack %s.%X.%X"
      local r4_228 = r1_223 - r0_228
      if r4_228 > 0 then
        r4_228 = "I" or "R"
      else
        goto label_34	-- block#4 is visited secondly
      end
      r1_228(r2_228(r3_228, r4_228, math.floor(100 * (60 + r1_223 - r0_228) / 60), 100 * math.abs((r1_223 - r0_228))))
    end
    r1_223 = r0_228
  end
  function godmode_onClientPlayerWeaponFire(r0_229, r1_229, r2_229, r3_229, r4_229, r5_229, r6_229)
    -- line: [147, 159] id: 229
    if r6_229 == localPlayer and source ~= localPlayer and 22 <= r0_229 and r0_229 <= 34 then
      if r2_223[source] or isPlayerDead(localPlayer) or getElementHealth(localPlayer) <= 0 or getPlayerTeam(localPlayer) and getPlayerTeam(localPlayer) == getPlayerTeam(source) and not getTeamFriendlyFire(getPlayerTeam(localPlayer)) then
        r2_223[source] = nil
      else
        doPunishment(string.format("GodMode %X", r0_229))
        r2_223[source] = nil
      end
    end
  end
  function godmode_onClientPlayerDamage(r0_230, r1_230, r2_230, r3_230)
    -- line: [160, 164] id: 230
    if r0_230 ~= localPlayer and 22 <= r1_230 and r1_230 <= 34 then
      r2_223[r0_230] = true
    end
  end
  function doPunishment(r0_231)
    -- line: [165, 167] id: 231
    callServerFunction("doPunishment", localPlayer, r0_231)
  end
  addEventHandler("onClientTacticsChange", root, onClientTacticsChange)
end)()
(function(...)
  -- line: [0, 0] id: 232
  function pickupWeapon()
    -- line: [7, 63] id: 233
    if isRoundPaused() or getPedOccupiedVehicle(localPlayer) or getElementHealth(localPlayer) <= 0 then
      return 
    end
    local r0_233 = getPedTask(localPlayer, "secondary", 0)
    if r0_233 == "TASK_SIMPLE_THROW" or r0_233 == "TASK_SIMPLE_USE_GUN" then
      return 
    end
    local r1_233, r2_233, r3_233 = getElementPosition(localPlayer)
    local r4_233 = getElementsByType("pickup", root, true)
    if not r4_233 or #r4_233 == 0 then
      return 
    end
    if #r4_233 > 1 then
      table.sort(r4_233, function(r0_234, r1_234)
        -- line: [15, 19] id: 234
        local r2_234, r3_234, r4_234 = getElementPosition(r0_234)
        local r5_234, r6_234, r7_234 = getElementPosition(r1_234)
        return getDistanceBetweenPoints3D(r1_233, r2_233, r3_233, r2_234, r3_234, r4_234) < getDistanceBetweenPoints3D(r1_233, r2_233, r3_233, r5_234, r6_234, r7_234)
      end)
    end
    local r5_233, r6_233, r7_233 = getElementPosition(r4_233[1])
    if getDistanceBetweenPoints3D(r1_233, r2_233, r3_233, r5_233, r6_233, r7_233) > 2 then
      return 
    end
    local r8_233 = getPickupWeapon(r4_233[1])
    local r10_233 = getSlotFromWeapon(r8_233)
    local r11_233 = getPedWeapon(localPlayer)
    local r12_233 = {}
    local r13_233 = false
    local r14_233 = false
    local r15_233 = getTacticsData("weaponspack")
    if not r15_233[convertWeaponIDToNames[r8_233]] then
      callServerFunction("pickupWeapon", localPlayer, r4_233[1])
      return setControlState("enter_exit", false)
    end
    local r16_233 = {}
    for r20_233 = 0, 12, 1 do
      if 0 < getPedWeapon(localPlayer, r20_233) and 0 < getPedTotalAmmo(localPlayer, r20_233) then
        if r20_233 == r10_233 then
          callServerFunction("replaceWeapon", localPlayer, r4_233[1], r20_233)
          return setControlState("enter_exit", false)
        end
        table.insert(r16_233, r20_233)
      end
    end
    local r17_233 = getTacticsData("weapon_slots") or 0
    if r17_233 == 0 or #r16_233 < r17_233 then
      callServerFunction("pickupWeapon", localPlayer, r4_233[1])
      return setControlState("enter_exit", false)
    end
    if r11_233 > 0 then
      if r15_233[convertWeaponIDToNames[r11_233]] then
        callServerFunction("replaceWeapon", localPlayer, r4_233[1], getPedWeaponSlot(localPlayer))
        return setControlState("enter_exit", false)
      else
        callServerFunction("pickupWeapon", localPlayer, r4_233[1])
        return setControlState("enter_exit", false)
      end
    end
    if #r16_233 > 0 then
      callServerFunction("replaceWeapon", localPlayer, r4_233[1], r16_233[1])
      return setControlState("enter_exit", false)
    end
  end
  function dropWeapon()
    -- line: [64, 73] id: 235
    if isRoundPaused() or getPedOccupiedVehicle(localPlayer) or getElementHealth(localPlayer) <= 0 then
      return 
    end
    local r0_235 = getPedTask(localPlayer, "secondary", 0)
    if r0_235 == "TASK_SIMPLE_THROW" or r0_235 == "TASK_SIMPLE_USE_GUN" then
      return 
    end
    if getPedTotalAmmo(localPlayer) ~= 0 then
      setElementData(localPlayer, "Weapons", nil)
      callServerFunction("dropWeapon", localPlayer)
    end
  end
  local r0_232 = nil
  function onClientPlayerPickupHit(r0_236, r1_236)
    -- line: [75, 80] id: 236
    if not r1_236 or isRoundPaused() or getPedOccupiedVehicle(localPlayer) or getElementHealth(localPlayer) <= 0 then
      return 
    end
    local r2_236 = getPedTask(localPlayer, "secondary", 0)
    if r2_236 == "TASK_SIMPLE_THROW" or r2_236 == "TASK_SIMPLE_USE_GUN" then
      return 
    end
    r0_232 = outputInfo(string.format(getLanguageString("help_pickup"), string.upper(next(getBoundKeys("weapon_pickup")))))
  end
  function onClientPlayerPickupLeave(r0_237, r1_237)
    -- line: [81, 85] id: 237
    if r1_237 and r0_232 then
      hideInfo(r0_232)
    end
  end
  addCommandHandler("weapon_pickup", pickupWeapon, false)
  addCommandHandler("weapon_drop", dropWeapon, false)
  addEventHandler("onClientPlayerPickupHit", localPlayer, onClientPlayerPickupHit)
  addEventHandler("onClientPlayerPickupLeave", localPlayer, onClientPlayerPickupLeave)
end)()
(function(...)
  -- line: [0, 0] id: 238
  local r0_238 = 0
  local r1_238 = 0
  local r2_238 = 0
  local r3_238 = 0
  local r4_238 = 0
  local r5_238 = 0
  local r6_238 = "playertarget"
  local r7_238 = {}
  local r8_238 = 1
  local r9_238 = {
    [24] = 0.5,
    [25] = 1,
    [29] = 0.5,
    [30] = 0.5,
    [31] = 0.5,
    [33] = 0.5,
  }
  local r10_238 = {
    xcam = 0,
    ycam = 0,
    zcam = 0,
    xsee = 0,
    ysee = 0,
    zsee = 0,
    fov = 70,
  }
  laseraimRender = {}
  function onClientResourceStart(r0_239)
    -- line: [15, 34] id: 239
    aim_m4 = guiCreateStaticImage(0, 0, 0, 0, "images/aim_m4.png", false)
    guiSetVisible(aim_m4, false)
    guiSetEnabled(aim_m4, false)
    aim_rocket = guiCreateStaticImage(0, 0, 0, 0, "images/aim_rocket.png", false)
    guiSetVisible(aim_rocket, false)
    guiSetEnabled(aim_rocket, false)
    aim_sniper = guiCreateStaticImage(0, 0, 0, 0, "images/aim_sniper.png", false)
    guiSetVisible(aim_sniper, false)
    guiSetEnabled(aim_sniper, false)
    aim_sniper2 = guiCreateStaticImage(xscreen * 0.5 - yscreen * 0.5, 0, yscreen, yscreen, "images/aim_sniper.png", false)
    guiSetVisible(aim_sniper2, false)
    guiSetEnabled(aim_sniper2, false)
    speclist = guiCreateLabel(xscreen * 0.03125, yscreen * 0.375, xscreen, yscreen, "", false)
    guiSetVisible(speclist, false)
    guiSetEnabled(speclist, false)
    guiSetFont(speclist, "default-small")
    guiSetAlpha(speclist, 0.5)
    laseraimTexture = dxCreateTexture("images/sphere.png")
  end
  function setCameraSpectating(r0_240, r1_240)
    -- line: [35, 65] id: 240
    local r2_240 = getPlayerTeam(localPlayer)
    if r1_240 then
      r6_238 = r1_240
    end
    if r0_240 then
      local r3_240 = getTacticsData("settings", "spectate_enemy") or getTacticsData("modes", getTacticsData("Map"), "spectate_enemy")
      if r0_240 ~= localPlayer and getElementData(r0_240, "Status") == "Play" then
        if getPlayerTeam(r0_240) == r2_240 or r3_240 == "true" or r2_240 == getElementsByType("team")[1] or getRoundState() == "started" then
          setElementData(localPlayer, "spectarget", r0_240)
          if r6_238 == "freecamera" then
            r0_238, r1_238, r2_238 = getElementPosition(r0_240)
          else
            setCameraTarget(r0_240)
          end
        else
          setElementData(localPlayer, "spectarget", nil)
          return setCameraMatrix(getCameraMatrix())
        end
      end
    end
    if setElementData(localPlayer, "Status", "Spectate") and not r0_240 and r1_240 ~= "freecamera" then
      switchSpectating()
    end
    if r1_240 == "freecamera" then
      local r3_240, r4_240, r5_240, r6_240, r7_240, r8_240 = getCameraMatrix()
      local r9_240 = getDistanceBetweenPoints3D(r3_240, r4_240, r5_240, r6_240, r7_240, r8_240)
      r2_238 = r5_240
      r1_238 = r4_240
      r0_238 = r3_240
      r4_238 = math.asin((r8_240 - r5_240) / r9_240)
      local r10_240 = math.abs(r6_240 - r3_240)
      if r10_240 ~= 0 then
        r10_240 = math.cos(r4_238)
        if r10_240 ~= 0 then
          r10_240 = (r6_240 - r3_240) / math.abs((r6_240 - r3_240)) * math.acos((r7_240 - r4_240) / r9_240 * math.cos(r4_238)) or 0
        end
      else
        goto label_143	-- block#23 is visited secondly
      end
      r3_238 = r10_240
    end
    return true
  end
  function switchSpectating(r0_241)
    -- line: [66, 128] id: 241
    if getElementData(localPlayer, "Status") ~= "Spectate" or getElementDimension(localPlayer) == 10 then
      return 
    end
    local r1_241 = getPlayerTeam(localPlayer)
    local r2_241 = getElementData(localPlayer, "spectarget")
    local r3_241 = {}
    local r4_241 = {}
    local r5_241 = getTacticsData("settings", "spectate_enemy") or getTacticsData("modes", getTacticsData("Map"), "spectate_enemy")
    for r9_241, r10_241 in ipairs(getElementsByType("player")) do
      if r10_241 ~= localPlayer and getElementData(r10_241, "Status") == "Play" then
        table.insert(r4_241, r10_241)
        if getPlayerTeam(r10_241) == r1_241 or r5_241 == "true" then
          table.insert(r3_241, r10_241)
        end
      end
    end
    if #r3_241 == 0 then
      if r1_241 == getElementsByType("team")[1] or getRoundState() == "started" then
        if #r4_241 == 0 then
          setElementData(localPlayer, "spectarget", nil)
          return setCameraMatrix(getCameraMatrix())
        else
          r3_241 = r4_241
        end
      else
        setElementData(localPlayer, "spectarget", nil)
        return setCameraMatrix(getCameraMatrix())
      end
    end
    local r6_241 = false
    if r0_241 == "q" or r0_241 == "arrow_l" then
      for r10_241, r11_241 in ipairs(r3_241) do
        if r11_241 == r2_241 then
          if r3_241[r10_241 - 1] ~= nil then
            r6_241 = r3_241[r10_241 - 1] or r3_241[#r3_241]
          else
            goto label_126	-- block#25 is visited secondly
          end
          break
        end
      end
      if not r6_241 then
        r6_241 = r3_241[#r3_241]
      end
    elseif r0_241 == "e" or r0_241 == "arrow_r" then
      for r10_241, r11_241 in ipairs(r3_241) do
        if r11_241 == r2_241 then
          if r3_241[r10_241 + 1] ~= nil then
            r6_241 = r3_241[r10_241 + 1] or r3_241[1]
          else
            goto label_154	-- block#36 is visited secondly
          end
          break
        end
      end
      if not r6_241 then
        r6_241 = r3_241[1]
      end
    else
      table.sort(r3_241, function(r0_242, r1_242)
        -- line: [112, 117] id: 242
        local r2_242, r3_242, r4_242 = getCameraMatrix()
        local r5_242, r6_242, r7_242 = getElementPosition(r0_242)
        local r8_242, r9_242, r10_242 = getElementPosition(r1_242)
        return getDistanceBetweenPoints3D(r5_242, r6_242, r7_242, r2_242, r3_242, r4_242) < getDistanceBetweenPoints3D(r8_242, r9_242, r10_242, r2_242, r3_242, r4_242)
      end)
      r6_241 = r3_241[1]
    end
    if r6_241 then
      if r6_238 == "freecamera" then
        r0_238, r1_238, r2_238 = getElementPosition(r6_241)
      else
        setElementData(localPlayer, "spectarget", r6_241)
        setCameraTarget(r6_241)
      end
    end
  end
  function spec_onClientPreRender(r0_243)
    -- line: [129, 374] id: 243
    if r6_238 == "playertarget" then
      local r1_243 = getElementData(localPlayer, "spectarget")
      if r1_243 and isElement(r1_243) then
        if getCameraTarget() ~= r1_243 and getCameraTarget() ~= getPedOccupiedVehicle(r1_243) then
          setCameraTarget(r1_243)
        end
        if not getCameraTarget() then
          setCameraTarget(r1_243)
        end
        local r2_243, r3_243, r4_243 = getPedTargetCollision(r1_243)
        if not r2_243 then
          r2_243, r3_243, r4_243 = getPedTargetEnd(r1_243)
        end
        if r2_243 then
          r2_243, r3_243 = getScreenFromWorldPosition(r2_243, r3_243, r4_243)
        end
        if getPedControlState(r1_243, "aim_weapon") and getPedTask(r1_243, "secondary", 0) == "TASK_SIMPLE_USE_GUN" and r2_243 then
          local r5_243 = getPedWeapon(r1_243)
          if r5_243 == 34 then
            if guiGetVisible(aim_m4) then
              guiSetVisible(aim_m4, false)
            end
            if guiGetVisible(aim_rocket) then
              guiSetVisible(aim_rocket, false)
            end
            if not guiGetVisible(aim_sniper) then
              guiSetVisible(aim_sniper, true)
            end
            if guiGetVisible(aim_sniper2) then
              guiSetVisible(aim_sniper2, false)
            end
            guiSetPosition(aim_sniper, r2_243 - xscreen * 0.0645, r3_243 - yscreen * 0.0915, false)
            guiSetSize(aim_sniper, xscreen * 0.129, yscreen * 0.183, false)
          elseif r5_243 == 35 or r5_243 == 36 then
            if guiGetVisible(aim_m4) then
              guiSetVisible(aim_m4, false)
            end
            if not guiGetVisible(aim_rocket) then
              guiSetVisible(aim_rocket, true)
            end
            if guiGetVisible(aim_sniper) then
              guiSetVisible(aim_sniper, false)
            end
            if guiGetVisible(aim_sniper2) then
              guiSetVisible(aim_sniper2, false)
            end
            guiSetPosition(aim_rocket, r2_243 - xscreen * 0.072, r3_243 - yscreen * 0.1025, false)
            guiSetSize(aim_rocket, xscreen * 0.144, yscreen * 0.205, false)
          elseif r9_238[r5_243] then
            if not guiGetVisible(aim_m4) then
              guiSetVisible(aim_m4, true)
            end
            if guiGetVisible(aim_rocket) then
              guiSetVisible(aim_rocket, false)
            end
            if guiGetVisible(aim_sniper) then
              guiSetVisible(aim_sniper, false)
            end
            if guiGetVisible(aim_sniper2) then
              guiSetVisible(aim_sniper2, false)
            end
            guiSetPosition(aim_m4, r2_243 - xscreen * 0.02 * r9_238[r5_243] * r8_238, r3_243 - yscreen * 0.02667 * r9_238[r5_243] * r8_238, false)
            guiSetSize(aim_m4, xscreen * 0.04 * r9_238[r5_243] * r8_238, yscreen * 0.05333 * r9_238[r5_243] * r8_238, false)
          else
            if guiGetVisible(aim_m4) then
              guiSetVisible(aim_m4, false)
            end
            if guiGetVisible(aim_rocket) then
              guiSetVisible(aim_rocket, false)
            end
            if guiGetVisible(aim_sniper) then
              guiSetVisible(aim_sniper, false)
            end
            if guiGetVisible(aim_sniper2) then
              guiSetVisible(aim_sniper2, false)
            end
          end
        else
          if guiGetVisible(aim_m4) then
            guiSetVisible(aim_m4, false)
          end
          if guiGetVisible(aim_rocket) then
            guiSetVisible(aim_rocket, false)
          end
          if guiGetVisible(aim_sniper) then
            guiSetVisible(aim_sniper, false)
          end
          if guiGetVisible(aim_sniper2) then
            guiSetVisible(aim_sniper2, false)
          end
        end
        if r8_238 > 1 then
          r8_238 = r8_238 - 0.05 * (r8_238 - 1)
        else
          r8_238 = 1
        end
        setElementInterior(localPlayer, getElementInterior(r1_243))
        setCameraInterior(getElementInterior(r1_243))
      else
        switchSpectating()
        if guiGetVisible(aim_m4) then
          guiSetVisible(aim_m4, false)
        end
        if guiGetVisible(aim_rocket) then
          guiSetVisible(aim_rocket, false)
        end
        if guiGetVisible(aim_sniper) then
          guiSetVisible(aim_sniper, false)
        end
        if guiGetVisible(aim_sniper2) then
          guiSetVisible(aim_sniper2, false)
        end
      end
    elseif r6_238 == "playercamera" then
      local r1_243 = getElementData(localPlayer, "spectarget")
      if r1_243 and isElement(r1_243) then
        if getPedOccupiedVehicle(r1_243) then
          if not getCameraTarget() or getCameraTarget() ~= getPedOccupiedVehicle(r1_243) then
            setCameraTarget(r1_243)
          end
          local r2_243, r3_243, r4_243 = getCameraMatrix()
          local r5_243, r6_243, r7_243 = getElementPosition(r1_243)
          r10_238 = {
            xcam = r2_243 - r5_243,
            ycam = r3_243 - r6_243,
            zcam = r4_243 - r7_243,
            xsee = 0,
            ysee = 0,
            zsee = 0,
            fov = 70,
          }
          if guiGetVisible(aim_m4) then
            guiSetVisible(aim_m4, false)
          end
          if guiGetVisible(aim_rocket) then
            guiSetVisible(aim_rocket, false)
          end
          if guiGetVisible(aim_sniper) then
            guiSetVisible(aim_sniper, false)
          end
          if guiGetVisible(aim_sniper2) then
            guiSetVisible(aim_sniper2, false)
          end
          if getElementAlpha(r1_243) == 0 then
            setElementAlpha(r1_243, 255)
          end
        else
          local r2_243 = 0.5
          local r3_243, r4_243, r5_243 = getElementPosition(r1_243)
          local r6_243, r7_243, r8_243 = getPedTargetStart(r1_243)
          local r9_243, r10_243, r11_243 = getPedTargetEnd(r1_243)
          local r12_243 = getDistanceBetweenPoints3D(r6_243, r7_243, r8_243, r3_243, r4_243, r5_243)
          local r13_243 = getDistanceBetweenPoints3D(r6_243, r7_243, r8_243, r9_243, r10_243, r11_243)
          if getPedControlState(r1_243, "aim_weapon") and getPedTask(r1_243, "secondary", 0) == "TASK_SIMPLE_USE_GUN" and r12_243 < 3 and 0 < r13_243 and tonumber(tostring(r13_243)) then
            local r14_243 = getPedWeapon(r1_243)
            local r15_243 = ({
              [30] = 55,
              [31] = 50,
              [33] = 40,
              [34] = 12,
            })[r14_243] or 70
            local r16_243 = ({
              [34] = 2,
              [35] = 2,
              [36] = 2,
              [43] = 2,
            })[r14_243] or 3.25
            local r17_243 = getDistanceBetweenPoints3D(r6_243, r7_243, r8_243, r9_243, r10_243, r11_243)
            local r18_243 = r10_238.xcam + r2_243 * (r6_243 - r16_243 * (r9_243 - r6_243) / r17_243 - r3_243 - r10_238.xcam)
            local r19_243 = r10_238.ycam + r2_243 * (r7_243 - r16_243 * (r10_243 - r7_243) / r17_243 - r4_243 - r10_238.ycam)
            local r20_243 = r10_238.zcam + r2_243 * (r8_243 - r16_243 * (r11_243 - r8_243) / r17_243 - r5_243 - r10_238.zcam)
            r6_243 = r10_238.xsee + r2_243 * (r6_243 - r3_243 - r10_238.xsee)
            r7_243 = r10_238.ysee + r2_243 * (r7_243 - r4_243 - r10_238.ysee)
            r8_243 = r10_238.zsee + r2_243 * (r8_243 - r5_243 - r10_238.zsee)
            r15_243 = r10_238.fov + r2_243 * (r15_243 - r10_238.fov)
            r10_238 = {
              xcam = r18_243,
              ycam = r19_243,
              zcam = r20_243,
              xsee = r6_243,
              ysee = r7_243,
              zsee = r8_243,
              fov = r15_243,
            }
            r20_243 = r20_243 + r5_243
            r19_243 = r19_243 + r4_243
            r18_243 = r18_243 + r3_243
            r8_243 = r8_243 + r5_243
            r7_243 = r7_243 + r4_243
            r6_243 = r6_243 + r3_243
            local r21_243, r22_243, r23_243, r24_243 = processLineOfSight(r6_243, r7_243, r8_243, r18_243, r19_243, r20_243, true, true, false)
            if r21_243 then
              r20_243 = r24_243
              r19_243 = r23_243
              r18_243 = r22_243
            end
            setCameraMatrix(r18_243, r19_243, r20_243, r6_243, r7_243, r8_243, 0, r15_243)
            if r16_243 == 2 and getElementAlpha(r1_243) == 255 then
              setElementAlpha(r1_243, 0)
            elseif getElementAlpha(r1_243) == 0 then
              setElementAlpha(r1_243, 255)
            end
            local r25_243, r26_243, r27_243 = getPedTargetCollision(r1_243)
            if not r25_243 then
              r25_243, r26_243, r27_243 = getPedTargetEnd(r1_243)
            end
            local r28_243, r29_243 = getScreenFromWorldPosition(r25_243, r26_243, r27_243)
            if r28_243 then
              if r14_243 == 34 then
                if guiGetVisible(aim_m4) then
                  guiSetVisible(aim_m4, false)
                end
                if guiGetVisible(aim_rocket) then
                  guiSetVisible(aim_rocket, false)
                end
                if guiGetVisible(aim_sniper) then
                  guiSetVisible(aim_sniper, false)
                end
                if not guiGetVisible(aim_sniper2) then
                  guiSetVisible(aim_sniper2, true)
                end
                guiSetPosition(aim_sniper, r28_243 - xscreen * 0.0645, r29_243 - yscreen * 0.0915, false)
                guiSetSize(aim_sniper, xscreen * 0.129, yscreen * 0.183, false)
              elseif r14_243 == 35 or r14_243 == 36 then
                if guiGetVisible(aim_m4) then
                  guiSetVisible(aim_m4, false)
                end
                if not guiGetVisible(aim_rocket) then
                  guiSetVisible(aim_rocket, true)
                end
                if guiGetVisible(aim_sniper) then
                  guiSetVisible(aim_sniper, false)
                end
                if guiGetVisible(aim_sniper2) then
                  guiSetVisible(aim_sniper2, false)
                end
                guiSetPosition(aim_rocket, r28_243 - xscreen * 0.072, r29_243 - yscreen * 0.1025, false)
                guiSetSize(aim_rocket, xscreen * 0.144, yscreen * 0.205, false)
              elseif r9_238[r14_243] then
                if not guiGetVisible(aim_m4) then
                  guiSetVisible(aim_m4, true)
                end
                if guiGetVisible(aim_rocket) then
                  guiSetVisible(aim_rocket, false)
                end
                if guiGetVisible(aim_sniper) then
                  guiSetVisible(aim_sniper, false)
                end
                if guiGetVisible(aim_sniper2) then
                  guiSetVisible(aim_sniper2, false)
                end
                guiSetPosition(aim_m4, r28_243 - xscreen * 0.02 * r9_238[r14_243] * r8_238, r29_243 - yscreen * 0.02667 * r9_238[r14_243] * r8_238, false)
                guiSetSize(aim_m4, xscreen * 0.04 * r9_238[r14_243] * r8_238, yscreen * 0.05333 * r9_238[r14_243] * r8_238, false)
              else
                if guiGetVisible(aim_m4) then
                  guiSetVisible(aim_m4, false)
                end
                if guiGetVisible(aim_rocket) then
                  guiSetVisible(aim_rocket, false)
                end
                if guiGetVisible(aim_sniper) then
                  guiSetVisible(aim_sniper, false)
                end
                if guiGetVisible(aim_sniper2) then
                  guiSetVisible(aim_sniper2, false)
                end
              end
            else
              if guiGetVisible(aim_m4) then
                guiSetVisible(aim_m4, false)
              end
              if guiGetVisible(aim_rocket) then
                guiSetVisible(aim_rocket, false)
              end
              if guiGetVisible(aim_sniper) then
                guiSetVisible(aim_sniper, false)
              end
              if guiGetVisible(aim_sniper2) then
                guiSetVisible(aim_sniper2, false)
              end
            end
          else
            local r14_243, r15_243, r16_243 = getElementPosition(r1_243)
            local r17_243 = math.rad(360 - getPedCameraRotation(r1_243))
            local r18_243 = math.rad(15)
            local r19_243 = 0
            local r20_243 = 0
            local r21_243 = 0.6
            if isPedDucked(r1_243) then
              r21_243 = -0.1
            end
            local r22_243 = r10_238.xcam + r2_243 * (3.5 * math.sin(r17_243) * math.cos(r18_243) - r10_238.xcam)
            local r23_243 = r10_238.ycam + r2_243 * (-3.5 * math.cos(r17_243) * math.cos(r18_243) - r10_238.ycam)
            local r24_243 = r10_238.zcam + r2_243 * (3.5 * math.sin(r18_243) + r21_243 - r10_238.zcam)
            r19_243 = r10_238.xsee + r2_243 * (r19_243 - r10_238.xsee)
            r20_243 = r10_238.ysee + r2_243 * (r20_243 - r10_238.ysee)
            r21_243 = r10_238.zsee + r2_243 * (r21_243 - r10_238.zsee)
            local r25_243 = r10_238.fov + r2_243 * (70 - r10_238.fov)
            r10_238 = {
              xcam = r22_243,
              ycam = r23_243,
              zcam = r24_243,
              xsee = r19_243,
              ysee = r20_243,
              zsee = r21_243,
              fov = r25_243,
            }
            r24_243 = r24_243 + r16_243
            r23_243 = r23_243 + r15_243
            r22_243 = r22_243 + r14_243
            r21_243 = r21_243 + r16_243
            r20_243 = r20_243 + r15_243
            r19_243 = r19_243 + r14_243
            local r26_243, r27_243, r28_243, r29_243 = processLineOfSight(r19_243, r20_243, r21_243, r22_243, r23_243, r24_243, true, true, false)
            if r26_243 then
              r24_243 = r29_243
              r23_243 = r28_243
              r22_243 = r27_243
            end
            setCameraMatrix(r22_243, r23_243, r24_243, r19_243, r20_243, r21_243, 0, r25_243)
            if guiGetVisible(aim_m4) then
              guiSetVisible(aim_m4, false)
            end
            if guiGetVisible(aim_rocket) then
              guiSetVisible(aim_rocket, false)
            end
            if guiGetVisible(aim_sniper) then
              guiSetVisible(aim_sniper, false)
            end
            if guiGetVisible(aim_sniper2) then
              guiSetVisible(aim_sniper2, false)
            end
            if getElementAlpha(r1_243) == 0 then
              setElementAlpha(r1_243, 255)
            end
          end
          if r8_238 > 1 then
            r8_238 = r8_238 - 0.05 * (r8_238 - 1)
          else
            r8_238 = 1
          end
          setElementInterior(localPlayer, getElementInterior(r1_243))
          setCameraInterior(getElementInterior(r1_243))
        end
      else
        switchSpectating()
        if guiGetVisible(aim_m4) then
          guiSetVisible(aim_m4, false)
        end
        if guiGetVisible(aim_rocket) then
          guiSetVisible(aim_rocket, false)
        end
        if guiGetVisible(aim_sniper) then
          guiSetVisible(aim_sniper, false)
        end
        if guiGetVisible(aim_sniper2) then
          guiSetVisible(aim_sniper2, false)
        end
      end
    elseif r6_238 == "freecamera" then
      if guiGetVisible(aim_m4) then
        guiSetVisible(aim_m4, false)
      end
      if guiGetVisible(aim_rocket) then
        guiSetVisible(aim_rocket, false)
      end
      if guiGetVisible(aim_sniper) then
        guiSetVisible(aim_sniper, false)
      end
      if guiGetVisible(aim_sniper2) then
        guiSetVisible(aim_sniper2, false)
      end
      local r1_243, r2_243, r3_243, r4_243, r5_243, r6_243 = getCameraMatrix()
      local r7_243 = 2000
      if getCameraTarget() then
        r2_238 = r3_243
        r1_238 = r2_243
        r0_238 = r1_243
        setCameraMatrix(r1_243, r2_243, r3_243, r4_243, r5_243, r6_243)
        r4_238 = math.asin((r6_243 - r3_243) / r7_243)
        local r8_243 = math.abs(r4_243 - r1_243)
        if r8_243 ~= 0 then
          r8_243 = math.cos(r4_238)
          if r8_243 ~= 0 then
            r8_243 = (r4_243 - r1_243) / math.abs((r4_243 - r1_243)) * math.acos((r5_243 - r2_243) / r7_243 * math.cos(r4_238)) or 0
          end
        else
          goto label_1350	-- block#196 is visited secondly
        end
        r3_238 = r8_243
      end
      if r7_238.sprint then
        if r5_238 < 2 then
          r5_238 = 2
        elseif r5_238 < 20 then
          r5_238 = r5_238 + 0.05
        end
      elseif r7_238.walk then
        if r5_238 < 0.1 then
          r5_238 = 0.1
        elseif r5_238 > 0.1 then
          r5_238 = r5_238 - 0.1
        end
      elseif r5_238 < 0.6 then
        r5_238 = 0.6
      elseif r5_238 > 0.6 then
        r5_238 = r5_238 - 0.1
      end
      local r8_243 = 0
      local r9_243 = 0
      local r10_243 = 0
      if r7_238.forwards then
        r8_243 = (r4_243 - r1_243) * r5_238 / r7_243
        r9_243 = (r5_243 - r2_243) * r5_238 / r7_243
        r10_243 = (r6_243 - r3_243) * r5_238 / r7_243
      end
      if r7_238.backwards then
        r8_243 = (r1_243 - r4_243) * r5_238 / r7_243
        r9_243 = (r2_243 - r5_243) * r5_238 / r7_243
        r10_243 = (r3_243 - r6_243) * r5_238 / r7_243
      end
      local r11_243 = getAngleBetweenPoints2D(r1_243, r2_243, r4_243, r5_243)
      if r7_238.left then
        r8_243 = r8_243 + r5_238 * math.cos(math.rad((r11_243 + 180)))
        r9_243 = r9_243 + r5_238 * math.sin(math.rad((r11_243 + 180)))
      end
      if r7_238.right then
        r8_243 = r8_243 + r5_238 * math.cos(math.rad(r11_243))
        r9_243 = r9_243 + r5_238 * math.sin(math.rad(r11_243))
      end
      if r7_238.jump then
        r10_243 = r10_243 + 0.66 * r5_238
      end
      if r7_238.crouch then
        r10_243 = r10_243 - 0.66 * r5_238
      end
      r2_238 = r2_238 + r10_243
      r1_238 = r1_238 + r9_243
      r0_238 = r0_238 + r8_243
      if 0.499 * math.pi < r4_238 then
        r4_238 = 0.499 * math.pi
      end
      if r4_238 < -0.499 * math.pi then
        r4_238 = -0.499 * math.pi
      end
      xpoint2 = r0_238 + r7_243 * math.sin(r3_238) * math.cos(r4_238)
      ypoint2 = r1_238 + r7_243 * math.cos(r3_238) * math.cos(r4_238)
      zpoint2 = r2_238 + r7_243 * math.sin(r4_238)
      setCameraMatrix(r1_243 + 0.1 * (r0_238 - r1_243), r2_243 + 0.1 * (r1_238 - r2_243), r3_243 + 0.1 * (r2_238 - r3_243), xpoint2, ypoint2, zpoint2)
    end
  end
  function spec_onClientCursorMove(r0_244, r1_244, r2_244, r3_244)
    -- line: [375, 382] id: 244
    if r6_238 == "freecamera" and not isCursorShowing() and not isMTAWindowActive() then
      r0_244 = r2_244 - 0.5 * xscreen
      r1_244 = r3_244 - 0.5 * yscreen
      r3_238 = (r3_238 + r0_244 * 0.002) % 2 * math.pi
      r4_238 = r4_238 - r1_244 * 0.002
    end
  end
  function spec_onClientVehicleEnterExit(r0_245, r1_245)
    -- line: [383, 387] id: 245
    if getElementData(localPlayer, "spectarget") == r0_245 and r6_238 == "playertarget" then
      setCameraTarget(r0_245)
    end
  end
  function pressControl(r0_246, r1_246)
    -- line: [388, 394] id: 246
    if r1_246 == "down" then
      r7_238[r0_246] = true
    else
      r7_238[r0_246] = nil
    end
  end
  function changeCameraView()
    -- line: [395, 420] id: 247
    if getPlayerTeam(localPlayer) and getElementDimension(localPlayer) ~= 10 then
      local r0_247 = getElementData(localPlayer, "spectarget")
      if r0_247 and getElementAlpha(r0_247) == 0 then
        setElementAlpha(r0_247, 255)
      end
      local r1_247 = r6_238
      setControlState("change_camera", false)
      if r1_247 == "playertarget" then
        r6_238 = "playercamera"
      elseif r1_247 == "playercamera" and getPlayerTeam(localPlayer) == getElementsByType("team")[1] then
        local r2_247, r3_247, r4_247, r5_247, r6_247, r7_247 = getCameraMatrix()
        r2_238 = r4_247
        r1_238 = r3_247
        r0_238 = r2_247
        local r8_247 = getDistanceBetweenPoints3D(r2_247, r3_247, r4_247, r5_247, r6_247, r7_247)
        r4_238 = math.asin((r7_247 - r4_247) / r8_247)
        local r9_247 = math.abs(r5_247 - r2_247)
        if r9_247 ~= 0 then
          r9_247 = math.cos(r4_238)
          if r9_247 ~= 0 then
            r9_247 = (r5_247 - r2_247) / math.abs((r5_247 - r2_247)) * math.acos((r6_247 - r3_247) / r8_247 * math.cos(r4_238)) or 0
          end
        else
          goto label_98	-- block#12 is visited secondly
        end
        r3_238 = r9_247
        setElementData(localPlayer, "spectarget", nil)
        r6_238 = "freecamera"
      elseif r1_247 == "freecamera" then
        r6_238 = "playertarget"
        switchSpectating()
      else
        r6_238 = "playertarget"
      end
      playSoundFrontEnd(11)
      triggerEvent("onClientCameraSpectateModeChange", localPlayer, r1_247, r0_247)
    end
  end
  local r11_238 = {
    [24] = 2.3,
    [29] = 0.3,
    [30] = 0.5,
    [31] = 0.15,
  }
  local r12_238 = {
    [24] = 0.7,
    [29] = 0.03,
    [30] = 0.08,
  }
  function spec_onClientPlayerWeaponFire(r0_248, r1_248, r2_248, r3_248, r4_248, r5_248, r6_248)
    -- line: [423, 435] id: 248
    if getElementData(localPlayer, "spectarget") == source and r12_238[r0_248] then
      r8_238 = r8_238 + r12_238[r0_248]
    end
    -- warn: not visited block [3]
    -- block#3:
    -- _u1 = _u1 + _u0[r0_248]
    -- goto label_31
  end
  local r13_238 = nil
  function onClientElementDataChange(r0_249, r1_249)
    -- line: [437, 552] id: 249
    if getElementData(localPlayer, "Status") == "Spectate" and getElementData(localPlayer, "spectarget") == source and r0_249 == "Status" and getElementData(source, r0_249) == "Spectate" then
      switchSpectating()
    end
    if getElementData(localPlayer, "Status") == "Spectate" and r6_238 ~= "freecamera" and not getElementData(localPlayer, "spectarget") and r0_249 == "Status" and getElementData(source, r0_249) == "Play" then
      setCameraSpectating(source)
    end
    if source == localPlayer and r0_249 == "Status" then
      local r2_249 = getElementData(source, r0_249)
      if r2_249 == "Spectate" and r1_249 ~= "Spectate" then
        if getPlayerTeam(localPlayer) == getElementsByType("team")[1] or getElementData(localPlayer, "spectateskin") then
          setElementPosition(localPlayer, 0, 0, 0)
        end
        if r6_238 == "freecamera" and getPlayerTeam(localPlayer) ~= getElementsByType("team")[1] then
          r6_238 = "playertarget"
        end
        setElementFrozen(localPlayer, true)
        toggleAllControls(false, true, false)
        toggleControl("enter_passenger", false)
        if not getCameraTarget() or r6_238 == "freecamera" then
          local r3_249, r4_249, r5_249, r6_249, r7_249, r8_249 = getCameraMatrix()
          local r9_249 = getDistanceBetweenPoints3D(r3_249, r4_249, r5_249, r6_249, r7_249, r8_249)
          r2_238 = r5_249
          r1_238 = r4_249
          r0_238 = r3_249
          r4_238 = math.asin((r8_249 - r5_249) / r9_249)
          local r10_249 = math.abs(r6_249 - r3_249)
          if r10_249 ~= 0 then
            r10_249 = math.cos(r4_238)
            if r10_249 ~= 0 then
              r10_249 = (r6_249 - r3_249) / math.abs((r6_249 - r3_249)) * math.acos((r7_249 - r4_249) / r9_249 * math.cos(r4_238)) or 0
            end
          else
            goto label_170	-- block#26 is visited secondly
          end
          r3_238 = r10_249
        end
        r7_238 = {}
        bindKey("forwards", "both", pressControl)
        bindKey("backwards", "both", pressControl)
        bindKey("left", "both", pressControl)
        bindKey("right", "both", pressControl)
        bindKey("jump", "both", pressControl)
        bindKey("crouch", "both", pressControl)
        bindKey("sprint", "both", pressControl)
        bindKey("walk", "both", pressControl)
        bindKey("q", "down", switchSpectating)
        bindKey("e", "down", switchSpectating)
        bindKey("arrow_l", "down", switchSpectating)
        bindKey("arrow_r", "down", switchSpectating)
        bindKey("change_camera", "down", changeCameraView)
        addEventHandler("onClientPreRender", root, spec_onClientPreRender)
        addEventHandler("onClientCursorMove", root, spec_onClientCursorMove)
        addEventHandler("onClientVehicleEnter", root, spec_onClientVehicleEnterExit)
        addEventHandler("onClientVehicleExit", root, spec_onClientVehicleEnterExit)
        addEventHandler("onClientVehicleStartExit", root, spec_onClientVehicleEnterExit)
        addEventHandler("onClientPlayerWeaponFire", root, spec_onClientPlayerWeaponFire)
        addEventHandler("onClientTacticsChange", root, spec_onClientTacticsChange)
        r13_238 = outputInfo(string.format(getLanguageString("help_spectate"), string.upper(next(getBoundKeys("change_camera")))))
        if not getElementData(localPlayer, "Loading") then
          fadeCamera(true, 2)
        end
        triggerEvent("onClientCameraSpectateStart", localPlayer)
      elseif r2_249 ~= "Spectate" and r1_249 == "Spectate" then
        if guiGetVisible(aim_m4) then
          guiSetVisible(aim_m4, false)
        end
        if guiGetVisible(aim_rocket) then
          guiSetVisible(aim_rocket, false)
        end
        if guiGetVisible(aim_sniper) then
          guiSetVisible(aim_sniper, false)
        end
        unbindKey("forwards", "both", pressControl)
        unbindKey("backwards", "both", pressControl)
        unbindKey("left", "both", pressControl)
        unbindKey("right", "both", pressControl)
        unbindKey("jump", "both", pressControl)
        unbindKey("crouch", "both", pressControl)
        unbindKey("sprint", "both", pressControl)
        unbindKey("walk", "both", pressControl)
        unbindKey("q", "down", switchSpectating)
        unbindKey("e", "down", switchSpectating)
        unbindKey("arrow_l", "down", switchSpectating)
        unbindKey("arrow_r", "down", switchSpectating)
        unbindKey("change_camera", "down", changeCameraView)
        removeEventHandler("onClientPreRender", root, spec_onClientPreRender)
        removeEventHandler("onClientCursorMove", root, spec_onClientCursorMove)
        removeEventHandler("onClientVehicleEnter", root, spec_onClientVehicleEnterExit)
        removeEventHandler("onClientVehicleExit", root, spec_onClientVehicleEnterExit)
        removeEventHandler("onClientVehicleStartExit", root, spec_onClientVehicleEnterExit)
        removeEventHandler("onClientPlayerWeaponFire", root, spec_onClientPlayerWeaponFire)
        removeEventHandler("onClientTacticsChange", root, spec_onClientTacticsChange)
        if getRoundState() == "started" and getPlayerTeam(localPlayer) ~= getElementsByType("team")[1] and not getElementData(localPlayer, "spectateskin") then
          setElementFrozen(localPlayer, false)
          toggleAllControls(true)
        end
        setCameraTarget(localPlayer)
        local r3_249 = getElementData(localPlayer, "spectarget")
        setElementData(localPlayer, "spectarget", nil)
        if guiGetVisible(aim_m4) then
          guiSetVisible(aim_m4, false)
        end
        if guiGetVisible(aim_rocket) then
          guiSetVisible(aim_rocket, false)
        end
        if guiGetVisible(aim_sniper) then
          guiSetVisible(aim_sniper, false)
        end
        if guiGetVisible(aim_sniper2) then
          guiSetVisible(aim_sniper2, false)
        end
        if r13_238 then
          hideInfo(r13_238)
        end
        triggerEvent("onClientCameraSpectateStop", localPlayer, r3_249, r6_238)
        if isElement(r3_249) and getElementAlpha(r3_249) == 0 then
          setElementAlpha(r3_249, 255)
        end
      end
    end
    if r0_249 == "spectarget" then
      if source == localPlayer and getElementData(localPlayer, "Status") == "Spectate" then
        triggerEvent("onClientCameraSpectateTargetChange", localPlayer, r1_249)
        if isElement(r1_249) and getElementAlpha(r1_249) == 0 then
          setElementAlpha(r1_249, 255)
        end
      end
      local r2_249 = getElementData(localPlayer, "Status")
      if r2_249 ~= "Spectate" then
        r2_249 = localPlayer or getElementData(localPlayer, "spectarget")
      else
        goto label_577	-- block#64 is visited secondly
      end
      if getElementData(source, r0_249) == r2_249 or r1_249 == r2_249 then
        updateSpectatorsList()
      elseif source == localPlayer then
        updateSpectatorsList()
      end
    end
    if r0_249 == "laseraim" and isElementStreamedIn(source) then
      if getElementData(source, r0_249) and not laseraimRender[source] then
        if not next(laseraimRender) and guiCheckBoxGetSelected(config_performance_laser) then
          addEventHandler("onClientHUDRender", root, onClientLaseraimRender)
        end
        local r2_249, r3_249, r4_249 = getElementPosition(source)
        laseraimRender[source] = createMarker(r2_249, r3_249, r4_249, "corona", 0.5, 0, 0, 0, 0)
        if source == localPlayer then
          showPlayerHudComponent("crosshair", false)
        end
      elseif laseraimRender[source] then
        if source == localPlayer then
          showPlayerHudComponent("crosshair", true)
        end
        destroyElement(laseraimRender[source])
        laseraimRender[source] = nil
        if not next(laseraimRender) and guiCheckBoxGetSelected(config_performance_laser) then
          removeEventHandler("onClientHUDRender", root, onClientLaseraimRender)
        end
      end
    end
  end
  function onClientElementStreamIn()
    -- line: [553, 559] id: 250
    if getElementData(source, "laseraim") and not laseraimRender[source] then
      if not next(laseraimRender) and guiCheckBoxGetSelected(config_performance_laser) then
        addEventHandler("onClientHUDRender", root, onClientLaseraimRender)
      end
      local r0_250, r1_250, r2_250 = getElementPosition(source)
      laseraimRender[source] = createMarker(r0_250, r1_250, r2_250, "corona", 0.2, 0, 0, 0, 0)
    end
  end
  function onClientElementStreamOut()
    -- line: [560, 566] id: 251
    if getElementData(source, "laseraim") and laseraimRender[source] then
      destroyElement(laseraimRender[source])
      laseraimRender[source] = nil
      if not next(laseraimRender) and guiCheckBoxGetSelected(config_performance_laser) then
        removeEventHandler("onClientHUDRender", root, onClientLaseraimRender)
      end
    end
  end
  function onClientLaseraimRender()
    -- line: [567, 607] id: 252
    for r3_252, r4_252 in pairs(laseraimRender) do
      local r5_252 = getPedWeapon(r3_252)
      if 22 <= r5_252 and r5_252 <= 38 then
        local r6_252, r7_252, r8_252 = getPedWeaponMuzzlePosition(r3_252)
        local r9_252, r10_252, r11_252, r12_252, r13_252, r14_252, r15_252 = getPedTargetCollision(r3_252)
        local r16_252, r17_252, r18_252 = getPedTargetEnd(r3_252)
        local r19_252 = getDistanceBetweenPoints3D(r6_252, r7_252, r8_252, r16_252, r17_252, r18_252)
        if not getPedControlState(r3_252, "aim_weapon") or not getPedTask(r3_252, "secondary", 0) == "TASK_SIMPLE_USE_GUN" then
          local r20_252, r21_252, r22_252 = getPedBonePosition(r3_252, 24)
          local r23_252 = getDistanceBetweenPoints3D(r6_252, r7_252, r8_252, r20_252, r21_252, r22_252)
          r18_252 = r8_252 + r19_252 * (r8_252 - r22_252) / r23_252
          r17_252 = r7_252 + r19_252 * (r7_252 - r21_252) / r23_252
          r16_252 = r6_252 + r19_252 * (r6_252 - r20_252) / r23_252
          r12_252, r9_252, r10_252, r11_252, _, r13_252, r14_252, r15_252 = processLineOfSight(r6_252, r7_252, r8_252, r16_252, r17_252, r18_252, true, true, true, false, false, false, true, false, r3_252)
        elseif r9_252 then
          local r20_252 = getDistanceBetweenPoints3D(r6_252, r7_252, r8_252, r9_252, r10_252, r11_252)
          local r21_252 = (r6_252 - r9_252) / r20_252
          local r22_252 = (r7_252 - r10_252) / r20_252
          local r23_252 = (r8_252 - r11_252) / r20_252
          r12_252, r9_252, r10_252, r11_252, _, r13_252, r14_252, r15_252 = processLineOfSight(r9_252 + r21_252, r10_252 + r22_252, r11_252 + r23_252, r9_252 - r21_252, r10_252 - r22_252, r11_252 - r23_252, true, true, true, false, false, false, true, false, r3_252)
        end
        local r20_252 = dxDrawLine3D
        local r21_252 = r6_252
        local r22_252 = r7_252
        local r23_252 = r8_252
        local r24_252 = r9_252 or r16_252
        local r25_252 = r10_252 or r17_252
        r20_252(r21_252, r22_252, r23_252, r24_252, r25_252, r11_252 or r18_252, 1090453504)
        if r9_252 and r13_252 then
          r20_252 = math.rad(getAngleBetweenPoints2D(0, 0, r13_252, r14_252))
          r9_252 = r9_252 + 0.01 * r13_252
          r10_252 = r10_252 + 0.01 * r14_252
          r11_252 = r11_252 + 0.01 * r15_252
          r21_252 = 0.05 * r15_252 * math.sin(r20_252)
          r22_252 = -0.05 * r15_252 * math.cos(r20_252)
          r23_252 = 0.05 * math.sqrt((r13_252 ^ 2 + r14_252 ^ 2))
          dxDrawMaterialLine3D(r9_252, r10_252, r11_252, r9_252, r10_252, r11_252, laseraimTexture, 0, 0)
          dxDrawMaterialLine3D(r9_252 - r21_252, r10_252 - r22_252, r11_252 - r23_252, r9_252 + r21_252, r10_252 + r22_252, r11_252 + r23_252, laseraimTexture, 0.1, 4294901760, r9_252 - r21_252 + r13_252, r10_252 - r22_252 + r14_252, r11_252 - r23_252 + r15_252)
          setElementPosition(r4_252, r9_252, r10_252, r11_252)
          setMarkerColor(r4_252, 255, 0, 0, 32)
        else
          setMarkerColor(r4_252, 0, 0, 0, 0)
          setElementPosition(r4_252, getElementPosition(r3_252))
        end
      else
        setMarkerColor(r4_252, 0, 0, 0, 0)
        setElementPosition(r4_252, getElementPosition(r3_252))
      end
    end
  end
  function toggleLaseraim()
    -- line: [608, 616] id: 253
    if getControlState("aim_weapon") and getPedTask(localPlayer, "secondary", 0) == "TASK_SIMPLE_USE_GUN" then
      if getElementData(localPlayer, "laseraim") then
        setElementData(localPlayer, "laseraim", nil)
      else
        setElementData(localPlayer, "laseraim", true)
      end
    end
  end
  function onClientPlayerQuit()
    -- line: [617, 628] id: 254
    if laseraimRender[source] then
      destroyElement(laseraimRender[source])
      laseraimRender[source] = nil
      if not next(laseraimRender) and guiCheckBoxGetSelected(config_performance_laser) then
        removeEventHandler("onClientHUDRender", root, onClientLaseraimRender)
      end
    end
    if getElementData(source, "Status") == "Spectate" and (getElementData(source, "spectarget") == getElementData(localPlayer, "spectarget") or getElementData(source, "spectarget") == localPlayer) then
      setTimer(updateSpectatorsList, 50, 1)
    end
  end
  function onClientPlayerChangeNick(r0_255, r1_255)
    -- line: [629, 635] id: 255
    if getElementData(source, "Status") == "Spectate" and (getElementData(source, "spectarget") == getElementData(localPlayer, "spectarget") or getElementData(source, "spectarget") == localPlayer) then
      updateSpectatorsList()
    end
  end
  function updateSpectatorsList()
    -- line: [636, 648] id: 256
    local r0_256 = getElementData(localPlayer, "Status")
    if r0_256 ~= "Spectate" then
      r0_256 = localPlayer or getElementData(localPlayer, "spectarget")
    else
      goto label_9	-- block#2 is visited secondly
    end
    if not r0_256 then
      return guiSetVisible(speclist, false)
    end
    local r1_256 = ""
    for r5_256, r6_256 in ipairs(getElementsByType("player")) do
      if getElementData(r6_256, "Status") == "Spectate" and getElementData(r6_256, "spectarget") == r0_256 then
        r1_256 = r1_256 .. "\n" .. removeColorCoding(getPlayerName(r6_256))
      end
    end
    if string.len(r1_256) == 0 then
      return guiSetVisible(speclist, false)
    end
    guiSetText(speclist, "Spectation:" .. r1_256)
    guiSetVisible(speclist, true)
  end
  function getCameraSpectateTarget()
    -- line: [649, 651] id: 257
    return getElementData(localPlayer, "spectarget")
  end
  function getCameraSpectateMode()
    -- line: [652, 654] id: 258
    return r6_238
  end
  function spec_onClientTacticsChange(r0_259, r1_259)
    -- line: [655, 664] id: 259
    if r0_259[1] == "settings" and r0_259[2] == "spectate_enemy" and r6_238 ~= "freecamera" then
      local r2_259 = getElementData(localPlayer, "spectarget")
      if not r2_259 or not isElement(r2_259) then
        switchSpectating()
      end
    end
  end
  addEvent("onClientCameraSpectateStart")
  addEvent("onClientCameraSpectateStop")
  addEvent("onClientCameraSpectateTargetChange")
  addEvent("onClientCameraSpectateModeChange")
  addEventHandler("onClientResourceStart", resourceRoot, onClientResourceStart)
  addEventHandler("onClientElementDataChange", root, onClientElementDataChange)
  addEventHandler("onClientPlayerQuit", root, onClientPlayerQuit)
  addEventHandler("onClientPlayerChangeNick", root, onClientPlayerChangeNick)
  addEventHandler("onClientElementStreamIn", root, onClientElementStreamIn)
  addEventHandler("onClientElementStreamOut", root, onClientElementStreamOut)
  addCommandHandler("laser_aim", toggleLaseraim)
  bindKey("F", "down", "laser_aim")
end)()
(function(...)
  -- line: [0, 0] id: 260
  local r0_260 = 0
  local r1_260 = {}
  local r2_260 = {}
  function onClientResourceStart(r0_261)
    -- line: [10, 28] id: 261
    tab_window = guiCreateGridList(0.5 * xscreen - 280, 0.5 * yscreen - 180, 560, 360, false)
    guiSetAlpha(tab_window, 0.8)
    guiSetVisible(tab_window, false)
    tab_label1 = guiCreateLabel(10, 0, 550, 20, "", false, tab_window)
    tab_label2 = guiCreateLabel(0, 0, 550, 20, "", false, tab_window)
    guiLabelSetHorizontalAlign(tab_label2, "right")
    guiLabelSetVerticalAlign(tab_label1, "center")
    guiLabelSetVerticalAlign(tab_label2, "center")
    tab_list = guiCreateGridList(5, 20, 535, 355, false, tab_window)
    guiGridListSetSortingEnabled(tab_list, false)
    tab_id = guiGridListAddColumn(tab_list, "ID", 0.06)
    tab_name = guiGridListAddColumn(tab_list, "Name", 0.24)
    tab_score = guiGridListAddColumn(tab_list, "Score", 0.07)
    tab_status = guiGridListAddColumn(tab_list, "Status", 0.1)
    tab_fps = guiGridListAddColumn(tab_list, "FPS", 0.06)
    tab_packet = guiGridListAddColumn(tab_list, "Loss", 0.06)
    tab_ping = guiGridListAddColumn(tab_list, "Ping", 0.06)
  end
  function onClientTabboardChange(r0_262, r1_262, r2_262, r3_262)
    -- line: [29, 46] id: 262
    if r1_262 then
      r0_260 = r2_262
      guiSetText(tab_label1, r1_262 .. " [" .. r3_262.os .. "]")
      guiSetText(tab_label2, #getElementsByType("player") .. "/" .. r2_262)
    end
    if not tab_packet then
      return 
    end
    for r7_262, r8_262 in pairs(r1_260) do
      guiGridListRemoveColumn(tab_list, tab_packet + 1)
    end
    guiGridListRemoveColumn(tab_list, tab_packet + 1)
    r1_260 = {}
    for r7_262, r8_262 in ipairs(r0_262) do
      r1_260[r8_262[1]] = guiGridListAddColumn(tab_list, r8_262[1], r8_262[2])
    end
    tab_ping = guiGridListAddColumn(tab_list, "Ping", 0.06)
    if guiGetVisible(tab_window) then
      refreshElements()
    end
  end
  function refreshElements()
    -- line: [47, 126] id: 263
    guiSetText(tab_label2, #getElementsByType("player") .. "/" .. r0_260)
    guiGridListClear(tab_list)
    r2_260 = {}
    for r3_263, r4_263 in ipairs(getElementsByType("player")) do
      if not getPlayerTeam(r4_263) then
        r2_260[r4_263] = guiGridListAddRow(tab_list)
        guiGridListSetItemText(tab_list, r2_260[r4_263], tab_id, getElementID(r4_263) or "", false, false)
        guiGridListSetItemText(tab_list, r2_260[r4_263], tab_name, removeColorCoding(getPlayerName(r4_263)), false, false)
        local r5_263 = guiGridListSetItemText
        local r6_263 = tab_list
        local r7_263 = r2_260[r4_263]
        local r8_263 = tab_score
        local r9_263 = getElementData(r4_263, "Score")
        if r9_263 then
          r9_263 = tostring(getElementData(r4_263, "Score")) or ""
        else
          goto label_77	-- block#6 is visited secondly
        end
        r5_263(r6_263, r7_263, r8_263, r9_263, false, false)
        r5_263 = getElementData(r4_263, "Status") or ""
        if r5_263 == "Play" and getTacticsData("settings", "player_information") == "true" then
          r5_263 = tostring(math.floor(getElementHealth(r4_263) + getPedArmor(r4_263)))
        end
        if r5_263 == "Spectate" then
          r5_263 = ""
        end
        if getElementData(r4_263, "Loading") then
          r5_263 = "Loading"
        end
        guiGridListSetItemText(tab_list, r2_260[r4_263], tab_status, r5_263, false, false)
        guiGridListSetItemText(tab_list, r2_260[r4_263], tab_fps, tostring(getElementData(r4_263, "FPS") or ""), false, false)
        guiGridListSetItemText(tab_list, r2_260[r4_263], tab_packet, string.format("%.2f", getElementData(r4_263, "PLoss") or 0), false, false)
        guiGridListSetItemText(tab_list, r2_260[r4_263], tab_ping, tostring(getPlayerPing(r4_263)), false, false)
        for r9_263, r10_263 in pairs(r1_260) do
          local r11_263 = guiGridListSetItemText
          local r12_263 = tab_list
          local r13_263 = r2_260[r4_263]
          local r14_263 = r10_263
          local r15_263 = getElementData(r4_263, r9_263)
          if r15_263 then
            r15_263 = tostring(getElementData(r4_263, r9_263)) or ""
          else
            goto label_200	-- block#23 is visited secondly
          end
          r11_263(r12_263, r13_263, r14_263, r15_263, false, false)
        end
      end
    end
    local r0_263 = getElementsByType("team")
    table.insert(r0_263, r0_263[1])
    table.remove(r0_263, 1)
    for r4_263, r5_263 in ipairs(r0_263) do
      local r6_263, r7_263, r8_263 = getTeamColor(r5_263)
      r2_260[r5_263] = guiGridListAddRow(tab_list)
      local r9_263 = guiGridListSetItemText
      local r10_263 = tab_list
      local r11_263 = r2_260[r5_263]
      local r12_263 = tab_score
      local r13_263 = getElementData(r5_263, "Score")
      if r13_263 then
        r13_263 = tostring(getElementData(r5_263, "Score")) or ""
      else
        goto label_252	-- block#30 is visited secondly
      end
      r9_263(r10_263, r11_263, r12_263, r13_263, true, false)
      for r12_263, r13_263 in pairs(r1_260) do
        if getElementData(r5_263, r12_263) then
          guiGridListSetItemText(tab_list, r2_260[r5_263], r13_263, tostring(getElementData(r5_263, r12_263)), true, false)
        end
      end
      r9_263 = 0
      for r13_263, r14_263 in ipairs(getPlayersInTeam(r5_263)) do
        r2_260[r14_263] = guiGridListAddRow(tab_list)
        guiGridListSetItemText(tab_list, r2_260[r14_263], tab_id, getElementID(r14_263) or "", false, false)
        guiGridListSetItemText(tab_list, r2_260[r14_263], tab_name, removeColorCoding(getPlayerName(r14_263)), false, false)
        guiGridListSetItemColor(tab_list, r2_260[r14_263], tab_name, r6_263, r7_263, r8_263)
        local r15_263 = guiGridListSetItemText
        local r16_263 = tab_list
        local r17_263 = r2_260[r14_263]
        local r18_263 = tab_score
        local r19_263 = getElementData(r14_263, "Score")
        if r19_263 then
          r19_263 = tostring(getElementData(r14_263, "Score")) or ""
        else
          goto label_349	-- block#40 is visited secondly
        end
        r15_263(r16_263, r17_263, r18_263, r19_263, false, false)
        r15_263 = getElementData(r14_263, "Status") or ""
        if r15_263 == "Play" then
          r9_263 = r9_263 + 1
          if getTacticsData("settings", "player_information") == "true" then
            if r4_263 < #r0_263 then
              r15_263 = tostring(math.floor(getElementHealth(r14_263) + getPedArmor(r14_263))) or ""
            else
              goto label_386	-- block#47 is visited secondly
            end
          end
        end
        if r15_263 == "Spectate" then
          r15_263 = ""
        end
        if getElementData(r14_263, "Loading") then
          r15_263 = "Loading"
        end
        guiGridListSetItemText(tab_list, r2_260[r14_263], tab_status, r15_263, false, false)
        guiGridListSetItemText(tab_list, r2_260[r14_263], tab_fps, tostring(getElementData(r14_263, "FPS") or ""), false, false)
        guiGridListSetItemText(tab_list, r2_260[r14_263], tab_packet, string.format("%.2f", getElementData(r14_263, "PLoss") or 0), false, false)
        guiGridListSetItemText(tab_list, r2_260[r14_263], tab_ping, tostring(getPlayerPing(r14_263)), false, false)
        for r19_263, r20_263 in pairs(r1_260) do
          local r21_263 = guiGridListSetItemText
          local r22_263 = tab_list
          local r23_263 = r2_260[r14_263]
          local r24_263 = r20_263
          local r25_263 = #r0_263
          if r4_263 < r25_263 then
            r25_263 = getElementData(r14_263, r19_263) and (tostring(getElementData(r14_263, r19_263)) or "")
          else
            goto label_481	-- block#60 is visited secondly
          end
          r21_263(r22_263, r23_263, r24_263, r25_263, false, false)
        end
      end
      if r4_263 < #r0_263 then
        r10_263 = getTacticsData("Teamsides") or {}
        r11_263 = getTacticsData("SideNames") or {}
        r12_263 = ""
        if r10_263[r5_263] then
          r12_263 = r11_263[(r10_263[r5_263] - 1) % #r11_263 + 1]
        end
        guiGridListSetItemText(tab_list, r2_260[r5_263], tab_name, getTeamName(r5_263) .. " (" .. r12_263 .. ")", true, false)
        guiGridListSetItemText(tab_list, r2_260[r5_263], tab_status, r9_263 .. " / " .. countPlayersInTeam(r5_263), true, false)
        guiGridListSetItemColor(tab_list, r2_260[r5_263], tab_status, r6_263, r7_263, r8_263)
      else
        guiGridListSetItemText(tab_list, r2_260[r5_263], tab_name, getTeamName(r5_263), true, false)
      end
      guiGridListSetItemColor(tab_list, r2_260[r5_263], tab_name, r6_263, r7_263, r8_263)
    end
    guiGridListSetSelectedItem(tab_list, r2_260[localPlayer], tab_name)
    local r2_263 = math.min(14 * guiGridListGetRowCount(tab_list) + 60, yscreen)
    local r3_263, r4_263 = guiGetSize(tab_list, false)
    if r2_263 ~= r4_263 then
      guiSetSize(tab_window, 560, r2_263, false)
      guiSetPosition(tab_window, 0.5 * xscreen - 280, 0.5 * yscreen - 0.5 * r2_263, false)
      guiSetSize(tab_list, 550, r2_263 - 20 - 5, false)
    end
  end
  function refreshData(r0_264, r1_264, r2_264)
    -- line: [127, 149] id: 264
    if not r2_260[r0_264] then
      return 
    end
    if not r2_264 then
      r2_264 = ""
    else
      r2_264 = tostring(r2_264)
    end
    if getElementType(r0_264) == "team" and r1_260[r1_264] then
      guiGridListSetItemText(tab_list, r2_260[r0_264], r1_260[r1_264], r2_264, true, false)
    elseif r1_264 == "Status" then
      local r3_264 = getElementData(r0_264, "Status") or ""
      if r3_264 == "Play" and getTacticsData("settings", "player_information") == "true" then
        r3_264 = tostring(math.floor(getElementHealth(r0_264) + getPedArmor(r0_264)))
      end
      if r3_264 == "Spectate" then
        r3_264 = ""
      end
      if getElementData(r0_264, "Loading") then
        r3_264 = "Loading"
      end
      guiGridListSetItemText(tab_list, r2_260[r0_264], tab_status, r3_264, false, false)
    elseif r1_264 == "FPS" then
      guiGridListSetItemText(tab_list, r2_260[r0_264], tab_fps, r2_264, false, false)
    elseif r1_264 == "PLoss" then
      guiGridListSetItemText(tab_list, r2_260[r0_264], tab_packet, string.format("%.2f", r2_264 or 0), false, false)
    elseif r1_260[r1_264] then
      guiGridListSetItemText(tab_list, r2_260[r0_264], r1_260[r1_264], r2_264, false, false)
    end
  end
  function refreshPings()
    -- line: [150, 159] id: 265
    local r0_265 = getElementsByType("team")[1]
    for r4_265, r5_265 in ipairs(getElementsByType("player")) do
      if getElementData(r5_265, "Status") == "Play" and getPlayerTeam(r5_265) ~= r0_265 and getTacticsData("settings", "player_information") == "true" and not getElementData(r5_265, "Loading") then
        guiGridListSetItemText(tab_list, r2_260[r5_265], tab_status, tostring(math.floor(getElementHealth(r5_265) + getPedArmor(r5_265))), false, false)
      end
      guiGridListSetItemText(tab_list, r2_260[r5_265], tab_ping, tostring(getPlayerPing(r5_265)), false, false)
    end
    if guiGetVisible(tab_list) then
      setTimer(refreshPings, 500, 1)
    end
  end
  function toggleTabboard(r0_266, r1_266)
    -- line: [160, 180] id: 266
    if not guiGetVisible(tab_window) and r1_266 == "down" then
      refreshElements()
      setTimer(refreshPings, 500, 1)
      guiBringToFront(tab_window)
      guiSetVisible(tab_window, true)
      addEventHandler("onClientElementDataChange", root, refreshElementData)
      addEventHandler("onClientPlayerChangeNick", root, refreshNick)
      addEventHandler("onClientPlayerJoin", root, refreshElements)
      addEventHandler("onClientPlayerQuit", root, refreshQuit)
      bindKey("mouse2", "both", toggleCursor)
    elseif guiGetVisible(tab_window) and r1_266 == "up" then
      removeEventHandler("onClientElementDataChange", root, refreshElementData)
      removeEventHandler("onClientPlayerChangeNick", root, refreshNick)
      removeEventHandler("onClientPlayerJoin", root, refreshElements)
      removeEventHandler("onClientPlayerQuit", root, refreshQuit)
      unbindKey("mouse2", "both", toggleCursor)
      guiSetVisible(tab_window, false)
      if getKeyState("mouse2") and isAllGuiHidden() then
        showCursor(false)
      end
    end
  end
  function toggleCursor(r0_267, r1_267)
    -- line: [181, 187] id: 267
    if guiGetVisible(tab_list) and r1_267 == "down" then
      showCursor(true)
    elseif guiGetVisible(tab_list) and r1_267 == "up" and isAllGuiHidden() then
      showCursor(false)
    end
  end
  function refreshElementData(r0_268, r1_268)
    -- line: [188, 196] id: 268
    if getElementType(source) == "team" or getElementType(source) == "player" then
      if r0_268 == "Loading" then
        refreshData(source, "Status")
      else
        refreshData(source, r0_268, getElementData(source, r0_268))
      end
    end
  end
  function refreshNick(r0_269, r1_269)
    -- line: [197, 199] id: 269
    guiGridListSetItemText(tab_list, r2_260[source], tab_name, removeColorCoding(r1_269), false, false)
  end
  function refreshQuit()
    -- line: [200, 202] id: 270
    setTimer(refreshElements, 50, 1)
  end
  addEvent("onClientTabboardChange", true)
  addEventHandler("onClientResourceStart", resourceRoot, onClientResourceStart)
  addEventHandler("onClientTabboardChange", root, onClientTabboardChange)
  bindKey("tab", "both", toggleTabboard)
end)()
(function(...)
  -- line: [0, 0] id: 271
  local r0_271 = {
    invulnerable = true,
    invisible = true,
    freezable = true,
    flammable = true,
    movespeed = true,
    regenerable = true,
  }
  local r1_271 = {
    freezable = 0,
    flammable = 0,
  }
  local r2_271 = {}
  function setPlayerProperty(r0_272, r1_272)
    -- line: [15, 24] id: 272
    if not r0_271[r0_272] then
      return false
    end
    local r2_272 = getElementData(localPlayer, "Properties") or {}
    if r1_272 ~= nil and r1_272 ~= false then
      r2_272[r0_272] = r1_272
    else
      r2_272[r0_272] = nil
    end
    return setElementData(localPlayer, "Properties", r2_272)
  end
  function givePlayerProperty(r0_273, r1_273, r2_273)
    -- line: [25, 34] id: 273
    if not r0_271[r0_273] then
      return false
    end
    local r3_273 = getElementData(localPlayer, "Properties") or {}
    if r1_273 ~= nil and r1_273 ~= false then
      r3_273[r0_273] = {
        r1_273,
        r2_273
      }
    else
      r3_273[r0_273] = nil
    end
    return setElementData(localPlayer, "Properties", r3_273)
  end
  function getPlayerProperty(r0_274, r1_274)
    -- line: [35, 42] id: 274
    if not r0_274 or not isElement(r0_274) or not r0_271[r1_274] then
      return false
    end
    local r2_274 = getElementData(localPlayer, "Properties") or {}
    if type(r2_274[r1_274]) == "table" then
      return unpack(r2_274[r1_274])
    end
    return r2_274[r1_274]
  end
  function onClientPlayerInvulnerable(r0_275, r1_275, r2_275, r3_275)
    -- line: [43, 45] id: 275
    cancelEvent()
  end
  function onClientMovespeedRender()
    -- line: [46, 70] id: 276
    local r0_276 = type(r2_271.movespeed)
    if r0_276 == "table" then
      r0_276 = r2_271.movespeed[1] or r2_271.movespeed
    else
      goto label_11	-- block#2 is visited secondly
    end
    local r1_276 = 1000 / getElementData(localPlayer, "FPS") * getGameSpeed()
    local r2_276, r3_276 = getElementVelocity(localPlayer)
    local r4_276 = getPedContactElement(localPlayer)
    if r4_276 then
      local r5_276, r6_276 = getElementVelocity(r4_276)
      r3_276 = r3_276 - r6_276
      r2_276 = r2_276 - r5_276
    end
    if math.sqrt(r2_276 ^ 2 + r3_276 ^ 2) > 0.02 then
      local r5_276, r6_276, r7_276 = getElementPosition(localPlayer)
      local r8_276 = r5_276 + (r0_276 - 1) * r1_276 * 200 * r2_276 / 3600
      local r9_276 = r6_276 + (r0_276 - 1) * r1_276 * 200 * r3_276 / 3600
      local r10_276 = r7_276
      if r4_276 then
        local r11_276, r12_276, r13_276 = getElementVelocity(r4_276)
        r8_276 = r8_276 + r1_276 * 200 * r11_276 / 3600
        r9_276 = r9_276 + r1_276 * 200 * r12_276 / 3600
        r10_276 = r10_276 + r1_276 * 200 * r13_276 / 3600
      end
      if isLineOfSightClear(r5_276, r6_276, r7_276, r8_276, r9_276, r10_276, true, true, true, true, true, false, false, localPlayer) then
        setElementPosition(localPlayer, r8_276, r9_276, r10_276, false)
      end
    end
  end
  function onClientPropertiesRender(r0_277)
    -- line: [71, 120] id: 277
    local r1_277 = r0_277 * getGameSpeed()
    local r2_277 = xscreen * 0.06
    for r6_277, r7_277 in pairs(r2_271) do
      local r8_277 = "images/" .. r6_277 .. ".png"
      local r9_277 = unpack
      local r10_277 = type(r7_277)
      if r10_277 == "table" then
        r10_277 = r7_277
        if r10_277 then
          ::label_21::
          r10_277 = {}
          local r11_277 = r7_277
          -- setlist for #10 failed
        end
      else
        goto label_21	-- block#3 is visited secondly
      end
      local r9_277, r10_277, r11_277 = r9_277(r10_277)
      if r6_277 == "invulnerable" then
        setElementHealth(localPlayer, tonumber(getTacticsData("settings", "player_start_health")))
      elseif r6_277 == "movespeed" then
        if r9_277 < 1 then
          r8_277 = "images/speeddown.png" or "images/speedup.png"
        else
          goto label_45	-- block#9 is visited secondly
        end
      elseif r6_277 == "regenerable" then
        setElementHealth(localPlayer, getElementHealth(localPlayer) + 0.001 * r9_277 * r1_277)
      end
      local r12_277 = nil
      if r11_277 then
        r10_277 = math.max(r10_277 - r1_277, 0)
        r2_271[r6_277] = {
          r9_277,
          r10_277,
          r11_277
        }
        r12_277 = r10_277 / r11_277
        if r12_277 <= 0 then
          r12_277 = 0
          local r13_277 = getElementData(localPlayer, "Properties") or {}
          r13_277[r6_277] = nil
          setElementData(localPlayer, "Properties", r13_277)
        end
      end
      dxDrawImage(r2_277, yscreen * 0.75 - 32, 32, 32, r8_277, 0, 0, 0, white)
      if r12_277 then
        if r12_277 >= 1 then
          dxDrawImage(r2_277, yscreen * 0.75 - 32, 32, 32, "images/factor_100.png", 0, 0, 0, white)
        elseif r12_277 > 0.5 then
          dxDrawImage(r2_277, yscreen * 0.75 - 32, 32, 32, "images/factor_50.png", 0, 0, 0, white)
          dxDrawImage(r2_277, yscreen * 0.75 - 32, 32, 32, "images/factor_50.png", -360 * (r12_277 - 0.5), 0, 0, white)
        elseif r12_277 > 0.25 then
          dxDrawImage(r2_277, yscreen * 0.75 - 32, 32, 32, "images/factor_25.png", 0, 0, 0, white)
          dxDrawImage(r2_277, yscreen * 0.75 - 32, 32, 32, "images/factor_25.png", -360 * (r12_277 - 0.25), 0, 0, white)
        elseif r12_277 > 0.125 then
          dxDrawImage(r2_277, yscreen * 0.75 - 32, 32, 32, "images/factor_12.png", 0, 0, 0, white)
          dxDrawImage(r2_277, yscreen * 0.75 - 32, 32, 32, "images/factor_12.png", -360 * (r12_277 - 0.125), 0, 0, white)
        elseif r12_277 > 0.0625 then
          dxDrawImage(r2_277, yscreen * 0.75 - 32, 32, 32, "images/factor_6.png", 0, 0, 0, white)
          dxDrawImage(r2_277, yscreen * 0.75 - 32, 32, 32, "images/factor_6.png", -360 * (r12_277 - 0.0625), 0, 0, white)
        elseif r12_277 > 0.03125 then
          dxDrawImage(r2_277, yscreen * 0.75 - 32, 32, 32, "images/factor_3.png", 0, 0, 0, white)
          dxDrawImage(r2_277, yscreen * 0.75 - 32, 32, 32, "images/factor_3.png", -360 * (r12_277 - 0.03125), 0, 0, white)
        end
      end
      r2_277 = r2_277 + 48
    end
  end
  function onClientWallhackRender()
    -- line: [121, 148] id: 278
    if getCameraGoggleEffect() ~= "thermalvision" then
      return 
    end
    local function r0_278(r0_279, r1_279, r2_279)
      -- line: [123, 135] id: 279
      local r3_279, r4_279, r5_279 = getPedBonePosition(r0_279, r1_279)
      local r6_279, r7_279, r8_279 = getPedBonePosition(r0_279, r2_279)
      local r9_279 = getDistanceBetweenPoints3D(r3_279, r4_279, r5_279, getCameraMatrix())
      local r10_279, r11_279 = getScreenFromWorldPosition(r3_279, r4_279, r5_279, 360, false)
      local r12_279, r13_279 = getScreenFromWorldPosition(r6_279, r7_279, r8_279, 360, false)
      if r10_279 and r12_279 then
        local r16_279 = xscreen * 0.3 / math.max(1, r9_279)
        local r18_279 = getAngleBetweenPoints2D(r10_279, r11_279, r12_279, r13_279)
        local r17_279 = math.max(r16_279, 2 * getDistanceBetweenPoints2D(r10_279, r11_279, r12_279, r13_279))
        dxDrawImage((r10_279 + r12_279) / 2 - r16_279 * 0.5, (r11_279 + r13_279) / 2 - r17_279 * 0.5, r16_279, r17_279, "images/sphere.png", r18_279, 0, 0, tocolor(255, 64, 0, 255 / math.max(1, 0.3 * r9_279)))
      end
    end
    for r4_278, r5_278 in ipairs(getElementsByType("player", root, true)) do
      r0_278(r5_278, 6, 7)
      for r9_278 = 2, 4, 1 do
        r0_278(r5_278, r9_278 - 1, r9_278)
      end
      for r9_278 = 22, 25, 1 do
        r0_278(r5_278, r9_278 - 1, r9_278)
      end
      for r9_278 = 32, 35, 1 do
        r0_278(r5_278, r9_278 - 1, r9_278)
      end
      for r9_278 = 42, 44, 1 do
        r0_278(r5_278, r9_278 - 1, r9_278)
      end
      for r9_278 = 52, 54, 1 do
        r0_278(r5_278, r9_278 - 1, r9_278)
      end
    end
  end
  function onClientResourceStart()
    -- line: [149, 156] id: 280
    for r3_280, r4_280 in ipairs(getElementsByType("player")) do
      if (getElementData(localPlayer, "Properties") or {}).invisible then
        setElementAlpha(r4_280, 2)
      end
    end
  end
  function onClientPlayerPropertiesChange(r0_281, r1_281)
    -- line: [157, 169] id: 281
    if getElementType(source) ~= "player" then
      return 
    end
    if r0_281 ~= "Properties" then
      return 
    end
    local r2_281 = getElementData(source, "Properties")
    if not r1_281 or r2_281.invisible ~= r1_281.invisible then
      if r2_281.invisible then
        setElementAlpha(source, 2)
      else
        setElementAlpha(source, 255)
      end
      triggerEvent("onClientPlayerBlipUpdate", source)
    end
  end
  function onClientPropertiesChange(r0_282, r1_282)
    -- line: [170, 207] id: 282
    if r0_282 ~= "Properties" then
      return 
    end
    local r2_282 = getElementData(localPlayer, "Properties")
    if (not r1_282 or next(r1_282)) and not next(r2_282) then
      removeEventHandler("onClientPreRender", root, onClientPropertiesRender)
    end
    for r6_282 in pairs(r0_271) do
      if not r1_282 or type(r2_282[r6_282]) ~= type(r1_282[r6_282]) or type(r2_282[r6_282]) ~= "table" and r2_282[r6_282] ~= r1_282[r6_282] or type(r2_282[r6_282]) == "table" and (r2_282[r6_282][1] ~= r1_282[r6_282][1] or r2_282[r6_282][2] ~= r1_282[r6_282][2]) then
        if r2_282[r6_282] then
          if type(r2_282[r6_282]) == "table" then
            local r7_282, r8_282 = unpack(r2_282[r6_282])
            r2_271[r6_282] = {
              r7_282,
              r8_282,
              r8_282
            }
          else
            r2_271[r6_282] = r2_282[r6_282]
          end
          if not r1_282 or not r1_282[r6_282] then
            if r6_282 == "invulnerable" then
              addEventHandler("onClientPlayerDamage", localPlayer, onClientPlayerInvulnerable)
            end
            if r6_282 == "movespeed" then
              addEventHandler("onClientRender", root, onClientMovespeedRender)
            end
          end
        elseif r1_282 and r1_282[r6_282] then
          if r6_282 == "invulnerable" then
            removeEventHandler("onClientPlayerDamage", localPlayer, onClientPlayerInvulnerable)
          end
          if r6_282 == "movespeed" then
            removeEventHandler("onClientRender", root, onClientMovespeedRender)
          end
          r2_271[r6_282] = nil
        end
      end
    end
    if (not r1_282 or not next(r1_282)) and next(r2_282) then
      addEventHandler("onClientPreRender", root, onClientPropertiesRender)
    end
  end
  addEventHandler("onClientElementDataChange", root, onClientPlayerPropertiesChange)
  addEventHandler("onClientElementDataChange", localPlayer, onClientPropertiesChange)
  addEventHandler("onClientResourceStart", resourceRoot, onClientResourceStart)
  addEventHandler("onClientHUDRender", root, onClientWallhackRender)
end)()
(function(...)
  -- line: [0, 0] id: 283
  local r0_283 = nil	-- notice: implicit variable refs by block#[0]
  local r1_283 = {}
  local r2_283 = nil
  function onClientResourceStart(r0_284)
    -- line: [10, 35] id: 284
    vote_window = guiCreateWindow(0.5 * xscreen - 150, 0.5 * yscreen - 200, 300, 400, "Map manager", false)
    guiWindowSetSizable(vote_window, false)
    guiSetVisible(vote_window, false)
    vote_maps = guiCreateGridList(0.02, 0.12, 0.96, 0.79, true, vote_window)
    guiGridListSetSortingEnabled(vote_maps, false)
    guiGridListAddColumn(vote_maps, "Mode", 0.3)
    guiGridListAddColumn(vote_maps, "Name", 0.6)
    vote_search = guiCreateEdit(0.02, 0.06, 0.96, 0.055, "", true, vote_window)
    guiSetEnabled(guiCreateStaticImage(0.925, 0.1, 0.065, 0.8, "images/search.png", true, vote_search), false)
    vote_view = guiCreateButton(0.02, 0.92, 0.31, 0.06, "Preview", true, vote_window)
    addEventHandler("onClientGUIClick", vote_view, onClientGUIClick_vote_view)
    guiSetFont(vote_view, "default-bold-small")
    vote_add = guiCreateButton(0.35, 0.92, 0.31, 0.06, "Vote", true, vote_window)
    addEventHandler("onClientGUIClick", vote_add, onClientGUIClick_vote_add)
    guiSetFont(vote_add, "default-bold-small")
    guiSetProperty(vote_add, "NormalTextColour", "C000FF00")
    vote_close = guiCreateButton(0.67, 0.92, 0.31, 0.06, "Close", true, vote_window)
    addEventHandler("onClientGUIClick", vote_close, onClientGUIClick_vote_close)
    guiSetFont(vote_close, "default-bold-small")
    voting_window = guiCreateWindow(xscreen - 200, yscreen - 200 - xscreen * 0.03, 200, 200, "Voting", false)
    guiSetVisible(voting_window, false)
    guiWindowSetMovable(voting_window, false)
    guiWindowSetSizable(voting_window, false)
  end
  function updateVoting()
    -- line: [36, 84] id: 285
    local r0_285 = getTacticsData("voting")
    if r0_285 and r0_285.rows and 0 < #r0_285.rows then
      local r1_285 = 0
      for r5_285 = 1, math.max(#r0_285.rows + 1, #r1_283), 1 do
        if r5_285 <= #r0_285.rows then
          local r6_285 = r0_285.rows[r5_285]
          if #r1_283 < r5_285 then
            r1_283[r5_285] = guiCreateLabel(20, 5 + r5_285 * 20, xscreen, 40, r5_285 .. " - " .. (r6_285.label or r6_285.resname) .. " (" .. tonumber(r6_285.votes) .. ")", false, voting_window)
            guiSetFont(r1_283[r5_285], "default-bold-small")
          else
            guiSetText(r1_283[r5_285], r5_285 .. " - " .. (r6_285.label or r6_285.resname) .. " (" .. tonumber(r6_285.votes) .. ")")
          end
          if r0_283 == r5_285 then
            guiLabelSetColor(r1_283[r5_285], 255, 128, 0)
          else
            guiLabelSetColor(r1_283[r5_285], 255, 255, 255)
          end
          local r7_285 = dxGetTextWidth(r5_285 .. " - " .. (r6_285.label or r6_285.resname) .. " (" .. tonumber(r6_285.votes) .. ")", 1, "default-bold")
          if r1_285 < r7_285 + 40 then
            r1_285 = r7_285 + 40
          end
        elseif r5_285 == #r0_285.rows + 1 then
          if #r1_283 < r5_285 then
            r1_283[r5_285] = guiCreateLabel(20, 5 + r5_285 * 20, xscreen, 40, "0 - Cancel (" .. tonumber(r0_285.cancel) .. ")", false, voting_window)
            guiSetFont(r1_283[r5_285], "default-bold-small")
          else
            guiSetText(r1_283[r5_285], "0 - Cancel (" .. tonumber(r0_285.cancel) .. ")")
          end
          if r0_283 == 0 then
            guiLabelSetColor(r1_283[r5_285], 255, 128, 0)
          else
            guiLabelSetColor(r1_283[r5_285], 255, 255, 255)
          end
          local r6_285 = dxGetTextWidth("0 - Cancel (" .. tonumber(r0_285.cancel) .. ")", 1, "default-bold")
          if r1_285 < r6_285 + 40 then
            r1_285 = r6_285 + 40
          end
        else
          destroyElement(r1_283[r5_285])
          r1_283[r5_285] = nil
        end
      end
      height = (#r0_285.rows + 1) * 20 + 30
      guiSetPosition(voting_window, xscreen - r1_285, yscreen - height, false)
      guiSetSize(voting_window, r1_285, height, false)
      guiBringToFront(voting_window)
      guiSetVisible(voting_window, true)
    else
      guiSetVisible(voting_window, false)
      r0_283 = nil
    end
  end
  function updateVoteTime(r0_286)
    -- line: [85, 90] id: 286
    if r0_286 > 0 then
      guiSetText(voting_window, "Voting ... " .. r0_286 .. " sec")
      r2_283 = setTimer(updateVoteTime, 1000, 1, r0_286 - 1)
    end
  end
  function setVote(r0_287, r1_287, r2_287)
    -- line: [91, 97] id: 287
    local r3_287 = getTacticsData("voting")
    if r3_287 and r3_287.rows and 0 < #r3_287.rows and (not r2_287 or r2_287 <= #r3_287.rows) then
      triggerServerEvent("onPlayerVote", localPlayer, r2_287, r0_283)
      r0_283 = r2_287
    end
  end
  function commandVote(r0_288, r1_288, r2_288)
    -- line: [98, 109] id: 288
    if not r1_288 or not r2_288 then
      return outputChatBox(getLanguageString("syntax_vote"), 255, 100, 100, true)
    end
    local r3_288 = getTacticsData("modes_defined") or {}
    local r4_288 = getLanguageString("supported_modes")
    for r8_288 in pairs(r3_288) do
      r4_288 = r4_288 .. r8_288 .. ", "
      if r1_288 == r8_288 then
        return triggerServerEvent("onPlayerVote", localPlayer, r1_288 .. "_" .. r2_288, nil, "map")
      end
    end
    outputChatBox(string.sub(r4_288, 1, -3), 255, 100, 100, true)
  end
  function onClientGUIClick_vote_view(r0_289, r1_289, r2_289, r3_289)
    -- line: [110, 135] id: 289
    if r0_289 ~= "left" then
      return 
    end
    if isElement(previewRoot) then
      setElementDimension(localPlayer, 0)
      removeEventHandler("onClientPlayerSpawn", localPlayer, Preview_onClientPlayerSpawn)
      removeEventHandler("onClientElementDataChange", localPlayer, Preview_onClientElementDataChange)
      removeEventHandler("onClientRender", root, Preview_onClientRender)
      destroyElement(previewRoot)
      guiSetText(vote_view, "Preview")
      guiSetProperty(vote_view, "NormalTextColour", "C07C7C7C")
      if getTacticsData("Map") == "lobby" and getPlayerTeam(localPlayer) ~= getElementsByType("team")[1] and not getElementData(localPlayer, "spectateskin") then
        setElementData(localPlayer, "Status", "Play")
        setCameraTarget(localPlayer)
      else
        setCameraSpectating(nil, "playertarget")
      end
    else
      if getElementData(localPlayer, "Status") == "Play" and getTacticsData("Map") ~= "lobby" then
        return 
      end
      local r4_289 = guiGridListGetSelectedItem(vote_maps)
      if r4_289 < 0 then
        return 
      end
      triggerServerEvent("onPlayerPreview", localPlayer, guiGridListGetItemData(vote_maps, r4_289, 1))
      guiSetText(vote_view, "Exit")
      guiSetProperty(vote_view, "NormalTextColour", "C0FF0000")
    end
  end
  function onClientGUIClick_vote_add(r0_290, r1_290, r2_290, r3_290)
    -- line: [136, 144] id: 290
    if r0_290 ~= "left" then
      return 
    end
    local r4_290 = guiGridListGetSelectedItem(vote_maps)
    if r4_290 < 0 then
      return 
    end
    triggerServerEvent("onPlayerVote", localPlayer, guiGridListGetItemData(vote_maps, r4_290, 1), nil, "map")
    guiSetVisible(vote_window, false)
    if isAllGuiHidden() then
      showCursor(false)
    end
  end
  function onClientGUIClick_vote_close(r0_291, r1_291, r2_291, r3_291)
    -- line: [145, 149] id: 291
    if r0_291 ~= "left" then
      return 
    end
    guiSetVisible(vote_window, false)
    if isAllGuiHidden() then
      showCursor(false)
    end
  end
  function onClientGUIDoubleClick(r0_292, r1_292, r2_292, r3_292)
    -- line: [150, 159] id: 292
    if r0_292 == "left" and source == vote_maps then
      local r4_292 = guiGridListGetSelectedItem(vote_maps)
      if r4_292 < 0 then
        return 
      end
      triggerServerEvent("onPlayerVote", localPlayer, guiGridListGetItemData(vote_maps, r4_292, 1), nil, "map")
      guiSetVisible(vote_window, false)
      if isAllGuiHidden() then
        showCursor(false)
      end
    end
  end
  function onClientGUIChanged(r0_293)
    -- line: [160, 164] id: 293
    if source == vote_search then
      updateVoteMaps()
    end
  end
  local r3_283 = {}
  function onClientMapsUpdate(r0_294)
    -- line: [166, 169] id: 294
    r3_283 = r0_294
    updateVoteMaps()
  end
  function updateVoteMaps()
    -- line: [170, 222] id: 295
    local r0_295 = getTacticsData("map_disabled") or {}
    local r1_295 = guiGetText(vote_search)
    local r2_295 = {}
    for r6_295, r7_295 in ipairs(r3_283) do
      local r8_295 = true
      if #r1_295 > 0 then
        for r12_295 in string.gmatch(r1_295, "[^ ]+") do
          if string.sub(r12_295, 1, 1) == "-" and #r12_295 > 1 then
            r12_295 = string.sub(r12_295, 2, -1)
            if string.find(string.lower(r7_295[2]), string.lower(r12_295)) or string.find(string.lower(r7_295[3]), string.lower(r12_295)) then
              r8_295 = false
            end
          elseif not string.find(string.lower(r7_295[2]), string.lower(r12_295)) and not string.find(string.lower(r7_295[3]), string.lower(r12_295)) then
            r8_295 = false
          end
        end
      end
      if r0_295[tostring(r7_295[1])] or getTacticsData("modes", string.lower(r7_295[2]), "enable") == "false" then
        r8_295 = false
      end
      if r8_295 then
        table.insert(r2_295, r7_295)
      end
    end
    table.sort(r2_295, function(r0_296, r1_296)
      -- line: [193, 193] id: 296
      local r2_296 = r0_296[2]
      if r2_296 >= r1_296[2] then
        r2_296 = r0_296[2]
        if r2_296 == r1_296[2] then
          r2_296 = r0_296[3] < r1_296[3]
        else
          goto label_12	-- block#3 is visited secondly
        end
      else
        goto label_13	-- block#4 is visited secondly
      end
      return r2_296
    end)
    local r3_295 = getTacticsData("MapResName")
    local r4_295 = guiGridListGetRowCount(vote_maps)
    for r8_295 = 1, math.max(r4_295, #r2_295), 1 do
      if r8_295 <= #r2_295 then
        local r9_295, r10_295, r11_295, r12_295, r13_295 = unpack(r2_295[r8_295])
        if r4_295 < r8_295 then
          guiGridListAddRow(vote_maps)
        end
        guiGridListSetItemText(vote_maps, r8_295 - 1, 1, r10_295, false, false)
        guiGridListSetItemData(vote_maps, r8_295 - 1, 1, r9_295)
        guiGridListSetItemText(vote_maps, r8_295 - 1, 2, r11_295, false, false)
        if r3_295 == r9_295 then
          if r0_295[r9_295] or getTacticsData("modes", string.lower(r10_295), "enable") == "false" then
            guiGridListSetItemColor(vote_maps, r8_295 - 1, 1, 0, 128, 0)
            guiGridListSetItemColor(vote_maps, r8_295 - 1, 2, 0, 128, 0)
          else
            guiGridListSetItemColor(vote_maps, r8_295 - 1, 1, 0, 255, 0)
            guiGridListSetItemColor(vote_maps, r8_295 - 1, 2, 0, 255, 0)
          end
        elseif r0_295[r9_295] or getTacticsData("modes", string.lower(r10_295), "enable") == "false" then
          guiGridListSetItemColor(vote_maps, r8_295 - 1, 1, 128, 128, 128)
          guiGridListSetItemColor(vote_maps, r8_295 - 1, 2, 128, 128, 128)
        else
          guiGridListSetItemColor(vote_maps, r8_295 - 1, 1, 255, 255, 255)
          guiGridListSetItemColor(vote_maps, r8_295 - 1, 2, 255, 255, 255)
        end
      else
        guiGridListRemoveRow(vote_maps, #r2_295)
      end
    end
  end
  function toggleVoting()
    -- line: [223, 233] id: 297
    if not guiGetVisible(vote_window) then
      updateVoteMaps()
      guiBringToFront(vote_window)
      guiSetVisible(vote_window, true)
      showCursor(true)
    else
      guiSetVisible(vote_window, false)
      if isAllGuiHidden() then
        showCursor(false)
      end
    end
  end
  function onClientTacticsChange(r0_298, r1_298)
    -- line: [234, 292] id: 298
    if r0_298[1] == "map_disabled" or r0_298[1] == "modes" and r0_298[3] == "enable" then
      updateVoteMaps()
    end
    if r0_298[1] == "voting" then
      local r2_298 = getTacticsData("voting")
      if r2_298 and not r1_298 and r0_298[2] == "start" then
        bindKey("1", "down", setVote, 1)
        bindKey("2", "down", setVote, 2)
        bindKey("3", "down", setVote, 3)
        bindKey("4", "down", setVote, 4)
        bindKey("5", "down", setVote, 5)
        bindKey("6", "down", setVote, 6)
        bindKey("7", "down", setVote, 7)
        bindKey("8", "down", setVote, 8)
        bindKey("9", "down", setVote, 9)
        bindKey("0", "down", setVote, 0)
        bindKey("num_1", "down", setVote, 1)
        bindKey("num_2", "down", setVote, 2)
        bindKey("num_3", "down", setVote, 3)
        bindKey("num_4", "down", setVote, 4)
        bindKey("num_5", "down", setVote, 5)
        bindKey("num_6", "down", setVote, 6)
        bindKey("num_7", "down", setVote, 7)
        bindKey("num_8", "down", setVote, 8)
        bindKey("num_9", "down", setVote, 9)
        bindKey("num_0", "down", setVote, 0)
        bindKey("backspace", "down", setVote, nil)
        local r3_298 = r2_298.start - getTickCount() + addTickCount
        local r4_298 = math.floor(r3_298 / 1000)
        guiSetText(voting_window, "Voting ... " .. r4_298 .. " sec")
        r2_283 = setTimer(updateVoteTime, math.max(50, r3_298 - r4_298 * 1000), 1, r4_298)
      elseif not r2_298 and r1_298 then
        if isTimer(r2_283) then
          killTimer(r2_283)
        end
        unbindKey("1", "down", setVote)
        unbindKey("2", "down", setVote)
        unbindKey("3", "down", setVote)
        unbindKey("4", "down", setVote)
        unbindKey("5", "down", setVote)
        unbindKey("6", "down", setVote)
        unbindKey("7", "down", setVote)
        unbindKey("8", "down", setVote)
        unbindKey("9", "down", setVote)
        unbindKey("0", "down", setVote)
        unbindKey("num_1", "down", setVote)
        unbindKey("num_2", "down", setVote)
        unbindKey("num_3", "down", setVote)
        unbindKey("num_4", "down", setVote)
        unbindKey("num_5", "down", setVote)
        unbindKey("num_6", "down", setVote)
        unbindKey("num_7", "down", setVote)
        unbindKey("num_8", "down", setVote)
        unbindKey("num_9", "down", setVote)
        unbindKey("num_0", "down", setVote)
        unbindKey("backspace", "down", setVote)
      end
      updateVoting()
    end
  end
  function onClientPreviewMapLoading(r0_299, r1_299)
    -- line: [293, 396] id: 299
    local r2_299 = {}
    local r3_299 = nil
    local r4_299 = {}
    local r5_299 = {}
    local r6_299 = {}
    for r10_299, r11_299 in ipairs(r1_299) do
      if r11_299[1] == "Anti_Rush_Point" then
        local r12_299 = table.insert
        local r13_299 = r2_299
        local r14_299 = {
          x = tonumber(r11_299[2].posX) or 0,
          y = tonumber(r11_299[2].posY) or 0,
          z = tonumber(r11_299[2].posZ) or 0,
        }
        r12_299(r13_299, r14_299)
      end
      if r11_299[1] == "Central_Marker" then
        local r12_299 = {
          x = tonumber(r11_299[2].posX) or 0,
          y = tonumber(r11_299[2].posY) or 0,
          z = tonumber(r11_299[2].posZ) or 0,
        }
        r3_299 = r12_299
      end
      if r11_299[1] == "Team1" then
        local r12_299 = table.insert
        local r13_299 = r4_299
        local r14_299 = {
          x = tonumber(r11_299[2].posX) or 0,
          y = tonumber(r11_299[2].posY) or 0,
          z = tonumber(r11_299[2].posZ) or 0,
          rot = tonumber(r11_299[2].rotation) or tonumber(r11_299[2].rotZ) or 0,
        }
        r12_299(r13_299, r14_299)
      end
      if r11_299[1] == "Team2" then
        local r12_299 = table.insert
        local r13_299 = r5_299
        local r14_299 = {
          x = tonumber(r11_299[2].posX) or 0,
          y = tonumber(r11_299[2].posY) or 0,
          z = tonumber(r11_299[2].posZ) or 0,
          rot = tonumber(r11_299[2].rotation) or tonumber(r11_299[2].rotZ) or 0,
        }
        r12_299(r13_299, r14_299)
      end
      if r11_299[1] == "spawnpoint" then
        local r12_299 = table.insert
        local r13_299 = r6_299
        local r14_299 = {
          x = tonumber(r11_299[2].posX) or 0,
          y = tonumber(r11_299[2].posY) or 0,
          z = tonumber(r11_299[2].posZ) or 0,
          rot = tonumber(r11_299[2].rotation) or tonumber(r11_299[2].rotZ) or 0,
        }
        r12_299(r13_299, r14_299)
      end
    end
    if not r3_299 then
      guiSetText(vote_view, "Preview")
      guiSetProperty(vote_view, "NormalTextColour", "C07C7C7C")
      return 
    end
    setElementDimension(localPlayer, 10)
    if isElement(previewRoot) then
      destroyElement(previewRoot)
    end
    previewRoot = createElement("preview", "previewRoot")
    for r10_299, r11_299 in ipairs(r4_299) do
      local r12_299 = createPed(0, r11_299.x, r11_299.y, r11_299.z, r11_299.rot)
      setElementFrozen(r12_299, true)
      setElementParent(r12_299, previewRoot)
      setElementDimension(r12_299, 10)
      local r13_299 = createMarker(r11_299.x, r11_299.y, r11_299.z, "corona", 2, 255, 0, 0, 32)
      attachElements(r13_299, r12_299)
      setElementDimension(r13_299, 10)
      local r14_299 = createBlipAttachedTo(r12_299, 0, 1, 255, 0, 0, 255, -1)
      setElementParent(r14_299, previewRoot)
      setElementDimension(r14_299, 10)
    end
    for r10_299, r11_299 in ipairs(r5_299) do
      local r12_299 = createPed(0, r11_299.x, r11_299.y, r11_299.z, r11_299.rot)
      setElementFrozen(r12_299, true)
      setElementParent(r12_299, previewRoot)
      setElementDimension(r12_299, 10)
      local r13_299 = createMarker(r11_299.x, r11_299.y, r11_299.z, "corona", 2, 0, 0, 255, 32)
      attachElements(r13_299, r12_299)
      setElementDimension(r13_299, 10)
      local r14_299 = createBlipAttachedTo(r12_299, 0, 1, 0, 0, 255, 255, -1)
      setElementParent(r14_299, previewRoot)
      setElementDimension(r14_299, 10)
    end
    for r10_299, r11_299 in ipairs(r6_299) do
      local r12_299 = createPed(0, r11_299.x, r11_299.y, r11_299.z, r11_299.rot)
      setElementFrozen(r12_299, true)
      setElementParent(r12_299, previewRoot)
      setElementDimension(r12_299, 10)
      local r13_299 = createMarker(r11_299.x, r11_299.y, r11_299.z, "corona", 2, 255, 255, 255, 32)
      attachElements(r13_299, r12_299)
      setElementDimension(r13_299, 10)
      local r14_299 = createBlipAttachedTo(r12_299, 0, 1, 255, 255, 255, 255, -1)
      setElementParent(r14_299, previewRoot)
      setElementDimension(r14_299, 10)
    end
    if #r2_299 > 0 then
      if #r2_299 == 2 then
        r2_299 = {
          {
            math.min(r2_299[1].x, r2_299[2].x),
            math.min(r2_299[1].y, r2_299[2].y)
          },
          {
            math.max(r2_299[1].x, r2_299[2].x),
            math.min(r2_299[1].y, r2_299[2].y)
          },
          {
            math.max(r2_299[1].x, r2_299[2].x),
            math.max(r2_299[1].y, r2_299[2].y)
          },
          {
            math.min(r2_299[1].x, r2_299[2].x),
            math.max(r2_299[1].y, r2_299[2].y)
          }
        }
      end
      if #r2_299 > 1 then
        local r7_299 = 12
        local r8_299 = {
          r3_299.x,
          r3_299.y
        }
        for r12_299, r13_299 in ipairs(r2_299) do
          table.insert(r8_299, r13_299.x)
          table.insert(r8_299, r13_299.y)
          local r14_299 = createObject(3380, r13_299.x, r13_299.y, r13_299.z)
          setElementParent(r14_299, previewRoot)
          setElementDimension(r14_299, 10)
          local r15_299 = #r2_299
          if r12_299 < r15_299 then
            r15_299 = r2_299[r12_299 + 1] or r2_299[1]
          else
            goto label_541	-- block#71 is visited secondly
          end
          local r16_299 = math.floor(getDistanceBetweenPoints2D(r13_299.x, r13_299.y, r15_299.x, r15_299.y) / 5)
          local r17_299 = (r15_299.x - r13_299.x) / r16_299
          local r18_299 = (r15_299.y - r13_299.y) / r16_299
          for r22_299 = 0, r16_299, 1 do
            local r23_299 = createRadarArea(r13_299.x - r7_299 * 0.5 + r17_299 * r22_299, r13_299.y - r7_299 * 0.5 + r18_299 * r22_299, r7_299, r7_299, 128, 0, 0, 255)
            setElementParent(r23_299, previewRoot)
            setElementDimension(r23_299, 10)
          end
        end
      end
    end
    setCameraMatrix(r3_299.x - 50, r3_299.y - 50, r3_299.z + 40, r3_299.x, r3_299.y, r3_299.z)
    setCameraSpectating(nil, "freecamera")
    addEventHandler("onClientPlayerSpawn", localPlayer, Preview_onClientPlayerSpawn)
    addEventHandler("onClientElementDataChange", localPlayer, Preview_onClientElementDataChange)
    addEventHandler("onClientRender", root, Preview_onClientRender)
    triggerEvent("onClientPreviewMapCreating", previewRoot, r0_299, r1_299)
  end
  function Preview_onClientRender()
    -- line: [397, 423] id: 300
    local r0_300 = {}
    for r4_300, r5_300 in ipairs(getElementsByType("object")) do
      if getElementModel(r5_300) == 3380 and getElementDimension(r5_300) == 10 then
        local r6_300, r7_300 = getElementPosition(r5_300)
        table.insert(r0_300, {
          r6_300,
          r7_300
        })
      end
    end
    if #r0_300 > 0 then
      if #r0_300 == 2 then
        r0_300 = {
          {
            math.min(r0_300[1][1], r0_300[2][1]),
            math.min(r0_300[1][2], r0_300[2][2])
          },
          {
            math.max(r0_300[1][1], r0_300[2][1]),
            math.min(r0_300[1][2], r0_300[2][2])
          },
          {
            math.max(r0_300[1][1], r0_300[2][1]),
            math.max(r0_300[1][2], r0_300[2][2])
          },
          {
            math.min(r0_300[1][1], r0_300[2][1]),
            math.max(r0_300[1][2], r0_300[2][2])
          }
        }
      end
      if #r0_300 > 1 then
        for r4_300, r5_300 in ipairs(r0_300) do
          local r6_300 = #r0_300
          if r4_300 < r6_300 then
            r6_300 = r0_300[r4_300 + 1] or r0_300[1]
          else
            goto label_117	-- block#12 is visited secondly
          end
          local r7_300, r8_300 = getScreenFromWorldPosition(r5_300[1], r5_300[2], getGroundPosition(r5_300[1], r5_300[2], 1500), 360)
          local r9_300, r10_300 = getScreenFromWorldPosition(r6_300[1], r6_300[2], getGroundPosition(r6_300[1], r6_300[2], 1500), 360)
          if r7_300 and r9_300 then
            dxDrawLine(r7_300, r8_300, r9_300, r10_300, 2157969408, 5)
          end
        end
      end
    end
  end
  function Preview_onClientPlayerSpawn()
    -- line: [424, 434] id: 301
    if isElement(previewRoot) then
      setElementDimension(localPlayer, 0)
      removeEventHandler("onClientPlayerSpawn", localPlayer, Preview_onClientPlayerSpawn)
      removeEventHandler("onClientElementDataChange", localPlayer, Preview_onClientElementDataChange)
      removeEventHandler("onClientRender", root, Preview_onClientRender)
      destroyElement(previewRoot)
      guiSetText(vote_view, "Preview")
      guiSetProperty(vote_view, "NormalTextColour", "C07C7C7C")
    end
  end
  function Preview_onClientElementDataChange(r0_302, r1_302)
    -- line: [435, 445] id: 302
    if r0_302 == "Status" and isElement(previewRoot) then
      setElementDimension(localPlayer, 0)
      removeEventHandler("onClientPlayerSpawn", localPlayer, Preview_onClientPlayerSpawn)
      removeEventHandler("onClientElementDataChange", localPlayer, Preview_onClientElementDataChange)
      removeEventHandler("onClientRender", root, Preview_onClientRender)
      destroyElement(previewRoot)
      guiSetText(vote_view, "Preview")
      guiSetProperty(vote_view, "NormalTextColour", "C07C7C7C")
    end
  end
  addEvent("onClientPreviewMapLoading", true)
  addEvent("onClientPreviewMapCreating", true)
  addEventHandler("onClientResourceStart", resourceRoot, onClientResourceStart)
  addEventHandler("onClientMapsUpdate", root, onClientMapsUpdate)
  addEventHandler("onClientGUIDoubleClick", root, onClientGUIDoubleClick)
  addEventHandler("onClientGUIChanged", root, onClientGUIChanged)
  addEventHandler("onClientPreviewMapLoading", root, onClientPreviewMapLoading)
  addEventHandler("onClientTacticsChange", root, onClientTacticsChange)
  addEventHandler("onClientMapStarting", root, updateVoteMaps)
  addCommandHandler("vote", commandVote, false)
  addCommandHandler("votemap_toggle", toggleVoting, false)
end)()
(function(...)
  -- line: [0, 0] id: 303
  local r0_303 = dxGetFontHeight(1, "clear")
  addEventHandler("onClientResourceStart", resourceRoot, function()
    -- line: [8, 91] id: 304
    components = {}
    components_update = {}
    components.elementlist = {}
    components.elementlist.root = guiCreateStaticImage(xscreen * 0.776, yscreen * 0.173, xscreen * 0.174, yscreen * 0.04, "images/color_pixel.png", false)
    guiSetProperty(components.elementlist.root, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    guiSetVisible(components.elementlist.root, false)
    guiSetEnabled(components.elementlist.root, false)
    components.elementlist.image = {}
    components.elementlist.custom = {}
    components.playerlist = {}
    components.playerlist.root = guiCreateStaticImage(0, 0, 0, 0, "images/color_pixel.png", false)
    guiSetProperty(components.playerlist.root, "ImageColours", "tl:80000000 tr:80000000 bl:80000000 br:80000000")
    guiSetVisible(components.playerlist.root, false)
    guiSetEnabled(components.playerlist.root, false)
    components.playerlist.players = {}
    components.playerlist.players.root = guiCreateStaticImage(5, 2, 0, yscreen, "images/color_pixel.png", false, components.playerlist.root)
    guiSetProperty(components.playerlist.players.root, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    components.playerlist.icon = {}
    components.playerlist.info = {}
    components.playerlist.info.root = guiCreateStaticImage(0, 0, 0, yscreen, "images/color_pixel.png", false, components.playerlist.root)
    guiSetProperty(components.playerlist.info.root, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    components.playerlist.rows = 0
    components.playerlist.custom = {}
    components.race = {}
    components.race.root = guiCreateStaticImage(0, 0, 0, 0, "images/color_pixel.png", false)
    guiSetProperty(components.race.root, "ImageColours", "tl:80000000 tr:80000000 bl:80000000 br:80000000")
    guiSetVisible(components.race.root, false)
    guiSetEnabled(components.race.root, false)
    components.race.rank = guiCreateLabel(0, 0, xscreen, 2 * r0_303, "", false, components.race.root)
    guiLabelSetHorizontalAlign(components.race.rank, "right")
    guiSetFont(components.race.rank, fontTactics)
    components.race.players = guiCreateLabel(0, 0, xscreen, 2 * r0_303, "", false, components.race.root)
    components.race.checkpoint = guiCreateLabel(0, 0, 0, 0, "", false, components.race.root)
    guiLabelSetHorizontalAlign(components.race.checkpoint, "center")
    components.race.timepass = guiCreateLabel(0, 0, 0, 0, "", false, components.race.root)
    guiLabelSetHorizontalAlign(components.race.timepass, "center")
    components.race.info = guiCreateLabel(0, 0, 0, 0, "", false, components.race.root)
    guiLabelSetHorizontalAlign(components.race.info, "center")
    components.race.custom = {}
    components.teamlist = {}
    components.teamlist.root = guiCreateStaticImage(0, 0, 0, 0, "images/color_pixel.png", false)
    guiSetProperty(components.teamlist.root, "ImageColours", "tl:80000000 tr:80000000 bl:80000000 br:80000000")
    guiSetVisible(components.teamlist.root, false)
    guiSetEnabled(components.teamlist.root, false)
    components.teamlist.teamname = {}
    components.teamlist.teamname.root = guiCreateStaticImage(5, 2, 0, yscreen, "images/color_pixel.png", false, components.teamlist.root)
    guiSetProperty(components.teamlist.teamname.root, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    components.teamlist.players = {}
    components.teamlist.players.root = guiCreateStaticImage(0, 0, 0, yscreen, "images/color_pixel.png", false, components.teamlist.root)
    guiSetProperty(components.teamlist.players.root, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    components.teamlist.icon = {}
    components.teamlist.info = {}
    components.teamlist.info.root = guiCreateStaticImage(0, 0, 0, yscreen, "images/color_pixel.png", false, components.teamlist.root)
    guiSetProperty(components.teamlist.info.root, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    components.teamlist.rows = 0
    components.teamlist.custom = {}
    components.timeleft = {}
    components.timeleft.root = guiCreateStaticImage(xscreen * 0.5 - 31, yscreen * 0.053, 62, r0_303, "images/color_pixel.png", false)
    guiSetProperty(components.timeleft.root, "ImageColours", "tl:80000000 tr:80000000 bl:80000000 br:80000000")
    guiSetVisible(components.timeleft.root, false)
    guiSetEnabled(components.timeleft.root, false)
    components.timeleft.text = guiCreateLabel(0, 0, 1, 1, "", true, components.timeleft.root)
    guiSetFont(components.timeleft.text, "clear-normal")
    guiLabelSetHorizontalAlign(components.timeleft.text, "center")
    guiLabelSetVerticalAlign(components.timeleft.text, "center")
    components.timeleft.custom = {}
    components.nitro = {}
    components.nitro.root = guiCreateStaticImage(xscreen * 0.03175, yscreen * 0.768, math.floor(xscreen * 0.0165), math.floor(yscreen * 0.17), "images/color_pixel.png", false)
    guiSetProperty(components.nitro.root, "ImageColours", "tl:60000000 tr:60000000 bl:60000000 br:60000000")
    guiSetVisible(components.nitro.root, false)
    guiSetEnabled(components.nitro.root, false)
    components.nitro.level = guiCreateStaticImage(0, 0, 1, 1, "images/color_pixel.png", true, components.nitro.root)
    guiSetProperty(components.nitro.level, "ImageColours", "tl:60006080 tr:60006080 bl:60006080 br:60006080")
    components.nitro.arrow = guiCreateStaticImage(-math.floor((xscreen * 0.03375 * 0.28)), 0, math.floor(xscreen * 0.03375 * 0.97), math.floor(yscreen * 0.004), "images/color_pixel.png", false, components.nitro.level)
    guiSetProperty(components.nitro.arrow, "ImageColours", "tl:A0C0C0C0 tr:A0C0C0C0 bl:A0C0C0C0 br:A0C0C0C0")
    guiSetProperty(components.nitro.arrow, "ClippedByParent", "False")
  end)
  function showRoundHudComponent(r0_305, r1_305, r2_305)
    -- line: [92, 107] id: 305
    if not components[r0_305] then
      return nil
    end
    if r1_305 and not guiGetVisible(components[r0_305].root) then
      updateRoundHudComponent(r0_305)
      guiSetVisible(components[r0_305].root, true)
      local r3_305 = components_update
      local r4_305 = setTimer
      local r5_305 = updateRoundHudComponent
      local r6_305 = nil	-- notice: implicit variable refs by block#[7]
      if r0_305 == "race" then
        r6_305 = 50
        if not r6_305 then
          ::label_32::
          r6_305 = 500
        end
      else
        goto label_32	-- block#6 is visited secondly
      end
      r3_305[r0_305] = r4_305(r5_305, r6_305, 0, r0_305)
      if r2_305 == true then
        setRoundHudComponent(r0_305)
      end
      return true
    elseif not r1_305 and guiGetVisible(components[r0_305].root) then
      guiSetVisible(components[r0_305].root, false)
      killTimer(components_update[r0_305])
      if r2_305 == nil or r2_305 == true then
        setRoundHudComponent(r0_305)
      end
      return true
    end
    return false
  end
  function isShowRoundHudComponent(r0_306)
    -- line: [108, 111] id: 306
    if not components[r0_306] or not isElement(components[r0_306].root) then
      return nil
    end
    return guiGetVisible(components[r0_306].root)
  end
  function setRoundHudComponent(r0_307, ...)
    -- line: [112, 187] id: 307
    if not components[r0_307] then
      return nil
    end
    local r2_307 = {
      ...
    }
    if r0_307 == "elementlist" then
      if r2_307[1] ~= nil and type(r2_307[1]) ~= "table" and type(r2_307[1]) ~= "function" then
        return false
      end
      if r2_307[2] ~= nil and type(r2_307[2]) ~= "function" then
        return false
      end
      components.elementlist.custom.elements = r2_307[1]
      components.elementlist.custom.draw = r2_307[2]
      return true
    end
    if r0_307 == "playerlist" then
      if r2_307[1] ~= nil and type(r2_307[1]) ~= "string" and type(r2_307[1]) ~= "function" then
        return false
      end
      if r2_307[2] ~= nil and type(r2_307[2]) ~= "function" then
        return false
      end
      if r2_307[3] ~= nil and type(r2_307[3]) ~= "boolean" then
        return false
      end
      if r2_307[4] ~= nil and type(r2_307[4]) ~= "number" then
        return false
      end
      if r2_307[1] and components.playerlist.custom.icon ~= r2_307[1] and type(r2_307[1]) == "string" then
        for r6_307 = 1, components.playerlist.rows, 1 do
          guiStaticImageLoadImage(components.playerlist.icon[r6_307], r2_307[1])
        end
      elseif components.playerlist.custom.icon then
        for r6_307 = 1, components.playerlist.rows, 1 do
          guiStaticImageLoadImage(components.playerlist.icon[r6_307], "images/frag.png")
        end
      end
      components.playerlist.custom.icon = r2_307[1]
      components.playerlist.custom.func = r2_307[2]
      components.playerlist.custom.sort = r2_307[3]
      components.playerlist.custom.rows = r2_307[4]
      return true
    end
    if r0_307 == "race" then
      if r2_307[1] ~= nil and type(r2_307[1]) ~= "boolean" then
        return false
      end
      if r2_307[2] ~= nil and type(r2_307[2]) ~= "boolean" then
        return false
      end
      if r2_307[3] ~= nil and type(r2_307[3]) ~= "function" then
        return false
      end
      components.race.custom.timepass = r2_307[1]
      components.race.custom.checkpoints = r2_307[2]
      components.race.custom.info = r2_307[3]
      return true
    end
    if r0_307 == "teamlist" then
      if r2_307[1] ~= nil and type(r2_307[1]) ~= "string" and type(r2_307[1]) ~= "function" then
        return false
      end
      if r2_307[2] ~= nil and type(r2_307[2]) ~= "function" then
        return false
      end
      if r2_307[3] ~= nil and type(r2_307[3]) ~= "boolean" then
        return false
      end
      if r2_307[4] ~= nil and type(r2_307[4]) ~= "number" then
        return false
      end
      if r2_307[1] and components.teamlist.custom.icon ~= r2_307[1] and type(r2_307[1]) == "string" then
        for r6_307 = 1, components.teamlist.rows, 1 do
          guiStaticImageLoadImage(components.teamlist.icon[r6_307], r2_307[1])
        end
      elseif components.teamlist.custom.icon then
        for r6_307 = 1, components.teamlist.rows, 1 do
          guiStaticImageLoadImage(components.teamlist.icon[r6_307], "images/score.png")
        end
      end
      components.teamlist.custom.icon = r2_307[1]
      components.teamlist.custom.func = r2_307[2]
      components.teamlist.custom.sort = r2_307[3]
      components.teamlist.custom.rows = r2_307[4]
      return true
    end
    if r0_307 == "timeleft" then
      if r2_307[1] ~= nil and type(r2_307[1]) ~= "function" and type(r2_307[1]) ~= "string" then
        return false
      end
      if r2_307[2] ~= nil and type(r2_307[2]) ~= "number" then
        return false
      end
      if r2_307[3] ~= nil and type(r2_307[3]) ~= "number" then
        return false
      end
      if r2_307[4] ~= nil and type(r2_307[4]) ~= "number" then
        return false
      end
      components.timeleft.custom.text = r2_307[1]
      if type(r2_307[1]) == "string" then
        guiSetText(components.timeleft.text, r2_307[1])
      end
      if type(r2_307[1]) == "function" then
        guiSetText(components.timeleft.text, r2_307[1]())
      end
      if r2_307[2] and r2_307[3] and r2_307[4] then
        guiLabelSetColor(components.timeleft.text, r2_307[2], r2_307[3], r2_307[4])
      else
        guiLabelSetColor(components.timeleft.text, 255, 255, 255)
      end
      return true
    end
    return false
  end
  function updateRoundHudComponent(r0_308)
    -- line: [188, 468] id: 308
    if r0_308 == "elementlist" then
      local r1_308 = type(components.elementlist.custom.elements)
      if r1_308 == "table" then
        r1_308 = components.elementlist.custom.elements
        if not r1_308 then
          ::label_16::
          r1_308 = type(components.elementlist.custom.elements)
          if r1_308 == "function" then
            r1_308 = components.elementlist.custom.elements() or {}
          else
            goto label_31	-- block#5 is visited secondly
          end
        end
      else
        goto label_16	-- block#3 is visited secondly
      end
      for r5_308 = 1, math.max(#r1_308, #components.elementlist.image), 1 do
        if r5_308 <= #r1_308 then
          local r6_308, r7_308, r8_308, r9_308 = components.elementlist.custom.draw(r1_308, r5_308)
          local r10_308 = math.min((xscreen * 0.174 - yscreen * 0.04) / 6, (xscreen * 0.174 - yscreen * 0.04) / #r1_308)
          if not components.elementlist.image[r5_308] then
            components.elementlist.image[r5_308] = guiCreateStaticImage((r5_308 - 1) * r10_308, 0, yscreen * 0.04, yscreen * 0.04, r6_308, false, components.elementlist.root)
          else
            guiStaticImageLoadImage(components.elementlist.image[r5_308], r6_308)
          end
          local r11_308 = string.format("%02X%02X%02X%02X", a or 255, r7_308, r8_308, r9_308)
          guiSetProperty(components.elementlist.image[r5_308], "ImageColours", "tl:" .. r11_308 .. " tr:" .. r11_308 .. " bl:" .. r11_308 .. " br:" .. r11_308)
        else
          destroyElement(components.elementlist.image[r5_308])
          components.elementlist.image[r5_308] = nil
        end
      end
    end
    if r0_308 == "playerlist" then
      local r1_308 = {}
      for r5_308, r6_308 in ipairs(getElementsByType("player")) do
        if getPlayerGameStatus(r6_308) == "Play" or getPlayerGameStatus(r6_308) == "Die" then
          table.insert(r1_308, r6_308)
        end
      end
      if components.playerlist.custom.sort ~= nil and 1 < #r1_308 then
        table.sort(r1_308, function(r0_309, r1_309)
          -- line: [218, 222] id: 309
          local r2_309 = components.playerlist.custom.func(r0_309)
          local r3_309 = components.playerlist.custom.func(r1_309)
          local r4_309 = components.playerlist.custom.sort
          if not r4_309 or r3_309 >= r2_309 then
            r4_309 = r2_309 < r3_309
          else
            goto label_23	-- block#4 is visited secondly
          end
          return r4_309
        end)
      end
      local r2_308 = {
        0,
        0
      }
      local r3_308 = false
      local r4_308 = math.min(#r1_308, components.playerlist.custom.rows or 2)
      for r8_308 = 1, math.max(r4_308, components.playerlist.rows), 1 do
        if r8_308 <= r4_308 then
          local r9_308 = r1_308[r8_308]
          if r9_308 == localPlayer then
            r3_308 = true
          end
          if r8_308 == r4_308 and not r3_308 and getPlayerTeam(localPlayer) ~= getElementsByType("team")[1] then
            r9_308 = localPlayer
          end
          local r10_308 = getPlayerName(r9_308)
          local r11_308 = components.playerlist.custom.func
          if r11_308 then
            r11_308 = components.playerlist.custom.func(r9_308) or tostring(getElementData(r9_308, "Kills"))
          else
            goto label_244	-- block#37 is visited secondly
          end
          local r12_308 = type(components.playerlist.custom.icon)
          if r12_308 == "string" then
            r12_308 = components.playerlist.custom.icon
            if not r12_308 then
              ::label_264::
              r12_308 = type(components.playerlist.custom.icon)
              if r12_308 == "function" then
                r12_308 = components.playerlist.custom.icon(r9_308) or "images/frag.png"
              else
                goto label_280	-- block#42 is visited secondly
              end
            end
          else
            goto label_264	-- block#40 is visited secondly
          end
          if not components.playerlist.players[r8_308] then
            components.playerlist.rows = components.playerlist.rows + 1
            components.playerlist.players[r8_308] = guiCreateLabel(0, (r8_308 - 1) * r0_303, xscreen, r0_303, r10_308, false, components.playerlist.players.root)
            guiSetFont(components.playerlist.players[r8_308], "clear-normal")
            components.playerlist.icon[r8_308] = guiCreateStaticImage(0, (r8_308 - 1) * r0_303, r0_303, r0_303, r12_308, false, components.playerlist.info.root)
            setElementParent(components.playerlist.icon[r8_308], components.playerlist.players[r8_308])
            components.playerlist.info[r8_308] = guiCreateLabel(r0_303 + 5, (r8_308 - 1) * r0_303, xscreen, r0_303, r11_308, false, components.playerlist.info.root)
            setElementParent(components.playerlist.info[r8_308], components.playerlist.players[r8_308])
            guiSetFont(components.playerlist.info[r8_308], "clear-normal")
          else
            if guiGetText(components.playerlist.players[r8_308]) ~= r10_308 then
              guiSetText(components.playerlist.players[r8_308], r10_308)
            end
            if guiGetText(components.playerlist.info[r8_308]) ~= r11_308 then
              guiSetText(components.playerlist.info[r8_308], r11_308)
            end
            if type(components.playerlist.custom.icon) == "function" then
              guiStaticImageLoadImage(components.playerlist.icon[r8_308], r12_308)
            end
          end
          r2_308[1] = math.max(r2_308[1], dxGetTextWidth(r10_308, 1, "clear"))
          r2_308[2] = math.max(r2_308[2], dxGetTextWidth(r11_308, 1, "clear"))
        else
          destroyElement(components.playerlist.players[r8_308])
          components.playerlist.players[r8_308] = nil
          components.playerlist.rows = components.playerlist.rows - 1
        end
      end
      components.playerlist.rows = r4_308
      if guiGetSize(components.playerlist.players.root, false) ~= r2_308[1] then
        guiSetSize(components.playerlist.players.root, r2_308[1], r4_308 * r0_303, false)
        guiSetPosition(components.playerlist.info.root, 5 + r2_308[1] + 5, 2, false)
      end
      if guiGetSize(components.playerlist.info.root, false) ~= r0_303 + 5 + r2_308[2] then
        guiSetSize(components.playerlist.info.root, r0_303 + 5 + r2_308[2], yscreen, false)
      end
      local r5_308, r6_308 = guiGetSize(components.playerlist.root, false)
      if r5_308 ~= 5 + r2_308[1] + 5 + r0_303 + 5 + r2_308[2] + 5 or r6_308 ~= 2 + r4_308 * r0_303 + 2 then
        guiSetSize(components.playerlist.root, 5 + r2_308[1] + 5 + r0_303 + 5 + r2_308[2] + 5, 2 + r4_308 * r0_303 + 2, false)
        guiSetPosition(components.playerlist.root, xscreen * 0.95 - 5 + r2_308[1] + 5 + r0_303 + 5 + r2_308[2] + 5, yscreen * 0.935 - 2 + r4_308 * r0_303 + 2, false)
      end
    end
    if r0_308 == "race" then
      local r1_308 = getCameraTarget() and getVehicleOccupant(r1_308)
      if not r1_308 then
        return 
      end
      local r2_308 = 0
      local r3_308 = 2
      if components.race.custom.timepass and getRoundState() ~= "finished" then
        local r4_308 = 0
        local r5_308 = getTacticsData("timestart")
        if r5_308 then
          local r6_308 = math.max
          local r7_308 = 0
          local r8_308 = isRoundPaused()
          if r8_308 then
            r8_308 = r5_308 or getTickCount() + addTickCount - r5_308
          else
            goto label_639	-- block#72 is visited secondly
          end
          r4_308 = r6_308(r7_308, r8_308)
        end
        local r6_308 = MSecToTime(r4_308, 2)
        r2_308 = math.max(r2_308, dxGetTextWidth(r6_308, 1, "clear"))
        timepassrow = r3_308
        r3_308 = r3_308 + 1
        if guiGetText(components.race.timepass) ~= r6_308 then
          guiSetText(components.race.timepass, r6_308)
        end
      end
      if components.race.custom.checkpoints then
        local r4_308 = tostring(getElementData(r1_308, "Checkpoint")) .. "/" .. #getElementsByType("checkpoint")
        r2_308 = math.max(r2_308, dxGetTextWidth(r4_308, 1, "clear"))
        checkpointrow = r3_308
        r3_308 = r3_308 + 1
        if guiGetText(components.race.checkpoint) ~= r4_308 then
          guiSetText(components.race.checkpoint, r4_308)
        end
      end
      if type(components.race.custom.info) == "function" then
        local r4_308 = tostring(components.race.custom.info(r1_308))
        r2_308 = math.max(r2_308, dxGetTextWidth(r4_308, 1, "clear"))
        inforow = r3_308
        r3_308 = r3_308 + 1
        if guiGetText(components.race.info) ~= r4_308 then
          guiSetText(components.race.info, r4_308)
        end
      end
      local r4_308 = getElementData(r1_308, "Rank") or 0
      r2_308 = math.max(r2_308, 2 * dxGetTextWidth(r4_308, 1, "diploma"))
      if guiGetText(components.race.rank) ~= r4_308 then
        guiSetText(components.race.rank, r4_308)
      end
      local r5_308 = 0
      for r9_308, r10_308 in ipairs(getTacticsData("Sides")) do
        r5_308 = r5_308 + countPlayersInTeam(r10_308)
      end
      local r6_308 = tostring(r5_308)
      r5_308 = r6_308
      if r4_308 < 10 or 20 < r4_308 then
        r6_308 = ({
          [1] = "st",
          [2] = "nd",
          [3] = "rd",
        })[r4_308 % 10] or "th"
      else
        goto label_819	-- block#92 is visited secondly
      end
      r2_308 = math.max(r2_308, 2 * dxGetTextWidth(r6_308, 1, "clear"), 2 * dxGetTextWidth(r5_308, 1, "clear"))
      if guiGetText(components.race.players) ~= r6_308 .. "\n/" .. r5_308 then
        guiSetText(components.race.players, r6_308 .. "\n/" .. r5_308)
      end
      local r7_308, r8_308 = guiGetSize(components.race.root, false)
      if r7_308 ~= 5 + r2_308 + 5 or r8_308 ~= 2 + r3_308 * r0_303 + 2 then
        guiSetSize(components.race.root, 5 + r2_308 + 5, 2 + r3_308 * r0_303 + 2, false)
        guiSetPosition(components.race.root, xscreen * 0.95 - 5 + r2_308 + 5, yscreen * 0.935 - 2 + r3_308 * r0_303 + 2, false)
        guiSetSize(components.race.rank, 5 + r2_308 / 2, 2 * r0_303, false)
        guiSetPosition(components.race.players, 5 + r2_308 / 2, 0, false)
        if timepassrow then
          guiSetPosition(components.race.timepass, 0, 2 + timepassrow * r0_303, false)
          guiSetSize(components.race.timepass, 5 + r2_308 + 5, r0_303, false)
        end
        if checkpointrow then
          guiSetPosition(components.race.checkpoint, 0, 2 + checkpointrow * r0_303, false)
          guiSetSize(components.race.checkpoint, 5 + r2_308 + 5, r0_303, false)
        end
        if inforow then
          guiSetPosition(components.race.info, 0, 2 + inforow * r0_303, false)
          guiSetSize(components.race.info, 5 + r2_308 + 5, r0_303, false)
        end
      end
    end
    if r0_308 == "teamlist" then
      local r1_308 = getElementsByType("team")
      table.remove(r1_308, 1)
      if components.teamlist.custom.sort ~= nil and 1 < #r1_308 then
        table.sort(r1_308, function(r0_310, r1_310)
          -- line: [357, 361] id: 310
          local r2_310 = components.teamlist.custom.func(r0_310)
          local r3_310 = components.teamlist.custom.func(r1_310)
          local r4_310 = components.teamlist.custom.sort
          if not r4_310 or r3_310 >= r2_310 then
            r4_310 = r2_310 < r3_310
          else
            goto label_23	-- block#4 is visited secondly
          end
          return r4_310
        end)
      end
      local r2_308 = {
        0,
        0,
        0
      }
      local r3_308 = false
      local r4_308 = math.min(#r1_308, components.teamlist.custom.rows or 3)
      for r8_308 = 1, math.max(r4_308, components.teamlist.rows), 1 do
        if r8_308 <= r4_308 then
          local r9_308 = r1_308[r8_308]
          if r9_308 == getPlayerTeam(localPlayer) then
            r3_308 = true
          end
          if r8_308 == r4_308 and not r3_308 and getPlayerTeam(localPlayer) ~= getElementsByType("team")[1] then
            r9_308 = getPlayerTeam(localPlayer) or r1_308[r8_308]
          end
          local r10_308 = getTeamName(r9_308)
          local r11_308 = 0
          for r15_308, r16_308 in ipairs(getPlayersInTeam(r9_308)) do
            if getElementData(r16_308, "Status") == "Play" then
              r11_308 = r11_308 + 1
            end
          end
          r11_308 = tostring(r11_308)
          local r12_308 = components.teamlist.custom.func
          if r12_308 then
            r12_308 = components.teamlist.custom.func(r9_308) or tostring(getElementData(r9_308, "Score"))
          else
            goto label_1107	-- block#124 is visited secondly
          end
          local r13_308 = type(components.teamlist.custom.icon)
          if r13_308 == "string" then
            r13_308 = components.teamlist.custom.icon
            if not r13_308 then
              ::label_1127::
              r13_308 = type(components.teamlist.custom.icon)
              if r13_308 == "function" then
                r13_308 = components.teamlist.custom.icon(r9_308) or "images/score.png"
              else
                goto label_1143	-- block#129 is visited secondly
              end
            end
          else
            goto label_1127	-- block#127 is visited secondly
          end
          if not components.teamlist.players[r8_308] then
            components.teamlist.rows = components.teamlist.rows + 1
            components.teamlist.players[r8_308] = guiCreateLabel(0, (r8_308 - 1) * r0_303, xscreen, r0_303, r11_308, false, components.teamlist.players.root)
            guiSetFont(components.teamlist.players[r8_308], "clear-normal")
            components.teamlist.teamname[r8_308] = guiCreateLabel(0, (r8_308 - 1) * r0_303, xscreen, r0_303, r10_308, false, components.teamlist.teamname.root)
            guiLabelSetColor(components.teamlist.teamname[r8_308], getTeamColor(r9_308))
            setElementParent(components.teamlist.teamname[r8_308], components.teamlist.players[r8_308])
            guiSetFont(components.teamlist.teamname[r8_308], "clear-normal")
            components.teamlist.icon[r8_308] = guiCreateStaticImage(0, (r8_308 - 1) * r0_303, r0_303, r0_303, r13_308, false, components.teamlist.info.root)
            setElementParent(components.teamlist.icon[r8_308], components.teamlist.players[r8_308])
            components.teamlist.info[r8_308] = guiCreateLabel(r0_303 + 5, (r8_308 - 1) * r0_303, xscreen, r0_303, r12_308, false, components.teamlist.info.root)
            setElementParent(components.teamlist.info[r8_308], components.teamlist.players[r8_308])
            guiSetFont(components.teamlist.info[r8_308], "clear-normal")
          else
            if guiGetText(components.teamlist.teamname[r8_308]) ~= r10_308 then
              guiSetText(components.teamlist.teamname[r8_308], r10_308)
            end
            guiLabelSetColor(components.teamlist.teamname[r8_308], getTeamColor(r9_308))
            if guiGetText(components.teamlist.players[r8_308]) ~= r11_308 then
              guiSetText(components.teamlist.players[r8_308], r11_308)
            end
            if guiGetText(components.teamlist.info[r8_308]) ~= r12_308 then
              guiSetText(components.teamlist.info[r8_308], r12_308)
            end
            if type(components.teamlist.custom.icon) == "function" then
              guiStaticImageLoadImage(components.teamlist.icon[r8_308], r13_308)
            end
          end
          r2_308[1] = math.max(r2_308[1], dxGetTextWidth(r10_308, 1, "clear"))
          r2_308[2] = math.max(r2_308[2], dxGetTextWidth(r11_308, 1, "clear"))
          r2_308[3] = math.max(r2_308[3], dxGetTextWidth(r12_308, 1, "clear"))
        else
          destroyElement(components.teamlist.players[r8_308])
          components.teamlist.players[r8_308] = nil
          components.teamlist.rows = components.teamlist.rows - 1
        end
      end
      components.teamlist.rows = r4_308
      if guiGetSize(components.teamlist.teamname.root, false) ~= r2_308[1] then
        guiSetSize(components.teamlist.teamname.root, r2_308[1], yscreen, false)
        guiSetPosition(components.teamlist.players.root, 5 + r2_308[1] + 5, 2, false)
        guiSetPosition(components.teamlist.info.root, 5 + r2_308[1] + 5 + r2_308[2] + 5, 2, false)
      end
      if guiGetSize(components.teamlist.players.root, false) ~= r2_308[2] then
        guiSetSize(components.teamlist.players.root, r2_308[2], yscreen, false)
        guiSetPosition(components.teamlist.info.root, 5 + r2_308[1] + 5 + r2_308[2] + 5, 2, false)
      end
      if guiGetSize(components.teamlist.info.root, false) ~= r0_303 + 5 + r2_308[3] then
        guiSetSize(components.teamlist.info.root, r0_303 + 5 + r2_308[3], yscreen, false)
      end
      local r5_308, r6_308 = guiGetSize(components.teamlist.root, false)
      if r5_308 ~= 5 + r2_308[1] + 5 + r2_308[2] + 5 + r0_303 + 5 + r2_308[3] + 5 or r6_308 ~= 2 + r4_308 * r0_303 + 2 then
        guiSetSize(components.teamlist.root, 5 + r2_308[1] + 5 + r2_308[2] + 5 + r0_303 + 5 + r2_308[3] + 5, 2 + r4_308 * r0_303 + 2, false)
        guiSetPosition(components.teamlist.root, xscreen * 0.95 - 5 + r2_308[1] + 5 + r2_308[2] + 5 + r0_303 + 5 + r2_308[3] + 5, yscreen * 0.935 - 2 + r4_308 * r0_303 + 2, false)
      end
    end
    if r0_308 == "timeleft" then
      local r1_308 = guiGetText(components.timeleft.text)
      local r2_308 = "--:--"
      if getRoundState() == "stopped" then
        r2_308 = getTacticsData("modes", getTacticsData("Map"), "timelimit")
        if r2_308 then
          r2_308 = r2_308
        end
      elseif type(components.timeleft.custom.text) == "string" then
        r2_308 = components.timeleft.custom.text
      elseif type(components.timeleft.custom.text) == "function" then
        r2_308 = components.timeleft.custom.text()
      else
        local r3_308 = getTacticsData("timeleft")
        if r3_308 then
          local r4_308 = getTacticsData("Pause") or r3_308 - getTickCount() + addTickCount
          if type(r4_308) ~= "number" or r4_308 < 0 then
            r4_308 = 0
          end
          r2_308 = MSecToTime(r4_308, 0)
        end
      end
      if r1_308 ~= r2_308 and getRoundState() ~= "finished" then
        if r2_308 == "5:00" and r1_308 == "5:01" then
          playVoice("audio/last_five_minutes.mp3")
        elseif r2_308 == "1:00" and r1_308 == "1:01" then
          playVoice("audio/last_minute.mp3")
        end
        if r1_308 ~= r2_308 then
          guiSetText(components.timeleft.text, r2_308)
          local r3_308 = dxGetTextWidth(r2_308, 1, "clear") + 10
          guiSetPosition(components.timeleft.root, (xscreen - r3_308) * 0.5, yscreen * 0.053, false)
          guiSetSize(components.timeleft.root, r3_308, 20, false)
        end
      end
    end
  end
  function dxDrawAnimatedImage(r0_311, r1_311)
    -- line: [469, 474] id: 311
    if type(dataAnimatedImages) ~= "table" then
      dataAnimatedImages = {}
    end
    table.insert(dataAnimatedImages, {
      r0_311,
      r1_311,
      getTickCount()
    })
    if #dataAnimatedImages == 1 then
      addEventHandler("onClientRender", root, onClientAnimatedImagesRender)
    end
    return #dataAnimatedImages
  end
  function dxStopAnimatedImage(r0_312)
    -- line: [475, 482] id: 312
    if dataAnimatedImages[r0_312] then
      table.remove(dataAnimatedImages, r0_312)
      if #dataAnimatedImages == 0 then
        removeEventHandler("onClientRender", root, onClientAnimatedImagesRender)
      end
      return true
    end
    return false
  end
  function onClientAnimatedImagesRender()
    -- line: [483, 523] id: 313
    for r3_313, r4_313 in ipairs(dataAnimatedImages) do
      local r5_313, r6_313, r7_313 = unpack(r4_313)
      local r8_313 = getTickCount() - r7_313
      if r6_313 == 1 then
        if r8_313 < 100 then
          local r9_313 = 1 - r8_313 / 100
          dxDrawImage(xscreen * 0.5 - 64 - yscreen * r9_313, yscreen * 0.3 - 32 - yscreen * 0.5 * r9_313, yscreen * r9_313 + 128, yscreen * r9_313 + 64, r5_313, 0, 0, 0, tocolor(255, 255, 255, 255 * (1 - r9_313)), true)
        elseif r8_313 < 600 then
          dxDrawImage(xscreen * 0.5 - 64 + xscreen * (r8_313 - 100) / 500 * 0.1, yscreen * 0.3 - 32, 128, 64, r5_313, 0, 0, 0, 4294967295, true)
        elseif r8_313 < 700 then
          local r9_313 = (r8_313 - 600) / 100
          dxDrawImage(xscreen * 0.6 - 64 + xscreen * r9_313 * 0.4, yscreen * 0.3 - 32, 128, 64, r5_313, 0, 0, 0, tocolor(255, 255, 255, 255 * (1 - r9_313)), true)
        else
          table.remove(dataAnimatedImages, r3_313)
          if #dataAnimatedImages == 0 then
            return removeEventHandler("onClientRender", root, onClientAnimatedImagesRender)
          end
        end
      elseif r6_313 == 2 then
        if r8_313 < 100 then
          local r9_313 = 1 - r8_313 / 100
          dxDrawImage(xscreen * 0.5 - 64 + 32 * r9_313, yscreen * 0.3 - 32 - yscreen * 0.25 * r9_313, yscreen * r9_313 + 128, yscreen * r9_313 + 64, r5_313, 30 * r9_313, 0, 0, tocolor(255, 255, 255, 255 * (1 - r9_313)), true)
        elseif r8_313 < 150 then
          local r9_313 = (r8_313 - 100) / 50
          dxDrawImage(xscreen * 0.5 - 64 - 128 * r9_313, yscreen * 0.3 - 32 - 64 * r9_313, 256 * r9_313 + 128, 128 * r9_313 + 64, r5_313, 0, 0, 0, 4294967295, true)
        elseif r8_313 < 200 then
          local r9_313 = 1 - (r8_313 - 150) / 50
          dxDrawImage(xscreen * 0.5 - 64 - 128 * r9_313, yscreen * 0.3 - 32 - 64 * r9_313, 256 * r9_313 + 128, 128 * r9_313 + 64, r5_313, 0, 0, 0, 4294967295, true)
        elseif r8_313 < 2200 then
          local r9_313 = (r8_313 - 200) / 2000
          dxDrawImage(xscreen * 0.5 - 64 + 16 * r9_313, yscreen * 0.3 - 32 + 8 * r9_313, 128 - 32 * r9_313, 64 - 16 * r9_313, r5_313, 0, 0, 0, 4294967295, true)
        elseif r8_313 < 2300 then
          local r9_313 = (r8_313 - 2200) / 100
          dxDrawImage(xscreen * 0.5 - 48, yscreen * 0.3 - 24 + yscreen * 0.5 * r9_313, 96, 48, r5_313, 0, 0, 0, tocolor(255, 255, 255, 255 * (1 - r9_313)), true)
        else
          table.remove(dataAnimatedImages, r3_313)
          if #dataAnimatedImages == 0 then
            return removeEventHandler("onClientRender", root, onClientAnimatedImagesRender)
          end
        end
      end
    end
  end
  nitroLevel = nil
  local r1_303 = nil
  local r2_303 = nil
  local r3_303 = nil
  function onClientNitroPreRender(r0_314)
    -- line: [528, 619] id: 314
    local r1_314 = getPedOccupiedVehicle(localPlayer)
    if r1_314 and getVehicleOccupant(r1_314) == localPlayer then
      r3_303 = r1_314
      local r2_314 = getVehicleUpgradeOnSlot(r1_314, 8)
      local r3_314 = getVehicleType(r1_314)
      if (0 < r2_314 or nitroLevel) and (r3_314 == "Automobile" or r3_314 == "Quad" or r3_314 == "Monster Truck") then
        if not nitroLevel then
          nitroLevel = getElementData(r1_314, "nitroLevel") or 20000
          guiSetPosition(components.nitro.level, 0, 1 - nitroLevel / 20000, true)
          guiSetSize(components.nitro.level, 1, nitroLevel / 20000, true)
          guiSetVisible(components.nitro.root, true)
        end
        local r4_314 = guiGetText(config_gameplay_nitrocontrol)
        if r4_314 == "Normal" and (getControlState("vehicle_fire") or getControlState("vehicle_secondary_fire")) and not r1_303 then
          r1_303 = 20000
          guiSetProperty(components.nitro.level, "ImageColours", "tl:6000C0FF tr:6000C0FF bl:6000C0FF br:6000C0FF")
        elseif r4_314 == "Hold" then
          if (getControlState("vehicle_fire") or getControlState("vehicle_secondary_fire")) and not r1_303 then
            r1_303 = 20000
            guiSetProperty(components.nitro.level, "ImageColours", "tl:6000C0FF tr:6000C0FF bl:6000C0FF br:6000C0FF")
            callServerFunction("removeVehicleUpgrade", r1_314, r2_314)
            removeVehicleUpgrade(r1_314, r2_314)
            addVehicleUpgrade(r1_314, r2_314)
            callServerFunction("addVehicleUpgrade", r1_314, r2_314)
          elseif r1_303 then
            callServerFunction("removeVehicleUpgrade", r1_314, r2_314)
            removeVehicleUpgrade(r1_314, r2_314)
            setElementData(r1_314, "nitroLevel", nitroLevel)
            r1_303 = nil
            guiSetProperty(components.nitro.level, "ImageColours", "tl:60006080 tr:60006080 bl:60006080 br:60006080")
            addVehicleUpgrade(r1_314, r2_314)
            callServerFunction("addVehicleUpgrade", r1_314, r2_314)
          end
        elseif r4_314 == "Toggle" then
          r2_303 = nil
        end
        if r1_303 then
          r1_303 = r1_303 - r0_314 * getGameSpeed()
          nitroLevel = nitroLevel - r0_314 * getGameSpeed()
          guiSetPosition(components.nitro.level, 0, 1 - nitroLevel / 20000, true)
          guiSetSize(components.nitro.level, 1, nitroLevel / 20000, true)
          if nitroLevel <= 0 then
            callServerFunction("removeVehicleUpgrade", r1_314, r2_314)
            removeVehicleUpgrade(r1_314, r2_314)
            setElementData(r1_314, "nitroLevel", nil)
            guiSetVisible(components.nitro.root, false)
            nitroLevel = nil
            r1_303 = nil
            guiSetProperty(components.nitro.level, "ImageColours", "tl:60006080 tr:60006080 bl:60006080 br:60006080")
          end
        end
      elseif nitroLevel then
        nitroLevel = nil
        r1_303 = nil
        guiSetProperty(components.nitro.level, "ImageColours", "tl:60006080 tr:60006080 bl:60006080 br:60006080")
        setElementData(r1_314, "nitroLevel", nil)
        guiSetVisible(components.nitro.root, false)
      end
    elseif nitroLevel then
      if isElement(r3_303) then
        setElementData(r3_303, "nitroLevel", nitroLevel)
      end
      nitroLevel = nil
      r1_303 = nil
      guiSetProperty(components.nitro.level, "ImageColours", "tl:60006080 tr:60006080 bl:60006080 br:60006080")
      guiSetVisible(components.nitro.root, false)
    end
    -- warn: not visited block [27, 28, 29, 30]
    -- block#27:
    -- _u2 = true
    -- if not _u1
    -- block#28:
    -- -- <empty>
    -- _u1 = 20000
    -- guiSetProperty(components.nitro.level, "ImageColours", "tl:6000C0FF tr:6000C0FF bl:6000C")
    -- goto label_244
    -- block#29:
    -- if _u1
    -- block#30:
    -- -- <empty>
    -- _u1 = nil
    -- guiSetProperty(components.nitro.level, "ImageColours", "tl:60006080 tr:60006080 bl:60006")
    -- setControlState("vehicle_fire", false)
    -- setControlState("vehicle_secondary_fire", false)
    -- callServerFunction("removeVehicleUpgrade", r1_314, r2_314)
    -- removeVehicleUpgrade(r1_314, r2_314)
    -- addVehicleUpgrade(r1_314, r2_314)
    -- callServerFunction("addVehicleUpgrade", r1_314, r2_314)
    -- goto label_244
  end
  addEventHandler("onClientPreRender", root, onClientNitroPreRender)
  local r4_303 = nil
  local r5_303 = 0
  infowindow = guiCreateStaticImage(0.3, 0.838, 0.7, 0.1, "images/color_pixel.png", true)
  guiSetProperty(infowindow, "ImageColours", "tl:80000000 tr:80000000 bl:80000000 br:80000000")
  guiSetVisible(infowindow, false)
  local r6_303 = guiCreateLabel(5, 5, xscreen * 0.7 - 10, yscreen, "", false, infowindow)
  function outputInfo(r0_315, r1_315)
    -- line: [628, 644] id: 315
    if type(r0_315) ~= "string" or #r0_315 < 1 then
      return false
    end
    if guiGetText(r6_303) ~= r0_315 then
      guiSetText(r6_303, r0_315)
      local r2_315 = dxGetTextWidth(r0_315, 1, "default")
      local r3_315 = dxGetFontHeight(1, "default") * (string.count(r0_315, "\n") + 1)
      guiSetPosition(infowindow, 0.225, 0.938 - (r3_315 + 10) / yscreen, true)
      guiSetSize(infowindow, r2_315 + 10, r3_315 + 10, false)
      r5_303 = r5_303 + 1
    end
    if not guiGetVisible(infowindow) and 0.1 < guiGetAlpha(infowindow) then
      playSoundFrontEnd(11)
    end
    guiSetVisible(infowindow, true)
    if not r1_315 then
      r1_315 = 5000
    end
    if isTimer(r4_303) then
      killTimer(r4_303)
    end
    r4_303 = setTimer(guiSetVisible, r1_315, 1, infowindow, false)
    return r5_303
  end
  function hideInfo(r0_316)
    -- line: [645, 652] id: 316
    if r5_303 == r0_316 or not r0_316 then
      if isTimer(r4_303) then
        killTimer(r4_303)
      end
      guiSetVisible(infowindow, false)
      return true
    end
    return false
  end
end)()
(function(...)
  -- line: [0, 0] id: 317
  currentMenu = 1
  currentTeam = 0
  currentSkin = {}
  currentPed = {}
  currentCamera = {}
  function onClientResourceStart(r0_318)
    -- line: [12, 46] id: 318
    joining_background = guiCreateStaticImage(0, 0, 1, 1, "images/color_pixel.png", true)
    guiSetProperty(joining_background, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    guiSetVisible(joining_background, false)
    joining_selection = guiCreateStaticImage(0.04500000000000001, 0.745, 0.31, 0.05, "images/color_pixel.png", true, joining_background)
    guiSetProperty(joining_selection, "ImageColours", "tl:40FFFFFF tr:40FFFFFF bl:40FFFFFF br:40FFFFFF")
    guiSetEnabled(joining_selection, false)
    joining_credits = guiCreateLabel(0.05000000000000002, 0.6000000000000001, 0.3, 0.04, "Credits", true, joining_background)
    guiSetFont(joining_credits, "sa-header")
    guiLabelSetHorizontalAlign(joining_credits, "center")
    guiLabelSetVerticalAlign(joining_credits, "center")
    joining_language = guiCreateLabel(0.05000000000000002, 0.65, 0.3, 0.04, "Language", true, joining_background)
    guiSetFont(joining_language, "sa-header")
    guiLabelSetHorizontalAlign(joining_language, "center")
    guiLabelSetVerticalAlign(joining_language, "center")
    joining_skinleft = guiCreateStaticImage(0.05000000000000002, 0.7000000000000001, 0.04, 0.04, "images/key_arrow_l.png", true, joining_background)
    guiSetVisible(joining_skinleft, false)
    joining_skinname = guiCreateLabel(0.09000000000000001, 0.7000000000000001, 0.22, 0.04, "", true, joining_background)
    guiSetVisible(joining_skinname, false)
    guiSetFont(joining_skinname, "sa-header")
    guiLabelSetHorizontalAlign(joining_skinname, "center")
    guiLabelSetVerticalAlign(joining_skinname, "center")
    joining_skinright = guiCreateStaticImage(0.31, 0.7000000000000001, 0.04, 0.04, "images/key_arrow_r.png", true, joining_background)
    guiSetVisible(joining_skinright, false)
    joining_teamleft = guiCreateStaticImage(0.05000000000000002, 0.75, 0.04, 0.04, "images/key_arrow_l.png", true, joining_background)
    joining_teamname = guiCreateLabel(0.09000000000000001, 0.75, 0.22, 0.04, "Auto-assign", true, joining_background)
    guiSetFont(joining_teamname, "sa-header")
    guiLabelSetHorizontalAlign(joining_teamname, "center")
    guiLabelSetVerticalAlign(joining_teamname, "center")
    joining_teamright = guiCreateStaticImage(0.31, 0.75, 0.04, 0.04, "images/key_arrow_r.png", true, joining_background)
    joining_spawn = guiCreateLabel(0.05000000000000002, 0.8, 0.3, 0.04, "Join to game", true, joining_background)
    guiSetFont(joining_spawn, "sa-header")
    guiLabelSetHorizontalAlign(joining_spawn, "center")
    guiLabelSetVerticalAlign(joining_spawn, "center")
  end
  function onClientJoiningRender()
    -- line: [47, 53] id: 319
    if guiGetVisible(joining_background) then
      dxDrawRectangle(0, 0, xscreen * 0.4, yscreen, 4278190080)
    end
    local r0_319, r1_319, r2_319, r3_319, r4_319, r5_319 = getCameraMatrix()
    local r6_319, r7_319, r8_319, r9_319, r10_319, r11_319 = unpack(currentCamera)
    local r12_319 = 0.1
    setCameraMatrix(r0_319 + r12_319 * (r6_319 - r0_319), r1_319 + r12_319 * (r7_319 - r1_319), r2_319 + r12_319 * (r8_319 - r2_319), r3_319 + r12_319 * (r9_319 - r3_319), r4_319 + r12_319 * (r10_319 - r4_319), r5_319 + r12_319 * (r11_319 - r5_319))
  end
  function onClientJoiningTimer()
    -- line: [54, 68] id: 320
    if currentTeam == 0 then
      local r0_320 = classtm
      classtm = (classtm or 1) + 1
      local r1_320 = getElementsByType("team")
      if #r1_320 < classtm then
        classtm = 1
      end
      guiLabelSetColor(joining_teamname, getTeamColor(r1_320[classtm]))
    elseif not getPedAnimation(currentPed[currentTeam]) then
      local r0_320 = ({
        "shift",
        "shldr",
        "stretch",
        "strleg",
        "time"
      })[math.random(5)]
      for r4_320, r5_320 in ipairs(currentPed) do
        setPedAnimation(r5_320, "PLAYIDLES", r0_320, -1, false, false, false, false)
      end
    end
  end
  function switchCurrentTeam(r0_321, r1_321, r2_321)
    -- line: [69, 119] id: 321
    if type(r0_321) == "number" then
      r2_321 = r0_321
    end
    local r3_321 = getElementsByType("team")
    table.insert(r3_321, r3_321[1])
    table.remove(r3_321, 1)
    if currentMenu == 2 then
      local r4_321 = getElementData(r3_321[currentTeam], "Skins")
      if not r4_321 then
        r4_321 = {}
        local r5_321 = 71
        -- setlist for #4 failed
      end
      currentSkin[currentTeam] = (currentSkin[currentTeam] + r2_321) % (#r4_321 + 1)
      if currentSkin[currentTeam] > 0 then
        setElementModel(currentPed[currentTeam], r4_321[currentSkin[currentTeam]])
        setPedAnimation(currentPed[currentTeam], "PLAYIDLES", "null")
        guiSetText(joining_skinname, string.format("%i/%i", currentSkin[currentTeam], #r4_321))
      else
        guiSetText(joining_skinname, "Spectate")
      end
    elseif currentMenu == 1 then
      if r2_321 > 0 then
        playSoundFrontEnd(18)
      else
        playSoundFrontEnd(17)
      end
      local r4_321 = currentTeam
      currentTeam = (currentTeam + r2_321) % (#r3_321 + 1)
      if r4_321 and currentPed[r4_321] then
        setElementAlpha(currentPed[r4_321], 0)
      end
      if currentTeam > 0 then
        setElementAlpha(currentPed[currentTeam], 255)
        guiSetText(joining_teamname, getTeamName(r3_321[currentTeam]))
        guiLabelSetColor(joining_teamname, getTeamColor(r3_321[currentTeam]))
        currentCamera = {
          309.5,
          -133.3,
          1004,
          -1197.3,
          1181.2,
          963.9
        }
        if currentTeam < #r3_321 then
          if currentSkin[currentTeam] > 0 then
            local r5_321 = getElementData(r3_321[currentTeam], "Skins")
            if not r5_321 then
              r5_321 = {}
              local r6_321 = 71
              -- setlist for #5 failed
            end
            guiSetText(joining_skinname, string.format("%i/%i", currentSkin[currentTeam], #r5_321))
          else
            guiSetText(joining_skinname, "Spectate")
          end
          guiSetVisible(joining_skinleft, true)
          guiSetVisible(joining_skinname, true)
          guiSetVisible(joining_skinright, true)
        else
          guiSetVisible(joining_skinleft, false)
          guiSetVisible(joining_skinname, false)
          guiSetVisible(joining_skinright, false)
        end
      else
        guiSetText(joining_teamname, "Auto-assign")
        currentCamera = {
          315.6,
          -136.2,
          1005.3,
          2244.4,
          -506.5,
          1382.8
        }
        guiSetVisible(joining_skinleft, false)
        guiSetVisible(joining_skinname, false)
        guiSetVisible(joining_skinright, false)
      end
    end
  end
  function switchCurrentMenu(r0_322, r1_322, r2_322)
    -- line: [120, 145] id: 322
    if not r1_322 then
      r2_322 = r0_322
    end
    local r3_322 = 0
    if type(r2_322) == "number" then
      r3_322 = (currentMenu + r2_322) % 5
      if r3_322 == 2 and (currentTeam == 0 or currentTeam == #getElementsByType("team")) then
        r3_322 = (r3_322 + r2_322) % 5
      end
    else
      r3_322 = tonumber(r2_322) or 0
    end
    if r3_322 == 4 then
      currentCamera = {
        314.7,
        -140.2,
        1005.5,
        1343,
        -1848.7,
        1157.2
      }
    elseif r3_322 == 3 then
      currentCamera = {
        315.1,
        -131.4,
        1004.6,
        1881.5,
        951.9,
        394.4
      }
    elseif currentTeam == 0 then
      currentCamera = {
        315.6,
        -136.2,
        1005.3,
        2244.4,
        -506.5,
        1382.8
      }
    else
      currentCamera = {
        309.5,
        -133.3,
        1004,
        -1197.3,
        1181.2,
        963.9
      }
    end
    if currentMenu ~= r3_322 then
      playSoundFrontEnd(3)
      currentMenu = r3_322
      guiSetPosition(joining_selection, 0.04500000000000001, 0.8 - 0.05 * r3_322 - 0.005, true)
    end
  end
  function selectCurrentTeam()
    -- line: [146, 179] id: 323
    if currentMenu == 0 or currentMenu == 1 or currentMenu == 2 then
      if currentTeam > 0 then
        currentCamera = {
          309.9,
          -132.9,
          1004,
          -1197.3,
          1181.2,
          963.9
        }
      else
        currentCamera = {
          315.4,
          -136.7,
          1005.3,
          2244.4,
          -506.5,
          1382.8
        }
      end
      unbindKey("arrow_l", "down", switchCurrentTeam)
      unbindKey("arrow_r", "down", switchCurrentTeam)
      unbindKey("arrow_u", "down", switchCurrentMenu)
      unbindKey("arrow_d", "down", switchCurrentMenu)
      unbindKey("enter", "down", selectCurrentTeam)
      guiSetVisible(joining_background, false)
      playSoundFrontEnd(11)
      fadeCamera(false, 1)
      setTimer(function()
        -- line: [161, 173] id: 324
        -- notice: unreachable block#6
        if currentTeam > 0 then
          local r0_324 = getElementsByType("team")
          table.insert(r0_324, r0_324[1])
          table.remove(r0_324, 1)
          if not getElementData(r0_324[currentTeam], "Skins") then
            local r1_324 = {
              71
            }
          end
          local r2_324 = setElementData
          local r3_324 = localPlayer
          local r4_324 = "spectateskin"
          local r5_324 = currentSkin[currentTeam]
          if r5_324 <= 0 then
            r5_324 = true
          else
            r5_324 = nil
          end
          r2_324(r3_324, r4_324, r5_324)
          triggerServerEvent("onPlayerTeamSelect", localPlayer, r0_324[currentTeam], getElementModel(currentPed[currentTeam]))
        else
          setElementData(localPlayer, "spectateskin", nil)
          triggerServerEvent("onPlayerTeamSelect", localPlayer)
        end
      end, 1000, 1)
    elseif currentMenu == 3 then
      executeCommandHandler("player_config", "Gameplay")
    elseif currentMenu == 4 then
      executeCommandHandler("credits")
    end
  end
  function onClientElementDataChange(r0_325, r1_325)
    -- line: [180, 232] id: 325
    if r0_325 == "Status" then
      if getElementData(source, r0_325) == "Joining" and r1_325 ~= "Joining" then
        setElementData(localPlayer, "Loading", nil)
        stopCameraPrepair()
        bindKey("arrow_l", "down", switchCurrentTeam, -1)
        bindKey("arrow_r", "down", switchCurrentTeam, 1)
        bindKey("arrow_u", "down", switchCurrentMenu, 1)
        bindKey("arrow_d", "down", switchCurrentMenu, -1)
        bindKey("enter", "down", selectCurrentTeam)
        addEventHandler("onClientRender", root, onClientJoiningRender)
        classAutoChoice = setTimer(onClientJoiningTimer, 200, 0)
        if currentTeam > 0 then
          currentCamera = {
            309.5,
            -133.3,
            1004,
            -1197.3,
            1181.2,
            963.9
          }
        else
          currentCamera = {
            315.6,
            -136.2,
            1005.3,
            2244.4,
            -506.5,
            1382.8
          }
        end
        setCameraMatrix(315.6, -136.2, 1005.3, 2244.4, -506.5, 1382.8)
        setElementInterior(localPlayer, 7)
        setCameraInterior(7)
        local r2_325 = getElementsByType("team")
        table.insert(r2_325, r2_325[1])
        table.remove(r2_325, 1)
        for r6_325, r7_325 in ipairs(r2_325) do
          currentSkin[r6_325] = 1
          local r8_325 = getElementData(r7_325, "Skins")
          if not r8_325 then
            r8_325 = {}
            local r9_325 = 71
            -- setlist for #8 failed
          end
          currentPed[r6_325] = createPed(r8_325[1], 308.2, -131.4, 1004, 220)
          setElementInterior(currentPed[r6_325], 7)
          setElementFrozen(currentPed[r6_325], true)
          if currentTeam ~= r6_325 then
            setElementAlpha(currentPed[r6_325], 0)
          end
        end
        guiSetVisible(joining_background, true)
        showCursor(true)
      elseif getElementData(source, r0_325) ~= "Joining" and r1_325 == "Joining" then
        unbindKey("arrow_l", "down", switchCurrentTeam)
        unbindKey("arrow_r", "down", switchCurrentTeam)
        unbindKey("arrow_u", "down", switchCurrentMenu)
        unbindKey("arrow_d", "down", switchCurrentMenu)
        unbindKey("enter", "down", selectCurrentTeam)
        guiSetVisible(joining_background, false)
        for r5_325, r6_325 in ipairs(currentPed) do
          if isElement(r6_325) then
            destroyElement(r6_325)
          end
        end
        currentPed = {}
        killTimer(classAutoChoice)
        removeEventHandler("onClientRender", root, onClientJoiningRender)
        setCameraTarget(localPlayer)
        updateWeather()
        guiSetVisible(joining_background, false)
        if isAllGuiHidden() then
          showCursor(false)
        end
      end
    end
  end
  function onClientGUIClick(r0_326, r1_326, r2_326, r3_326)
    -- line: [233, 250] id: 326
    if r0_326 ~= "left" then
      return 
    end
    if source == joining_credits then
      executeCommandHandler("credits")
    end
    if source == joining_language then
      executeCommandHandler("player_config", "Gameplay")
    end
    if source == joining_teamleft or source == joining_skinleft then
      switchCurrentTeam(-1)
    end
    if source == joining_teamright or source == joining_skinright then
      switchCurrentTeam(1)
    end
    if source == joining_spawn or source == joining_teamname or source == joining_skinname then
      selectCurrentTeam()
    end
  end
  function onClientMouseEnter(r0_327, r1_327)
    -- line: [251, 267] id: 327
    if source == joining_credits then
      switchCurrentMenu("4")
    end
    if source == joining_language then
      switchCurrentMenu("3")
    end
    if source == joining_skinname or source == joining_skinleft or source == joining_skinright then
      switchCurrentMenu("2")
    end
    if source == joining_teamname or source == joining_teamleft or source == joining_teamright then
      switchCurrentMenu("1")
    end
    if source == joining_spawn then
      switchCurrentMenu("0")
    end
  end
  addEventHandler("onClientResourceStart", resourceRoot, onClientResourceStart)
  addEventHandler("onClientElementDataChange", localPlayer, onClientElementDataChange)
  addEventHandler("onClientGUIClick", root, onClientGUIClick)
  addEventHandler("onClientMouseEnter", root, onClientMouseEnter)
end)()
(function(...)
  -- line: [0, 0] id: 328
  loadedLanguage = false
  fpsdata = {
    {
      0,
      getTickCount()
    }
  }
  plossdata = {
    {
      0,
      getTickCount()
    }
  }
  function onClientResourceStart(r0_329)
    -- line: [10, 201] id: 329
    -- notice: unreachable block#105
    -- notice: unreachable block#9
    -- notice: unreachable block#18
    -- notice: unreachable block#52
    -- notice: unreachable block#61
    -- notice: unreachable block#70
    -- notice: unreachable block#91
    -- notice: unreachable block#98
    -- notice: unreachable block#43
    -- notice: unreachable block#77
    -- notice: unreachable block#84
    -- notice: unreachable block#112
    loadedLanguage = false
    _client = xmlLoadFile("config/_client.xml")
    if not _client then
      _client = xmlCreateFile("config/_client.xml", "config")
    end
    config_window = guiCreateWindow(xscreen * 0.5 - 240, yscreen * 0.5 - 240, 480, 480, "", false)
    guiWindowSetSizable(config_window, false)
    guiSetVisible(config_window, false)
    config_pagelist = guiCreateGridList(5, 25, 120, 420, false, config_window)
    guiGridListSetSortingEnabled(config_pagelist, false)
    guiGridListAddColumn(config_pagelist, "Contents", 0.8)
    config_pages = {
      Settings = {
        Audio = true,
        Gameplay = true,
        Performance = true,
      },
    }
    config_scrollers = {}
    config_scrollers.Audio = guiCreateGridList(135, 25, 340, 460, false, config_window)
    guiSetVisible(config_scrollers.Audio, false)
    local r1_329 = xmlFindChild(_client, "audio", 0)
    if not r1_329 then
      r1_329 = xmlCreateChild(_client, "audio")
      xmlNodeSetAttribute(r1_329, "voice", "true")
      xmlNodeSetAttribute(r1_329, "voicevol", "100")
      xmlNodeSetAttribute(r1_329, "music", "true")
      xmlNodeSetAttribute(r1_329, "musicvol", "100")
    end
    temp = xmlNodeGetAttribute(r1_329, "voice") or "true"
    local r2_329 = guiCreateCheckBox
    local r3_329 = 0.05
    local r4_329 = 0.04
    local r5_329 = 0.33
    local r6_329 = 0.04
    local r7_329 = "Voice Sounds"
    local r8_329 = temp
    if r8_329 == "true" then
      r8_329 = true
    else
      r8_329 = false
    end
    config_audio_voice = r2_329(r3_329, r4_329, r5_329, r6_329, r7_329, r8_329, true, config_scrollers.Audio)
    config_audio_voicevol = guiCreateScrollBar(0.42, 0.04, 0.43, 0.04, true, true, config_scrollers.Audio)
    config_audio_voicelab = guiCreateLabel(0.85, 0.04, 0.1, 0.04, "100%", true, config_scrollers.Audio)
    temp = tonumber(xmlNodeGetAttribute(r1_329, "voicevol") or "100")
    guiScrollBarSetScrollPosition(config_audio_voicevol, temp)
    temp = xmlNodeGetAttribute(r1_329, "music") or "true"
    r2_329 = guiCreateCheckBox
    r3_329 = 0.05
    r4_329 = 0.1
    r5_329 = 0.33
    r6_329 = 0.04
    r7_329 = "Music"
    r8_329 = temp
    if r8_329 == "true" then
      r8_329 = true
    else
      r8_329 = false
    end
    config_audio_music = r2_329(r3_329, r4_329, r5_329, r6_329, r7_329, r8_329, true, config_scrollers.Audio)
    config_audio_musicvol = guiCreateScrollBar(0.42, 0.1, 0.43, 0.04, true, true, config_scrollers.Audio)
    config_audio_musiclab = guiCreateLabel(0.85, 0.1, 0.1, 0.04, "100%", true, config_scrollers.Audio)
    temp = tonumber(xmlNodeGetAttribute(r1_329, "musicvol") or "100")
    guiScrollBarSetScrollPosition(config_audio_musicvol, temp)
    config_scrollers.Gameplay = guiCreateGridList(135, 25, 340, 460, false, config_window)
    guiSetVisible(config_scrollers.Gameplay, false)
    r2_329 = xmlFindChild(_client, "gameplay", 0)
    if not r2_329 then
      r2_329 = xmlCreateChild(_client, "gameplay")
      xmlNodeSetAttribute(r2_329, "language", "language/english.lng")
      xmlNodeSetAttribute(r2_329, "nitrocontrol", "toggle")
    end
    guiCreateLabel(0.05, 0.04, 0.43, 0.04, "Language:", true, config_scrollers.Gameplay)
    r3_329 = xmlNodeGetAttribute(r2_329, "language") or "language/english.lng"
    config_gameplay_language = guiCreateComboBox(0.52, 0.04, 0.43, 0.6, "", true, config_scrollers.Gameplay)
    config_gameplay_languagelist = {}
    r4_329 = xmlLoadFile("language/languages.xml")
    if r4_329 then
      r5_329 = xmlNodeGetChildren(r4_329)
      table.sort(r5_329, function(r0_330, r1_330)
        -- line: [61, 61] id: 330
        return xmlNodeGetAttribute(r0_330, "src") < xmlNodeGetAttribute(r1_330, "src")
      end)
      for r9_329, r10_329 in ipairs(r5_329) do
        local r11_329 = xmlNodeGetAttribute(r10_329, "src")
        local r12_329 = xmlLoadFile(r11_329)
        if r12_329 then
          local r13_329 = xmlNodeGetAttribute(r12_329, "name")
          guiComboBoxAddItem(config_gameplay_language, r13_329)
          config_gameplay_languagelist[r11_329] = r13_329
          config_gameplay_languagelist[r13_329] = r11_329
          if r11_329 == r3_329 then
            guiSetText(config_gameplay_language, r13_329)
          end
          xmlUnloadFile(r12_329)
        end
      end
      xmlUnloadFile(r4_329)
    end
    guiCreateLabel(0.05, 0.1, 0.43, 0.04, "Nitro Control:", true, config_scrollers.Gameplay)
    config_gameplay_nitrocontrol = guiCreateComboBox(0.52, 0.1, 0.43, 0.2, ({
      toggle = "Toggle",
      hold = "Hold",
    })[xmlNodeGetAttribute(r2_329, "nitrocontrol") or "toggle"], true, config_scrollers.Gameplay)
    guiComboBoxAddItem(config_gameplay_nitrocontrol, "Toggle")
    guiComboBoxAddItem(config_gameplay_nitrocontrol, "Hold")
    config_scrollers.Performance = guiCreateGridList(135, 25, 340, 460, false, config_window)
    guiSetVisible(config_scrollers.Performance, false)
    r6_329 = xmlFindChild(_client, "performance", 0)
    if not r6_329 then
      r6_329 = xmlCreateChild(_client, "performance")
      xmlNodeSetAttribute(r6_329, "vehmanager", "false")
      xmlNodeSetAttribute(r6_329, "weapmanager", "false")
      xmlNodeSetAttribute(r6_329, "fpsgraphic", "true")
      xmlNodeSetAttribute(r6_329, "plossgraphic", "true")
      xmlNodeSetAttribute(r6_329, "speclist", "true")
      xmlNodeSetAttribute(r6_329, "roundhud", "true")
      xmlNodeSetAttribute(r6_329, "valueshud", "true")
      xmlNodeSetAttribute(r6_329, "helpinfo", "true")
      xmlNodeSetAttribute(r6_329, "laser", "true")
    end
    config_performance_usecpu = guiCreateLabel(0.05, 0.04, 0.3, 0.06, "CPU: 0.0%", true, config_scrollers.Performance)
    config_performance_usetiming = guiCreateLabel(0.35, 0.04, 0.3, 0.06, "Timing: 0.000", true, config_scrollers.Performance)
    config_performance_usememory = guiCreateLabel(0.65, 0.04, 0.3, 0.06, "Memory: 0 KB", true, config_scrollers.Performance)
    temp = guiCreateLabel(0.05, 0.1, 0.9, 0.06, "Unload hidden GUI", true, config_scrollers.Performance)
    guiSetFont(temp, "default-bold-small")
    guiLabelSetHorizontalAlign(temp, "center")
    temp = xmlNodeGetAttribute(r6_329, "vehmanager") or "false"
    r7_329 = guiCreateCheckBox
    r8_329 = 0.05
    local r9_329 = 0.16
    local r10_329 = 0.43
    local r11_329 = 0.04
    local r12_329 = "Vehicle manager"
    local r13_329 = temp
    if r13_329 == "true" then
      r13_329 = true
    else
      r13_329 = false
    end
    config_performance_vehmanager = r7_329(r8_329, r9_329, r10_329, r11_329, r12_329, r13_329, true, config_scrollers.Performance)
    if temp ~= "true" then
      guiSetVisible(createVehicleManager(), false)
    end
    temp = xmlNodeGetAttribute(r6_329, "weapmanager") or "false"
    r7_329 = guiCreateCheckBox
    r8_329 = 0.52
    r9_329 = 0.16
    r10_329 = 0.43
    r11_329 = 0.04
    r12_329 = "Weapon manager"
    r13_329 = temp
    if r13_329 == "true" then
      r13_329 = true
    else
      r13_329 = false
    end
    config_performance_weapmanager = r7_329(r8_329, r9_329, r10_329, r11_329, r12_329, r13_329, true, config_scrollers.Performance)
    if temp ~= "true" then
      guiSetVisible(createWeaponManager(), false)
    end
    temp = xmlNodeGetAttribute(r6_329, "adminpanel") or "true"
    r7_329 = guiCreateCheckBox
    r8_329 = 0.05
    r9_329 = 0.22
    r10_329 = 0.43
    r11_329 = 0.04
    r12_329 = "Admin Panel"
    r13_329 = temp
    if r13_329 == "true" then
      r13_329 = true
    else
      r13_329 = false
    end
    config_performance_adminpanel = r7_329(r8_329, r9_329, r10_329, r11_329, r12_329, r13_329, true, config_scrollers.Performance)
    if temp ~= "true" then
      guiSetVisible(createAdminPanel(), false)
      guiSetVisible(createAdminRestore(), false)
      guiSetVisible(createAdminRedirect(), false)
      guiSetVisible(createAdminSaveConfig(), false)
      guiSetVisible(createAdminAddConfig(), false)
      guiSetVisible(createAdminRules(), false)
      guiSetVisible(createAdminPalette(), false)
      guiSetVisible(createAdminRenameConfig(), false)
      guiSetVisible(createAdminScreen(), false)
      guiSetVisible(createAdminMods(), false)
    end
    temp = guiCreateLabel(0.05, 0.27999999999999997, 0.9, 0.06, "Rendering", true, config_scrollers.Performance)
    guiSetFont(temp, "default-bold-small")
    guiLabelSetHorizontalAlign(temp, "center")
    temp = xmlNodeGetAttribute(r6_329, "fpsgraphic") or "true"
    r7_329 = guiCreateCheckBox
    r8_329 = 0.05
    r9_329 = 0.33999999999999997
    r10_329 = 0.43
    r11_329 = 0.04
    r12_329 = "FPS Diagram"
    r13_329 = temp
    if r13_329 == "true" then
      r13_329 = true
    else
      r13_329 = false
    end
    config_performance_fps = r7_329(r8_329, r9_329, r10_329, r11_329, r12_329, r13_329, true, config_scrollers.Performance)
    temp = xmlNodeGetAttribute(r6_329, "plossgraphic") or "true"
    r7_329 = guiCreateCheckBox
    r8_329 = 0.05
    r9_329 = 0.39999999999999997
    r10_329 = 0.43
    r11_329 = 0.04
    r12_329 = "PacketLoss Diagram"
    r13_329 = temp
    if r13_329 == "true" then
      r13_329 = true
    else
      r13_329 = false
    end
    config_performance_ploss = r7_329(r8_329, r9_329, r10_329, r11_329, r12_329, r13_329, true, config_scrollers.Performance)
    temp = xmlNodeGetAttribute(r6_329, "helpinfo") or "true"
    r7_329 = guiCreateCheckBox
    r8_329 = 0.05
    r9_329 = 0.45999999999999996
    r10_329 = 0.43
    r11_329 = 0.04
    r12_329 = "Help Info"
    r13_329 = temp
    if r13_329 == "true" then
      r13_329 = true
    else
      r13_329 = false
    end
    config_performance_helpinfo = r7_329(r8_329, r9_329, r10_329, r11_329, r12_329, r13_329, true, config_scrollers.Performance)
    temp = xmlNodeGetAttribute(r6_329, "speclist") or "true"
    r7_329 = guiCreateCheckBox
    r8_329 = 0.52
    r9_329 = 0.33999999999999997
    r10_329 = 0.43
    r11_329 = 0.04
    r12_329 = "Spectate List"
    r13_329 = temp
    if r13_329 == "true" then
      r13_329 = true
    else
      r13_329 = false
    end
    config_performance_spec = r7_329(r8_329, r9_329, r10_329, r11_329, r12_329, r13_329, true, config_scrollers.Performance)
    temp = xmlNodeGetAttribute(r6_329, "roundhud") or "true"
    r7_329 = guiCreateCheckBox
    r8_329 = 0.52
    r9_329 = 0.39999999999999997
    r10_329 = 0.43
    r11_329 = 0.04
    r12_329 = "Round HUD"
    r13_329 = temp
    if r13_329 == "true" then
      r13_329 = true
    else
      r13_329 = false
    end
    config_performance_roundhud = r7_329(r8_329, r9_329, r10_329, r11_329, r12_329, r13_329, true, config_scrollers.Performance)
    temp = xmlNodeGetAttribute(r6_329, "valueshud") or "true"
    r7_329 = guiCreateCheckBox
    r8_329 = 0.52
    r9_329 = 0.45999999999999996
    r10_329 = 0.43
    r11_329 = 0.04
    r12_329 = "Values of HUD"
    r13_329 = temp
    if r13_329 == "true" then
      r13_329 = true
    else
      r13_329 = false
    end
    config_performance_valueshud = r7_329(r8_329, r9_329, r10_329, r11_329, r12_329, r13_329, true, config_scrollers.Performance)
    temp = xmlNodeGetAttribute(r6_329, "laser") or "true"
    r7_329 = guiCreateCheckBox
    r8_329 = 0.05
    r9_329 = 0.52
    r10_329 = 0.43
    r11_329 = 0.04
    r12_329 = "Aim Lasers"
    r13_329 = temp
    if r13_329 == "true" then
      r13_329 = true
    else
      r13_329 = false
    end
    config_performance_laser = r7_329(r8_329, r9_329, r10_329, r11_329, r12_329, r13_329, true, config_scrollers.Performance)
    guiGridListClear(config_pagelist)
    for r10_329, r11_329 in pairs(config_pages) do
      r12_329 = type(r11_329)
      if r12_329 == "table" then
        guiGridListSetItemText(config_pagelist, guiGridListAddRow(config_pagelist), 1, r10_329, true, false)
        r12_329 = pairs
        r13_329 = r11_329
        for r15_329 in r12_329(r13_329) do
          guiGridListSetItemText(config_pagelist, guiGridListAddRow(config_pagelist), 1, r15_329, false, false)
        end
      else
        guiGridListSetItemText(config_pagelist, guiGridListAddRow(config_pagelist), 1, r10_329, false, false)
      end
    end
    config_close = guiCreateButton(5, 450, 120, 30, "Close", false, config_window)
    guiSetFont(config_close, "default-bold-small")
    xmlSaveFile(_client)
    values_hud = guiCreateStaticImage(0, 0, xscreen, yscreen, "images/color_pixel.png", false)
    guiSetProperty(values_hud, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    guiSetVisible(values_hud, false)
    guiSetEnabled(values_hud, false)
    hud_health = guiCreateLabel(xscreen * 0.955, yscreen * 0.158 - 20, 100, 40, "", false, values_hud)
    guiLabelSetVerticalAlign(hud_health, "center")
    guiSetFont(hud_health, "default-bold-small")
    guiLabelSetColor(hud_health, 180, 29, 25)
    hud_armor = guiCreateLabel(xscreen * 0.955, yscreen * 0.11 - 20, 100, 40, "", false, values_hud)
    guiLabelSetVerticalAlign(hud_armor, "center")
    guiSetFont(hud_armor, "default-bold-small")
    guiLabelSetColor(hud_armor, 240, 240, 240)
    hud_fps = guiCreateLabel(xscreen * 0.955, yscreen * 0.012 - 20, 100, 40, "", false)
    guiLabelSetVerticalAlign(hud_fps, "center")
    guiSetFont(hud_fps, "default-bold-small")
    guiLabelSetColor(hud_fps, 0, 255, 0)
    hud_ploss = guiCreateLabel(xscreen * 0.955, yscreen * 0.042 - 20, 100, 40, "", false)
    guiLabelSetVerticalAlign(hud_ploss, "center")
    guiSetFont(hud_ploss, "default-bold-small")
    guiLabelSetColor(hud_ploss, 0, 128, 255)
    if guiCheckBoxGetSelected(config_performance_fps) and getElementData(localPlayer, "Status") ~= "Joining" then
      addEventHandler("onClientRender", root, onClientFPSDiagramRender)
    else
      guiSetVisible(hud_fps, false)
    end
    if guiCheckBoxGetSelected(config_performance_ploss) and getElementData(localPlayer, "Status") ~= "Joining" then
      addEventHandler("onClientRender", root, onClientPLossDiagramRender)
    else
      guiSetVisible(hud_ploss, false)
    end
    if guiCheckBoxGetSelected(config_performance_valueshud) then
      addEventHandler("onClientElementDataChange", localPlayer, onClientValuesHUDElementDataChange)
      if getElementData(localPlayer, "Status") == "Play" then
        addEventHandler("onClientRender", root, onClientValuesHUDRender)
        guiSetVisible(values_hud, true)
      end
    end
  end
  local r0_328 = xscreen * 0.78
  local r1_328 = yscreen * 0.012
  local r2_328 = xscreen * 0.17
  local r3_328 = yscreen * 0.03
  local r4_328 = math.ceil(yscreen * 0.001)
  local r5_328 = xscreen * 0.955
  local r6_328 = 50
  local r7_328 = 0
  local r8_328 = tocolor(0, 255, 0)
  function onClientFPSDiagramRender()
    -- line: [204, 228] id: 331
    local r0_331 = getTickCount()
    local r1_331 = 30000
    for r5_331, r6_331 in ipairs(fpsdata) do
      local r7_331 = 1 - (math.max(math.min(tonumber(r6_331[1]), r6_328), r7_328) - r7_328) / (r6_328 - r7_328)
      local r8_331 = #fpsdata
      if r5_331 < r8_331 then
        r8_331 = 1 - (math.max(math.min(tonumber(fpsdata[r5_331 + 1][1]), r6_328), r7_328) - r7_328) / (r6_328 - r7_328) or r7_331
      else
        goto label_52	-- block#3 is visited secondly
      end
      local r9_331 = math.min(1, (r0_331 - r6_331[2]) / r1_331)
      if r5_331 > 1 then
        local r10_331 = (r0_331 - fpsdata[r5_331 - 1][2]) / r1_331
        if r10_331 >= 1 then
          for r14_331 = r5_331, #fpsdata, 1 do
            table.remove(fpsdata, r5_331)
          end
          break
        else
          dxDrawLine(r0_328 + r2_328 - r2_328 * r9_331, r1_328 + r3_328 * r8_331, r0_328 + r2_328 - r2_328 * r10_331, r1_328 + r3_328 * r7_331, r8_328, r4_328)
        end
      else
        dxDrawLine(r0_328 + r2_328 - r2_328 * r9_331, r1_328 + r3_328 * r8_331, r0_328 + r2_328, r1_328 + r3_328 * r7_331, r8_328, r4_328)
      end
    end
    local r2_331 = tostring(fpsdata[1][1])
    if guiGetText(hud_fps) ~= r2_331 then
      guiSetText(hud_fps, r2_331)
    end
  end
  local r9_328 = 10
  local r10_328 = 0
  local r11_328 = tocolor(0, 128, 255)
  function onClientPLossDiagramRender()
    -- line: [230, 254] id: 332
    local r0_332 = getTickCount()
    local r1_332 = 30000
    for r5_332, r6_332 in ipairs(plossdata) do
      local r7_332 = 1 - (math.max(math.min(tonumber(r6_332[1]), r9_328), r10_328) - r10_328) / (r9_328 - r10_328)
      local r8_332 = #plossdata
      if r5_332 < r8_332 then
        r8_332 = 1 - (math.max(math.min(tonumber(plossdata[r5_332 + 1][1]), r9_328), r10_328) - r10_328) / (r9_328 - r10_328) or r7_332
      else
        goto label_52	-- block#3 is visited secondly
      end
      local r9_332 = math.min(1, (r0_332 - r6_332[2]) / r1_332)
      if r5_332 > 1 then
        local r10_332 = (r0_332 - plossdata[r5_332 - 1][2]) / r1_332
        if r10_332 >= 1 then
          for r14_332 = r5_332, #plossdata, 1 do
            table.remove(plossdata, r5_332)
          end
          break
        else
          dxDrawLine(r0_328 + r2_328 - r2_328 * r9_332, r1_328 + r3_328 * r8_332, r0_328 + r2_328 - r2_328 * r10_332, r1_328 + r3_328 * r7_332, r11_328, r4_328)
        end
      else
        dxDrawLine(r0_328 + r2_328 - r2_328 * r9_332, r1_328 + r3_328 * r8_332, r0_328 + r2_328, r1_328 + r3_328 * r7_332, r11_328, r4_328)
      end
    end
    local r2_332 = string.format("%.2f", plossdata[1][1])
    if guiGetText(hud_ploss) ~= r2_332 then
      guiSetText(hud_ploss, r2_332)
    end
  end
  local r12_328 = 0
  local r13_328 = 0
  local r14_328 = 0
  local r15_328 = 0
  local r16_328 = 0
  local r17_328 = 100
  local r18_328 = 65536
  local r19_328 = 10
  local r20_328 = 10
  local r21_328 = 3
  function onClientFPSCount()
    -- line: [262, 264] id: 333
    r12_328 = r12_328 + 1
  end
  function updateLimites()
    -- line: [265, 311] id: 334
    setElementData(localPlayer, "FPS", tostring(r12_328), false)
    setElementData(localPlayer, "PLoss", tostring(getNetworkStats().packetlossLastSecond), false)
    if r12_328 < r7_328 then
      r14_328 = r14_328 + 1
      if r19_328 < r14_328 then
        callServerFunction("kickPlayer", localPlayer, "Low FPS (" .. r12_328 .. " < " .. r7_328 .. ")")
        r14_328 = 0
      end
    else
      r14_328 = 0
    end
    if r18_328 < getPlayerPing(localPlayer) then
      r15_328 = r15_328 + 1
      if r20_328 < r15_328 then
        callServerFunction("kickPlayer", localPlayer, "High Ping (" .. getPlayerPing(localPlayer) .. " > " .. r18_328 .. ")")
        r15_328 = 0
      end
    else
      r15_328 = 0
    end
    if r9_328 > 0 then
      local r0_334 = getNetworkStats().packetlossLastSecond
      if r9_328 < r0_334 then
        r16_328 = r16_328 + 1
        if r21_328 < r16_328 then
          callServerFunction("kickPlayer", localPlayer, string.format("High Packetloss (%.2f > %.2f)", r0_334, r9_328))
          r16_328 = 0
        end
      else
        r16_328 = 0
      end
    end
    if r17_328 > 0 then
      local r0_334 = getNetworkStats().packetlossTotal
      if r17_328 < r0_334 then
        callServerFunction("kickPlayer", localPlayer, string.format("High Packetloss Total (%.2f > %.2f)", r0_334, r17_328))
      end
    end
    r12_328 = -1
    r13_328 = r13_328 + 1
    if r13_328 > 10 then
      callServerFunction("setElementData", localPlayer, "FPS", getElementData(localPlayer, "FPS"))
      callServerFunction("setElementData", localPlayer, "PLoss", getElementData(localPlayer, "PLoss"))
      r13_328 = 0
    end
  end
  function addUserPanelPage(r0_335, r1_335)
    -- line: [312, 326] id: 335
    if config_scrollers[r1_335] then
      return false
    end
    config_pages[r0_335][r1_335] = true
    config_scrollers[r1_335] = guiCreateGridList(135, 25, 340, 460, false, config_window)
    guiSetVisible(config_scrollers[r1_335], false)
    guiGridListClear(config_pagelist)
    for r5_335, r6_335 in pairs(config_pages) do
      guiGridListSetItemText(config_pagelist, guiGridListAddRow(config_pagelist), 1, r5_335, true, false)
      for r10_335 in pairs(r6_335) do
        guiGridListSetItemText(config_pagelist, guiGridListAddRow(config_pagelist), 1, r10_335, false, false)
      end
    end
    return config_scrollers[r1_335]
  end
  function onClientTacticsChange(r0_336, r1_336)
    -- line: [327, 352] id: 336
    if r0_336[1] == "version" then
      guiSetText(config_window, "Tactics " .. tostring(getTacticsData("version")) .. " - User Panel")
    end
    if r0_336[1] == "limites" then
      if r0_336[2] == "fps_limit" then
        r6_328 = tonumber(getTacticsData("limites", "fps_limit"))
      elseif r0_336[2] == "fps_minimal" then
        r7_328 = tonumber(getTacticsData("limites", "fps_minimal"))
      elseif r0_336[2] == "packetloss_second" then
        r9_328 = tonumber(getTacticsData("limites", "packetloss_second"))
        if r9_328 == 0 then
          r9_328 = 10
        end
      elseif r0_336[2] == "packetloss_total" then
        r17_328 = tonumber(getTacticsData("limites", "packetloss_total"))
      elseif r0_336[2] == "ping_maximal" then
        r18_328 = tonumber(getTacticsData("limites", "ping_maximal"))
      elseif r0_336[2] == "warnings_fps" then
        r19_328 = tonumber(getTacticsData("limites", "warnings_fps"))
      elseif r0_336[2] == "warnings_ping" then
        r20_328 = tonumber(getTacticsData("limites", "warnings_ping"))
      elseif r0_336[2] == "warnings_packetloss" then
        r21_328 = tonumber(getTacticsData("limites", "warnings_packetloss"))
      end
    end
  end
  function checkPerformance()
    -- line: [353, 363] id: 337
    if not guiGetVisible(config_scrollers.Performance) then
      return killTimer(updPerformance)
    end
    local r0_337, r1_337 = getPerformanceStats("Lua timing", "", "tactics")
    local r2_337, r3_337 = getPerformanceStats("Lua memory", "", "tactics")
    local r5_337 = r1_337[1][3]
    local r6_337 = r3_337[1][3]
    guiSetText(config_performance_usecpu, "CPU: " .. r1_337[1][2])
    guiSetText(config_performance_usetiming, "Timing: " .. r5_337)
    guiSetText(config_performance_usememory, "Memory: " .. r6_337)
  end
  function onClientGUIClick(r0_338, r1_338, r2_338, r3_338)
    -- line: [364, 558] id: 338
    if r0_338 ~= "left" then
      return 
    end
    if source == config_pagelist then
      local r4_338 = false
      local r5_338 = guiGridListGetSelectedItem(config_pagelist)
      if r5_338 >= 0 then
        r4_338 = guiGridListGetItemText(config_pagelist, r5_338, 1)
      end
      for r9_338, r10_338 in pairs(config_scrollers) do
        if r4_338 == r9_338 then
          guiSetVisible(r10_338, true)
          if r4_338 == "Performance" and not isTimer(updPerformance) then
            updPerformance = setTimer(checkPerformance, 500, 0)
          end
        else
          guiSetVisible(r10_338, false)
        end
      end
    end
    if source == config_close then
      guiSetVisible(config_window, false)
      if isAllGuiHidden() then
        showCursor(false)
      end
    end
    if source == config_performance_fps then
      local r4_338 = xmlFindChild(_client, "performance", 0)
      if guiCheckBoxGetSelected(config_performance_fps) then
        xmlNodeSetAttribute(r4_338, "fpsgraphic", "true")
        addEventHandler("onClientRender", root, onClientFPSDiagramRender)
        guiSetVisible(hud_fps, true)
      else
        xmlNodeSetAttribute(r4_338, "fpsgraphic", "false")
        removeEventHandler("onClientRender", root, onClientFPSDiagramRender)
        guiSetVisible(hud_fps, false)
      end
      xmlSaveFile(_client)
    end
    if source == config_performance_ploss then
      local r4_338 = xmlFindChild(_client, "performance", 0)
      if guiCheckBoxGetSelected(config_performance_ploss) then
        xmlNodeSetAttribute(r4_338, "plossgraphic", "true")
        addEventHandler("onClientRender", root, onClientPLossDiagramRender)
        guiSetVisible(hud_ploss, true)
      else
        xmlNodeSetAttribute(r4_338, "plossgraphic", "false")
        removeEventHandler("onClientRender", root, onClientPLossDiagramRender)
        guiSetVisible(hud_ploss, false)
      end
      xmlSaveFile(_client)
    end
    if source == config_performance_spec then
      local r4_338 = xmlFindChild(_client, "performance", 0)
      if guiCheckBoxGetSelected(config_performance_spec) then
        xmlNodeSetAttribute(r4_338, "speclist", "true")
        guiSetAlpha(speclist, 0.5)
      else
        xmlNodeSetAttribute(r4_338, "speclist", "false")
        guiSetAlpha(speclist, 0)
      end
      xmlSaveFile(_client)
    end
    if source == config_performance_roundhud then
      local r4_338 = xmlFindChild(_client, "performance", 0)
      if guiCheckBoxGetSelected(config_performance_roundhud) then
        xmlNodeSetAttribute(r4_338, "roundhud", "true")
        for r8_338, r9_338 in pairs(components) do
          guiSetAlpha(r9_338.root, 1)
        end
      else
        xmlNodeSetAttribute(r4_338, "roundhud", "false")
        for r8_338, r9_338 in pairs(components) do
          guiSetAlpha(r9_338.root, 0)
        end
      end
      xmlSaveFile(_client)
    end
    if source == config_performance_helpinfo then
      local r4_338 = xmlFindChild(_client, "performance", 0)
      if guiCheckBoxGetSelected(config_performance_helpinfo) then
        xmlNodeSetAttribute(r4_338, "helpinfo", "true")
        guiSetAlpha(infowindow, 1)
      else
        xmlNodeSetAttribute(r4_338, "helpinfo", "false")
        guiSetAlpha(infowindow, 0)
      end
      xmlSaveFile(_client)
    end
    if source == config_performance_valueshud then
      local r4_338 = xmlFindChild(_client, "performance", 0)
      if guiCheckBoxGetSelected(config_performance_valueshud) then
        xmlNodeSetAttribute(r4_338, "valueshud", "true")
        guiSetAlpha(values_hud, 1)
        addEventHandler("onClientElementDataChange", localPlayer, onClientValuesHUDElementDataChange)
        if getElementData(localPlayer, "Status") == "Play" then
          addEventHandler("onClientRender", root, onClientValuesHUDRender)
        end
      else
        xmlNodeSetAttribute(r4_338, "valueshud", "false")
        guiSetAlpha(values_hud, 0)
        removeEventHandler("onClientElementDataChange", localPlayer, onClientValuesHUDElementDataChange)
        if getElementData(localPlayer, "Status") == "Play" then
          removeEventHandler("onClientRender", root, onClientValuesHUDRender)
        end
      end
      xmlSaveFile(_client)
    end
    if source == config_performance_laser then
      local r4_338 = xmlFindChild(_client, "performance", 0)
      if guiCheckBoxGetSelected(config_performance_laser) then
        xmlNodeSetAttribute(r4_338, "laser", "true")
        if next(laseraimRender) then
          addEventHandler("onClientHUDRender", root, onClientLaseraimRender)
        end
      else
        xmlNodeSetAttribute(r4_338, "laser", "false")
        if next(laseraimRender) then
          removeEventHandler("onClientHUDRender", root, onClientLaseraimRender)
          for r8_338, r9_338 in pairs(laseraimRender) do
            setMarkerColor(r9_338, 0, 0, 0, 0)
          end
        end
      end
      xmlSaveFile(_client)
    end
    if source == config_audio_voice then
      local r4_338 = xmlFindChild(_client, "audio", 0)
      if guiCheckBoxGetSelected(config_audio_voice) then
        xmlNodeSetAttribute(r4_338, "voice", "true")
      else
        xmlNodeSetAttribute(r4_338, "voice", "false")
      end
      xmlSaveFile(_client)
    end
    if source == config_audio_music then
      local r4_338 = xmlFindChild(_client, "audio", 0)
      if guiCheckBoxGetSelected(config_audio_music) then
        xmlNodeSetAttribute(r4_338, "music", "true")
      else
        xmlNodeSetAttribute(r4_338, "music", "false")
      end
      xmlSaveFile(_client)
    end
    if source == config_performance_vehmanager then
      local r4_338 = xmlFindChild(_client, "performance", 0)
      if guiCheckBoxGetSelected(config_performance_vehmanager) then
        xmlNodeSetAttribute(r4_338, "vehmanager", "true")
        if not guiGetVisible(vehicle_window) then
          destroyElement(vehicle_window)
        end
      else
        xmlNodeSetAttribute(r4_338, "vehmanager", "false")
        if not isElement(vehicle_window) then
          guiSetVisible(createVehicleManager(), false)
        end
      end
      xmlSaveFile(_client)
    end
    if source == config_performance_weapmanager then
      local r4_338 = xmlFindChild(_client, "performance", 0)
      if guiCheckBoxGetSelected(config_performance_weapmanager) then
        xmlNodeSetAttribute(r4_338, "weapmanager", "true")
        if not guiGetVisible(weapon_window) then
          destroyElement(weapon_window)
        end
      else
        xmlNodeSetAttribute(r4_338, "weapmanager", "false")
        if not isElement(weapon_window) then
          guiSetVisible(createWeaponManager(), false)
        end
      end
      xmlSaveFile(_client)
    end
    if source == config_performance_adminpanel then
      local r4_338 = xmlFindChild(_client, "performance", 0)
      if guiCheckBoxGetSelected(config_performance_adminpanel) then
        xmlNodeSetAttribute(r4_338, "adminpanel", "true")
        if not guiGetVisible(admin_window) then
          destroyElement(admin_window)
        end
        if not guiGetVisible(restore_window) then
          destroyElement(restore_window)
        end
        if not guiGetVisible(redirect_window) then
          destroyElement(redirect_window)
        end
        if not guiGetVisible(save_window) then
          destroyElement(save_window)
        end
        if not guiGetVisible(add_window) then
          destroyElement(add_window)
        end
        if not guiGetVisible(rules_window) then
          destroyElement(rules_window)
        end
        if not guiGetVisible(palette_window) then
          destroyElement(palette_window)
        end
        if not guiGetVisible(rename_window) then
          destroyElement(rename_window)
        end
        if not guiGetVisible(screen_window) then
          destroyElement(screen_window)
        end
        if not guiGetVisible(mods_window) then
          destroyElement(mods_window)
        end
      else
        xmlNodeSetAttribute(r4_338, "adminpanel", "false")
        if not isElement(admin_window) then
          guiSetVisible(createAdminPanel(), false)
        end
        if not isElement(restore_window) then
          guiSetVisible(createAdminRestore(), false)
        end
        if not isElement(redirect_window) then
          guiSetVisible(createAdminRedirect(), false)
        end
        if not isElement(save_window) then
          guiSetVisible(createAdminSaveConfig(), false)
        end
        if not isElement(add_window) then
          guiSetVisible(createAdminAddConfig(), false)
        end
        if not isElement(rules_window) then
          guiSetVisible(createAdminRules(), false)
        end
        if not isElement(palette_window) then
          guiSetVisible(createAdminPalette(), false)
        end
        if not isElement(rename_window) then
          guiSetVisible(createAdminRenameConfig(), false)
        end
        if not isElement(screen_window) then
          guiSetVisible(createAdminScreen(), false)
        end
        if not isElement(mods_window) then
          guiSetVisible(createAdminMods(), false)
        end
      end
      xmlSaveFile(_client)
    end
  end
  function onClientGUIScroll(r0_339)
    -- line: [559, 610] id: 339
    if source == config_audio_voicevol then
      local r1_339 = guiScrollBarGetScrollPosition(config_audio_voicevol)
      guiSetText(config_audio_voicelab, r1_339 .. "%")
      for r5_339, r6_339 in pairs(voiceThread) do
        if r6_339 then
          setSoundVolume(r6_339, 0.01 * r1_339)
        end
      end
      if isTimer(voiceScroll) then
        resetTimer(voiceScroll)
      else
        voiceScroll = setTimer(function()
          -- line: [569, 582] id: 340
          local r0_340 = xmlFindChild(_client, "audio", 0)
          local r1_340 = guiScrollBarGetScrollPosition(config_audio_voicevol)
          xmlNodeSetAttribute(r0_340, "voicevol", tostring(r1_340))
          if r1_340 == 0 and xmlNodeGetAttribute(r0_340, "voice") == "true" then
            xmlNodeSetAttribute(r0_340, "voice", "false")
            guiCheckBoxSetSelected(config_audio_voice, false)
          end
          if 0 < r1_340 and xmlNodeGetAttribute(r0_340, "voice") == "false" then
            xmlNodeSetAttribute(r0_340, "voice", "true")
            guiCheckBoxSetSelected(config_audio_voice, true)
          end
          xmlSaveFile(_client)
        end, 500, 1)
      end
    end
    if source == config_audio_musicvol then
      local r1_339 = guiScrollBarGetScrollPosition(config_audio_musicvol)
      guiSetText(config_audio_musiclab, r1_339 .. "%")
      for r5_339, r6_339 in pairs(musicThread) do
        if r6_339 then
          setSoundVolume(r6_339, 0.01 * r1_339)
        end
      end
      if isTimer(musicScroll) then
        resetTimer(musicScroll)
      else
        musicScroll = setTimer(function()
          -- line: [594, 607] id: 341
          local r0_341 = xmlFindChild(_client, "audio", 0)
          local r1_341 = guiScrollBarGetScrollPosition(config_audio_musicvol)
          xmlNodeSetAttribute(r0_341, "musicvol", tostring(r1_341))
          if r1_341 == 0 and xmlNodeGetAttribute(r0_341, "music") == "true" then
            xmlNodeSetAttribute(r0_341, "music", "false")
            guiCheckBoxSetSelected(config_audio_music, false)
          end
          if 0 < r1_341 and xmlNodeGetAttribute(r0_341, "music") == "false" then
            xmlNodeSetAttribute(r0_341, "music", "true")
            guiCheckBoxSetSelected(config_audio_music, true)
          end
          xmlSaveFile(_client)
        end, 500, 1)
      end
    end
  end
  function onClientGUIBlur()
    -- line: [611, 624] id: 342
    if source == config_audio_voicevol then
      xmlNodeSetAttribute(xmlFindChild(_client, "audio", 0), "voicevol", tostring(guiScrollBarGetScrollPosition(config_audio_voicevol)))
      xmlSaveFile(_client)
    end
    if source == config_audio_musicvol then
      xmlNodeSetAttribute(xmlFindChild(_client, "audio", 0), "musicvol", tostring(guiScrollBarGetScrollPosition(config_audio_musicvol)))
      xmlSaveFile(_client)
    end
  end
  function onClientGUIComboBoxAccepted(r0_343)
    -- line: [625, 650] id: 343
    if source == config_gameplay_language then
      local r1_343 = config_gameplay_languagelist[guiGetText(config_gameplay_language)]
      loadedLanguage = {}
      local r2_343 = xmlLoadFile(r1_343)
      if r2_343 then
        local r3_343 = xmlNodeGetAttribute(r2_343, "name") or ""
        outputChatBox(r3_343 .. " (" .. (xmlNodeGetAttribute(r2_343, "author") or "") .. ")", 255, 100, 100, true)
        for r8_343, r9_343 in ipairs(xmlNodeGetChildren(r2_343)) do
          loadedLanguage[xmlNodeGetName(r9_343)] = xmlNodeGetAttribute(r9_343, "string")
        end
        xmlUnloadFile(r2_343)
        xmlNodeSetAttribute(xmlFindChild(_client, "gameplay", 0), "language", r1_343)
        xmlSaveFile(_client)
        triggerEvent("onClientLanguageChange", localPlayer, r1_343)
      end
    end
    if source == config_gameplay_nitrocontrol then
      xmlNodeSetAttribute(xmlFindChild(_client, "gameplay", 0), "nitrocontrol", ({
        Toggle = "toggle",
        Hold = "hold",
      })[guiGetText(config_gameplay_nitrocontrol)])
      xmlSaveFile(_client)
    end
  end
  function togglePlayerConfig(r0_344, r1_344)
    -- line: [651, 671] id: 344
    if guiGetInputEnabled() then
      return 
    end
    if guiGetVisible(config_window) then
      guiSetVisible(config_window, false)
      if isAllGuiHidden() then
        showCursor(false)
      end
    else
      if r1_344 then
        for r5_344 = 0, guiGridListGetRowCount(config_pagelist), 1 do
          if guiGridListGetItemText(config_pagelist, r5_344, 1) == r1_344 then
            guiGridListSetSelectedItem(config_pagelist, r5_344, 1)
            triggerEvent("onClientGUIClick", config_pagelist, "left", "up")
            break
          end
        end
      end
      guiBringToFront(config_window)
      guiSetVisible(config_window, true)
      showCursor(true)
      if not isTimer(updPerformance) then
        updPerformance = setTimer(checkPerformance, 500, 0)
      end
    end
  end
  function onClientValuesHUDRender()
    -- line: [672, 689] id: 345
    local r0_345 = tostring(math.ceil(getElementHealth(localPlayer)))
    if guiGetText(hud_health) ~= r0_345 then
      guiSetText(hud_health, r0_345)
    end
    local r1_345 = getPedArmor(localPlayer)
    if r1_345 > 0 then
      if not guiGetVisible(hud_armor) then
        guiSetVisible(hud_armor, true)
      end
      r1_345 = tostring(math.ceil(r1_345))
      if guiGetText(hud_armor) ~= r1_345 then
        guiSetText(hud_armor, r1_345)
      end
    elseif guiGetVisible(hud_armor) then
      guiSetVisible(hud_armor, false)
    end
  end
  function onClientValuesHUDElementDataChange(r0_346, r1_346)
    -- line: [690, 699] id: 346
    if r0_346 ~= "Status" then
      return 
    end
    if r1_346 == "Play" then
      removeEventHandler("onClientRender", root, onClientValuesHUDRender)
      guiSetVisible(values_hud, false)
    elseif getElementData(source, r0_346) == "Play" then
      addEventHandler("onClientRender", root, onClientValuesHUDRender)
      guiSetVisible(values_hud, true)
    end
  end
  function onDownloadComplete()
    -- line: [700, 707] id: 347
    local r0_347 = guiSetAlpha
    local r1_347 = infowindow
    local r2_347 = guiCheckBoxGetSelected(config_performance_helpinfo)
    if r2_347 then
      r2_347 = 1 or 0
    else
      goto label_10	-- block#2 is visited secondly
    end
    r0_347(r1_347, r2_347)
    r0_347 = guiSetAlpha
    r1_347 = speclist
    r2_347 = guiCheckBoxGetSelected(config_performance_spec)
    if r2_347 then
      r2_347 = 0.5 or 0
    else
      goto label_22	-- block#5 is visited secondly
    end
    r0_347(r1_347, r2_347)
    for r3_347, r4_347 in pairs(components) do
      local r5_347 = guiSetAlpha
      local r6_347 = r4_347.root
      local r7_347 = guiCheckBoxGetSelected(config_performance_roundhud)
      if r7_347 then
        r7_347 = 1 or 0
      else
        goto label_38	-- block#9 is visited secondly
      end
      r5_347(r6_347, r7_347)
    end
    r0_347 = guiSetAlpha
    r1_347 = values_hud
    r2_347 = guiCheckBoxGetSelected(config_performance_valueshud)
    if r2_347 then
      r2_347 = 1 or 0
    else
      goto label_52	-- block#14 is visited secondly
    end
    r0_347(r1_347, r2_347)
  end
  function onClientElementDataChange(r0_348, r1_348)
    -- line: [708, 736] id: 348
    if r0_348 == "FPS" then
      table.insert(fpsdata, 1, {
        getElementData(localPlayer, "FPS"),
        getTickCount()
      })
    end
    if r0_348 == "PLoss" then
      table.insert(plossdata, 1, {
        getElementData(localPlayer, "PLoss"),
        getTickCount()
      })
    end
    if r0_348 == "Status" then
      if r1_348 == "Joining" then
        if guiCheckBoxGetSelected(config_performance_fps) then
          addEventHandler("onClientRender", root, onClientFPSDiagramRender)
          guiSetVisible(hud_fps, true)
        end
        if guiCheckBoxGetSelected(config_performance_ploss) then
          addEventHandler("onClientRender", root, onClientPLossDiagramRender)
          guiSetVisible(hud_ploss, true)
        end
      elseif getElementData(localPlayer, "Status") == "Joining" then
        if guiCheckBoxGetSelected(config_performance_fps) then
          removeEventHandler("onClientRender", root, onClientFPSDiagramRender)
          guiSetVisible(hud_fps, false)
        end
        if guiCheckBoxGetSelected(config_performance_ploss) then
          removeEventHandler("onClientRender", root, onClientPLossDiagramRender)
          guiSetVisible(hud_ploss, false)
        end
      end
    end
  end
  addEventHandler("onClientResourceStart", resourceRoot, onClientResourceStart)
  addEventHandler("onClientTacticsChange", root, onClientTacticsChange)
  addEventHandler("onClientGUIClick", root, onClientGUIClick)
  addEventHandler("onClientGUIScroll", root, onClientGUIScroll)
  addEventHandler("onClientGUIBlur", root, onClientGUIBlur)
  addEventHandler("onClientGUIComboBoxAccepted", root, onClientGUIComboBoxAccepted)
  addEventHandler("onClientRender", root, onClientFPSCount)
  addEventHandler("onDownloadComplete", root, onDownloadComplete)
  addEventHandler("onClientElementDataChange", localPlayer, onClientElementDataChange)
  setTimer(updateLimites, 1000, 0)
  addCommandHandler("player_config", togglePlayerConfig, false)
end)()
(function(...)
  -- line: [0, 0] id: 349
  local r0_349 = {
    {
      "Damage",
      1
    },
    {
      "Kills",
      1
    },
    {
      "Deaths",
      -1
    }
  }
  local r1_349 = nil
  local r2_349 = nil
  function onClientResourceStart(r0_350)
    -- line: [9, 72] id: 350
    statistic_window = guiCreateWindow(xscreen * 0.5 - 320, yscreen * 0.5 - 240, 640, 480, "Round statistic", false)
    guiWindowSetSizable(statistic_window, false)
    guiSetVisible(statistic_window, false)
    roundScores = guiCreateLabel(10, 25, 620, 35, "", false, statistic_window)
    guiSetFont(roundScores, fontTactics)
    guiLabelSetHorizontalAlign(roundScores, "center")
    guiSetEnabled(roundScores, false)
    leftImage = guiCreateStaticImage(10, 25, 55, 55, "images/color_pixel.png", false, statistic_window)
    guiSetVisible(leftImage, false)
    guiSetEnabled(leftImage, false)
    rightImage = guiCreateStaticImage(575, 25, 55, 55, "images/color_pixel.png", false, statistic_window)
    guiSetVisible(rightImage, false)
    guiSetEnabled(rightImage, false)
    leftTeam = guiCreateLabel(10, 25, 310, 35, "", false, statistic_window)
    guiSetFont(leftTeam, fontTactics)
    guiSetEnabled(leftTeam, false)
    rightTeam = guiCreateLabel(320, 25, 310, 35, "", false, statistic_window)
    guiSetFont(rightTeam, fontTactics)
    guiLabelSetHorizontalAlign(rightTeam, "right")
    guiSetEnabled(rightTeam, false)
    leftSide = guiCreateLabel(10, 60, 300, 20, "", false, statistic_window)
    guiLabelSetHorizontalAlign(leftSide, "right")
    guiSetEnabled(leftSide, false)
    rightSide = guiCreateLabel(330, 60, 300, 20, "", false, statistic_window)
    guiSetEnabled(rightSide, false)
    statistic_players = guiCreateGridList(5, 80, 630, 365, false, statistic_window)
    guiGridListSetSortingEnabled(statistic_players, false)
    guiGridListAddColumn(statistic_players, "Name", 0.3)
    statistic_log = guiCreateMemo(5, 80, 630, 365, "", false, statistic_window)
    guiMemoSetReadOnly(statistic_log, true)
    guiSetVisible(statistic_log, false)
    local r1_350 = 30 + dxGetTextWidth("Players", 1, "default-bold")
    statistic_tabplayersbg = guiCreateStaticImage(15, 445, r1_350, 32, "images/color_pixel.png", false, statistic_window)
    guiSetProperty(statistic_tabplayersbg, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    statistic_tabplayers = guiCreateButton(0, -8, r1_350, 32, "Players", false, statistic_tabplayersbg)
    guiSetFont(statistic_tabplayers, "default-bold-small")
    guiSetProperty(statistic_tabplayers, "NormalTextColour", "FFFFFFFF")
    local r2_350 = 30 + dxGetTextWidth("Log", 1, "default-bold")
    statistic_tablogbg = guiCreateStaticImage(14 + r1_350, 445, r2_350, 32, "images/color_pixel.png", false, statistic_window)
    guiSetProperty(statistic_tablogbg, "ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
    statistic_tablog = guiCreateButton(0, -8, r2_350, 32, "Log", false, statistic_tablogbg)
    guiSetFont(statistic_tablog, "default-bold-small")
    statistic_copy = guiCreateButton(390, 450, 170, 25, "Copy to clipboard", false, statistic_window)
    guiSetFont(statistic_copy, "default-bold-small")
    statistic_close = guiCreateButton(565, 450, 120, 25, "Close", false, statistic_window)
    guiSetFont(statistic_close, "default-bold-small")
  end
  function updateRoundStatistic(r0_351, r1_351, r2_351, r3_351)
    -- line: [73, 154] id: 351
    if not r0_349 or #r0_349 == 0 then
      return 
    end
    if #r1_351 > 2 then
      table.sort(r1_351, function(r0_352, r1_352)
        -- line: [76, 76] id: 352
        return r1_352.score < r0_352.score
      end)
    end
    guiSetText(statistic_window, "Round statistic - " .. r0_351)
    guiSetPosition(statistic_players, 5, 80, false)
    guiSetSize(statistic_players, 630, 365, false)
    guiSetText(roundScores, " : ")
    for r7_351 = 1, math.min(#r1_351, 2), 1 do
      local r8_351 = r1_351[r7_351]
      if r7_351 == 1 then
        if r8_351.image then
          r1_349 = fileCreate("images/_leftimagefile.jpg")
        end
        if r8_351.image and r1_349 then
          fileWrite(r1_349, r8_351.image)
          fileClose(r1_349)
          guiStaticImageLoadImage(leftImage, "images/_leftimagefile.jpg")
          guiSetVisible(leftImage, true)
          guiSetVisible(leftTeam, false)
        else
          guiSetText(leftTeam, r8_351.name)
          guiSetVisible(leftImage, false)
          guiSetVisible(leftTeam, true)
        end
        guiLabelSetColor(leftTeam, r8_351.r, r8_351.g, r8_351.b)
        guiSetText(leftSide, r8_351.side)
        guiSetText(roundScores, r8_351.score .. guiGetText(roundScores))
      else
        if r8_351.image then
          r2_349 = fileCreate("images/_rightimagefile.jpg")
        end
        if r8_351.image and r2_349 then
          fileWrite(r2_349, r8_351.image)
          fileClose(r2_349)
          guiStaticImageLoadImage(rightImage, "images/_rightimagefile.jpg")
          guiSetVisible(rightImage, true)
          guiSetVisible(rightTeam, false)
        else
          guiSetText(rightTeam, r8_351.name)
          guiSetVisible(rightImage, false)
          guiSetVisible(rightTeam, true)
        end
        guiLabelSetColor(rightTeam, r8_351.r, r8_351.g, r8_351.b)
        guiSetText(rightSide, r8_351.side)
        guiSetText(roundScores, guiGetText(roundScores) .. r8_351.score)
      end
    end
    guiGridListClear(statistic_players)
    for r7_351 = 2, guiGridListGetColumnCount(statistic_players), 1 do
      guiGridListRemoveColumn(statistic_players, 2)
    end
    for r7_351, r8_351 in ipairs(r0_349) do
      guiGridListAddColumn(statistic_players, r8_351[1], 0.65 / #r0_349)
    end
    for r7_351, r8_351 in ipairs(r1_351) do
      local r9_351 = guiGridListAddRow(statistic_players)
      guiGridListSetItemText(statistic_players, r9_351, 1, r8_351.name .. " - " .. r8_351.score, true, false)
      guiGridListSetItemColor(statistic_players, r9_351, 1, r8_351.r, r8_351.g, r8_351.b)
      for r13_351, r14_351 in ipairs(r0_349) do
        if r8_351[r14_351] then
          guiGridListSetItemColor(statistic_players, r9_351, r13_351 + 1, tostring(r8_351[r14_351]), true, false)
        end
      end
      table.sort(r8_351.players, function(r0_353, r1_353)
        -- line: [132, 141] id: 353
        for r5_353, r6_353 in ipairs(r0_349) do
          if tonumber(r1_353[r6_353[1]]) < tonumber(r0_353[r6_353[1]]) then
            return 0 < r6_353[2]
          elseif tonumber(r0_353[r6_353[1]]) < tonumber(r1_353[r6_353[1]]) then
            return r6_353[2] < 0
          end
        end
        return false
      end)
      for r13_351, r14_351 in ipairs(r8_351.players) do
        r9_351 = guiGridListAddRow(statistic_players)
        guiGridListSetItemText(statistic_players, r9_351, 1, r14_351.name, false, false)
        guiGridListSetItemColor(statistic_players, r9_351, 1, r8_351.r, r8_351.g, r8_351.b)
        for r18_351, r19_351 in ipairs(r0_349) do
          local r20_351 = guiGridListSetItemText
          local r21_351 = statistic_players
          local r22_351 = r9_351
          local r23_351 = r18_351 + 1
          local r24_351 = r14_351[r19_351[1]]
          if r24_351 then
            r24_351 = tostring(r14_351[r19_351[1]]) or ""
          else
            goto label_297	-- block#37 is visited secondly
          end
          r20_351(r21_351, r22_351, r23_351, r24_351, false, false)
        end
      end
    end
    guiSetText(statistic_log, r2_351 or "")
    if r3_351 then
      return 
    end
    outputInfo(string.format(getLanguageString("help_roundlog"), string.upper(next(getBoundKeys("round_stat")))))
  end
  function toggleRoundStatistic()
    -- line: [155, 163] id: 354
    if not guiGetVisible(statistic_window) then
      guiSetVisible(statistic_window, true)
      showCursor(true)
    else
      guiSetVisible(statistic_window, false)
      if isAllGuiHidden() then
        showCursor(false)
      end
    end
  end
  function onClientGUIClick(r0_355, r1_355, r2_355, r3_355)
    -- line: [164, 211] id: 355
    if r0_355 ~= "left" then
      return 
    end
    if source == statistic_close then
      guiSetVisible(statistic_window, false)
      if isAllGuiHidden() then
        showCursor(false)
      end
    end
    if source == statistic_copy then
      local r4_355 = 4
      local r5_355 = guiGetText(statistic_window) .. "\n\n"
      for r9_355, r10_355 in ipairs(r0_349) do
        r4_355 = math.max(r4_355, #tostring(r10_355[1]))
      end
      for r9_355 = 0, guiGridListGetRowCount(statistic_players), 1 do
        for r13_355 = 1, #r0_349 + 1, 1 do
          r4_355 = math.max(r4_355, #tostring(guiGridListGetItemText(statistic_players, r9_355, r13_355)))
        end
      end
      r4_355 = r4_355 + 3
      r5_355 = r5_355 .. "Name" .. string.rep(" ", r4_355 - 4)
      for r9_355, r10_355 in ipairs(r0_349) do
        local r11_355 = r10_355[1]
        r5_355 = r5_355 .. r11_355 .. string.rep(" ", r4_355 - #r11_355)
      end
      r5_355 = r5_355 .. "\n"
      for r9_355 = 0, guiGridListGetRowCount(statistic_players), 1 do
        for r13_355 = 1, #r0_349 + 1, 1 do
          local r14_355 = guiGridListGetItemText(statistic_players, r9_355, r13_355)
          r5_355 = r5_355 .. r14_355 .. string.rep(" ", r4_355 - #r14_355)
        end
        r5_355 = r5_355 .. "\n"
      end
      setClipboard(r5_355 .. "\n" .. guiGetText(statistic_log))
    end
    if source == statistic_tabplayers then
      guiSetVisible(statistic_players, true)
      guiSetVisible(statistic_log, false)
      guiSetProperty(statistic_tabplayers, "NormalTextColour", "FFFFFFFF")
      guiSetProperty(statistic_tablog, "NormalTextColour", "FF7C7C7C")
    end
    if source == statistic_tablog then
      guiSetVisible(statistic_players, false)
      guiSetVisible(statistic_log, true)
      guiSetProperty(statistic_tabplayers, "NormalTextColour", "FF7C7C7C")
      guiSetProperty(statistic_tablog, "NormalTextColour", "FFFFFFFF")
    end
  end
  function onClientStatisticChange(...)
    -- line: [212, 221] id: 356
    r0_349 = {}
    for r4_356, r5_356 in ipairs({
      ...
    }) do
      if type(r5_356) == "string" then
        table.insert(r0_349, {
          tostring(r5_356)
        })
      elseif #r0_349 > 0 then
        r0_349[#r0_349][2] = r5_356
      end
    end
  end
  addEvent("onClientStatisticChange", true)
  addEventHandler("onClientResourceStart", resourceRoot, onClientResourceStart)
  addEventHandler("onClientGUIClick", root, onClientGUIClick)
  addEventHandler("onClientStatisticChange", root, onClientStatisticChange)
  addCommandHandler("round_stat", toggleRoundStatistic, false)
  bindKey("F5", "down", "round_stat")
end)()
