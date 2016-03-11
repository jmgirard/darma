function fig_configure
%FIG_CONFIGURE Window for the configuration of settings
%   License: https://darma.codeplex.com/license

    global settings;
    % Create and maximize annotation window
    defaultBackground = get(0,'defaultUicontrolBackgroundColor');
    handles.figure_configure = figure( ...
        'Name','DARMA: Configure', ...
        'Units','pixels', ...
        'Position',[0 0 960 540], ...
        'NumberTitle','off', ...
        'MenuBar','none', ...
        'ToolBar','none', ...
        'Visible','off', ...
        'Resize','off', ...
        'Color',defaultBackground);
    movegui(handles.figure_configure,'center');
    %Buttons
    handles.push_submit = uicontrol( ...
        'Parent',handles.figure_configure, ...
        'Units','normalized', ...
        'Position',[.6 .025 .3 .075], ...
        'String','Apply Current Settings', ...
        'FontWeight','bold', ...
        'FontSize',12, ...
        'Callback',@push_submit_Callback);
    handles.push_default = uicontrol(...
        'Parent',handles.figure_configure, ...
        'Units','normalized', ...
        'Position',[.1 .025 .3 .075], ...
        'String','Save as Default Settings', ...
        'FontSize',12, ...
        'Callback',@push_default_Callback);
    %Left Panel
    panel_left = uipanel(...
        'Parent',handles.figure_configure, ...
        'Units','normalized', ...
        'Position',[.01 .125 .48 .875], ...
        'Title','Settings', ...
        'FontSize',12);
    % % Folders Subpanel
    panel_fol = uipanel( ...
        'Parent',panel_left, ...
        'Position',[.01 .67 .98 .32], ...
        'Title','Default Folder', ...
        'FontSize',12);
    uicontrol(panel_fol, ...
        'Style','text', ...
        'Units','normalized', ...
        'Position',[.1 .5 .8 .4], ...
        'FontSize',12, ...
        'String','Determines the first folder displayed during imports and exports. Click the button to browse.');
    handles.edit_folder = uicontrol('Style','edit', ...
        'Parent',panel_fol, ...
        'Units','normalized', ...
        'Position',[.1 .2 .7 .3], ...
        'FontSize',12, ...
        'String',settings.folder);
    handles.push_folder = uicontrol('Style','pushbutton', ...
        'Parent',panel_fol, ...
        'Units','normalized', ...
        'Position',[.8 .2 .1 .3], ...
        'String','...', ...
        'FontSize',12, ...
        'Callback',@push_folder_Callback);
    % % Sampling Subpanel
    panel_bin = uipanel( ...
        'Parent',panel_left, ...
        'Position',[.01 .34 .98 .33], ...
        'Title','Bin Size', ...
        'FontSize',12);
    handles.bgroup_bin = uibuttongroup(panel_bin, ...
        'Units','normalized', ...
        'Position',[.1 0 .8 .5], ...
        'BorderType','none', ...
        'Visible','off');
    uicontrol(panel_bin, ...
        'Style','text', ...
        'Units','normalized', ...
        'Position',[.10 .33 .80 .57], ...
        'FontSize',12, ...
        'String','Determines the size (in seconds) of each bin. For instance, setting the bin size to 0.50 sec will produce two ratings per second.');
    handles.bin_400 = uicontrol(handles.bgroup_bin, ...
        'Style','radiobutton', ...
        'Units','normalized', ...
        'Position',[.02 0 1/5 1], ...
        'String','4.00', ...
        'FontSize',12, ...
        'HandleVisibility','off');
    handles.bin_200 = uicontrol(handles.bgroup_bin, ...
        'Style','radiobutton', ...
        'Units','normalized', ...
        'Position',[.02+1/5 0 1/5 1], ...
        'String','2.00', ...
        'FontSize',12, ...
        'HandleVisibility','off');
    handles.bin_100 = uicontrol(handles.bgroup_bin, ...
        'Style','radiobutton', ...
        'Units','normalized', ...
        'Position',[.02+2/5 0 1/5 1], ...
        'String','1.00', ...
        'FontSize',12, ...
        'HandleVisibility','off');
    handles.bin_050 = uicontrol(handles.bgroup_bin, ...
        'Style','radiobutton', ...
        'Units','normalized', ...
        'Position',[.02+3/5 0 1/5 1], ...
        'String','0.50', ...
        'FontSize',12, ...
        'HandleVisibility','off');
    handles.bin_025 = uicontrol(handles.bgroup_bin, ...
        'Style','radiobutton', ...
        'Units','normalized', ...
        'Position',[.02+4/5 0 1/5 1], ...
        'String','0.25', ...
        'FontSize',12, ...
        'HandleVisibility','off');
    set(handles.bgroup_bin,'Visible','on');
    % % Magnitude Subpanel
    panel_mag = uipanel( ...
        'Parent',panel_left, ...
        'Position',[.01 .01 .98 .33], ...
        'Title','Axis Magnitude', ...
        'FontSize',12);
    handles.bgroup_mag = uibuttongroup(panel_mag, ...
        'Units','normalized', ...
        'Position',[.1 0 .8 .5], ...
        'BorderType','none', ...
        'Visible','off');
    uicontrol(panel_mag, ...
        'Style','text', ...
        'Units','normalized', ...
        'Position',[.10 .33 .80 .57], ...
        'FontSize',12, ...
        'String','Determines the bipolar scaling of output values. For instance, setting the magnitude to 100 will produce values ranging from -100 to 100.');
    handles.mag_1 = uicontrol(handles.bgroup_mag, ...
        'Style','radiobutton', ...
        'Units','normalized', ...
        'Position',[.02 0 1/4 1], ...
        'String','1', ...
        'FontSize',12, ...
        'HandleVisibility','off');
    handles.mag_10 = uicontrol(handles.bgroup_mag, ...
        'Style','radiobutton', ...
        'Units','normalized', ...
        'Position',[.02+1/4 0 1/4 1], ...
        'String','10', ...
        'FontSize',12, ...
        'HandleVisibility','off');
    handles.mag_100 = uicontrol(handles.bgroup_mag, ...
        'Style','radiobutton', ...
        'Units','normalized', ...
        'Position',[.02+2/4 0 1/4 1], ...
        'String','100', ...
        'FontSize',12, ...
        'HandleVisibility','off');
    handles.mag_1000 = uicontrol(handles.bgroup_mag, ...
        'Style','radiobutton', ...
        'Units','normalized', ...
        'Position',[.02+3/4 0 1/4 1], ...
        'String','1000', ...
        'FontSize',12, ...
        'HandleVisibility','off');
    set(handles.bgroup_mag,'Visible','on');
    %Right Panel
    panel_right = uipanel(...
        'Parent',handles.figure_configure, ...
        'Units','normalized', ...
        'Position',[.5 .125 .49 .875], ...
        'Title','Axis Labels', ...
        'FontSize',12);
    handles.push_interpersonal = uicontrol( ...
        'Style','pushbutton', ...
        'Parent',panel_right, ...
        'Units','normalized', ...
        'Position',[.10 .90 .25 .075], ...
        'String','Interpersonal', ...
        'FontSize',12, ...
        'Callback',@push_interpersonal_Callback);
    handles.push_affective = uicontrol( ...
        'Style','pushbutton', ...
        'Parent',panel_right, ...
        'Units','normalized', ...
        'Position',[.375 .90 .25 .075], ...
        'String','Affective', ...
        'FontSize',12, ...
        'Callback',@push_affective_Callback);
    handles.push_clear = uicontrol( ...
        'Style','pushbutton', ...
        'Parent',panel_right, ...
        'Units','normalized', ...
        'Position',[.65 .90 .25 .075], ...
        'String','Clear', ...
        'FontSize',12, ...
        'Callback',@push_clear_Callback);
    axes( ... 
        'Parent',panel_right, ...
        'Units','normalized', ...
        'Position',[.10 .25 .80 .60], ...
        'NextPlot','add', ...
        'XTick',[],'YTick',[],'Box','on');
    plot([-1,1],[0,0],'k');
    plot([0,0],[-1,1],'k');
    handles.edit_label1 = uicontrol( ...
        'Style','edit', ...
        'Parent',panel_right, ...
        'Units','normalized', ...
        'Position',[.35 .75 .3 .075], ...
        'String',settings.label1, ...
        'FontSize',12);
    handles.edit_label2 = uicontrol( ...
        'Style','edit', ...
        'Parent',panel_right, ...
        'Units','normalized', ...
        'Position',[.175 .65 .3 .075], ...
        'String',settings.label2, ...
        'FontSize',12);
    handles.edit_label3 = uicontrol( ...
        'Style','edit', ...
        'Parent',panel_right, ...
        'Units','normalized', ...
        'Position',[.525 .65 .3 .075], ...
        'String',settings.label3, ...
        'FontSize',12);
    handles.edit_label4 = uicontrol( ...
        'Style','edit', ...
        'Parent',panel_right, ...
        'Units','normalized', ...
        'Position',[.125 .515 .3 .075], ...
        'String',settings.label4, ...
        'FontSize',12);
    handles.edit_label5 = uicontrol( ...
        'Style','edit', ...
        'Parent',panel_right, ...
        'Units','normalized', ...
        'Position',[.575 .515 .3 .075], ...
        'String',settings.label5, ...
        'FontSize',12);
    handles.edit_label6 = uicontrol( ...
        'Style','edit', ...
        'Parent',panel_right, ...
        'Units','normalized', ...
        'Position',[.175 .45 .3 .075], ...
        'String',settings.label6, ...
        'FontSize',12);
    handles.edit_label7 = uicontrol( ...
        'Style','edit', ...
        'Parent',panel_right, ...
        'Units','normalized', ...
        'Position',[.525 .45 .3 .075], ...
        'String',settings.label7, ...
        'FontSize',12);
    handles.edit_label8 = uicontrol( ...
        'Style','edit', ...
        'Parent',panel_right, ...
        'Units','normalized', ...
        'Position',[.35 .275 .3 .075], ...
        'String',settings.label8, ...
        'FontSize',12);
    handles.edit_labelX = uicontrol( ...
        'Style','edit', ...
        'Parent',panel_right, ...
        'Units','normalized', ...
        'Position',[.25 .15 .65 .075], ...
        'String',settings.labelX, ...
        'FontSize',12);
    uicontrol( ...
        'Style','text', ...
        'Parent',panel_right, ...
        'Units','normalized', ...
        'Position',[.10 .135 .15 .075], ...
        'HorizontalAlignment','Left', ...
        'FontSize',12, ...
        'String','X-Axis');
    handles.edit_labelY = uicontrol( ...
        'Style','edit', ...
        'Parent',panel_right, ...
        'Units','normalized', ...
        'Position',[.25 .05 .65 .075], ...
        'String',settings.labelY, ...
        'FontSize',12);
    uicontrol('Style','text', ...
        'Parent',panel_right, ...
        'Units','normalized', ...
        'Position',[.10 .035 .15 .075], ...
        'HorizontalAlignment','Left', ...
        'FontSize',12, ...
        'String','Y-Axis');
    align([handles.edit_label8,handles.edit_label7,handles.edit_label5],'none','distribute');
    align([handles.edit_label5,handles.edit_label3,handles.edit_label1],'none','distribute');
    align([handles.edit_label8,handles.edit_label6,handles.edit_label4],'none','distribute');
    align([handles.edit_label4,handles.edit_label2,handles.edit_label1],'none','distribute');
    switch settings.bin
        case 4.00
            set(handles.bgroup_bin,'SelectedObject',handles.bin_400);
        case 2.00
            set(handles.bgroup_bin,'SelectedObject',handles.bin_200);
        case 1.00
            set(handles.bgroup_bin,'SelectedObject',handles.bin_100);
        case 0.50
            set(handles.bgroup_bin,'SelectedObject',handles.bin_050);
        case 0.25
            set(handles.bgroup_bin,'SelectedObject',handles.bin_025);
    end
    switch settings.mag
        case 1
            set(handles.bgroup_mag,'SelectedObject',handles.mag_1);
        case 10
            set(handles.bgroup_mag,'SelectedObject',handles.mag_10);
        case 100
            set(handles.bgroup_mag,'SelectedObject',handles.mag_100);
        case 1000
            set(handles.bgroup_mag,'SelectedObject',handles.mag_1000);
    end
    set(handles.figure_configure,'Visible','on');
    guidata(handles.figure_configure,handles);
end

% ===============================================================================

function push_folder_Callback(hObject,~)
    handles = guidata(hObject);
    fol = uigetdir('','Select a default folder:');
    if fol==0, fol = ''; end
    set(handles.edit_folder,'String',fol);
end

% ===============================================================================

function push_interpersonal_Callback(hObject,~)
    handles = guidata(hObject);
    set(handles.edit_labelX,'string','Communion');
    set(handles.edit_labelY,'string','Agency');
    set(handles.edit_label1,'string','Dominant');
    set(handles.edit_label2,'string','Disagreeable');
    set(handles.edit_label3,'string','Extraverted');
    set(handles.edit_label4,'string','Separate');
    set(handles.edit_label5,'string','Friendly');
    set(handles.edit_label6,'string','Introverted');
    set(handles.edit_label7,'string','Agreeable');
    set(handles.edit_label8,'string','Submissive');
    guidata(handles.figure_configure,handles);
end

% ===============================================================================

function push_affective_Callback(hObject,~)
    handles = guidata(hObject);
    set(handles.edit_labelX,'string','Valence');
    set(handles.edit_labelY,'string','Arousal');
    set(handles.edit_label1,'string','Activated');
    set(handles.edit_label2,'string','Stressed');
    set(handles.edit_label3,'string','Excited');
    set(handles.edit_label4,'string','Unpleasant');
    set(handles.edit_label5,'string','Pleasant');
    set(handles.edit_label6,'string','Depressed');
    set(handles.edit_label7,'string','Relaxed');
    set(handles.edit_label8,'string','Deactivated');
    guidata(handles.figure_configure,handles);
end

% ===============================================================================

function push_clear_Callback(hObject,~)
    handles = guidata(hObject);
    set(handles.edit_labelX,'string','');
    set(handles.edit_labelY,'string','');
    set(handles.edit_label1,'string','');
    set(handles.edit_label2,'string','');
    set(handles.edit_label3,'string','');
    set(handles.edit_label4,'string','');
    set(handles.edit_label5,'string','');
    set(handles.edit_label6,'string','');
    set(handles.edit_label7,'string','');
    set(handles.edit_label8,'string','');
    guidata(handles.figure_configure,handles);
end

% ===============================================================================

function push_default_Callback(hObject,~)
    handles = guidata(hObject);
    settings.mag = str2double(get(get(handles.bgroup_mag,'SelectedObject'),'string'));
    settings.bin = str2double(get(get(handles.bgroup_bin,'SelectedObject'),'string'));
    settings.folder = get(handles.edit_folder,'string');
    settings.labelX = get(handles.edit_labelX,'string');
    settings.labelY = get(handles.edit_labelY,'string');
    settings.label1 = get(handles.edit_label1,'string');
    settings.label2 = get(handles.edit_label2,'string');
    settings.label3 = get(handles.edit_label3,'string');
    settings.label4 = get(handles.edit_label4,'string');
    settings.label5 = get(handles.edit_label5,'string');
    settings.label6 = get(handles.edit_label6,'string');
    settings.label7 = get(handles.edit_label7,'string');
    settings.label8 = get(handles.edit_label8,'string');
    if isdeployed
        save(fullfile(ctfroot,'DARMA','default.mat'),'settings');
    else
        save('default.mat','settings');
    end
    msgbox('Saved the current settings as the default settings.\nNext time DARMA is opened, these settings will be used.');
end

% ===============================================================================

function push_submit_Callback(hObject,~)
    handles = guidata(hObject);
    global settings;
    settings.mag = str2double(get(get(handles.bgroup_mag,'SelectedObject'),'string'));
    settings.bin = str2double(get(get(handles.bgroup_bin,'SelectedObject'),'string'));
    settings.folder = get(handles.edit_folder,'string');
    settings.labelX = get(handles.edit_labelX,'string');
    settings.labelY = get(handles.edit_labelY,'string');
    settings.label1 = get(handles.edit_label1,'string');
    settings.label2 = get(handles.edit_label2,'string');
    settings.label3 = get(handles.edit_label3,'string');
    settings.label4 = get(handles.edit_label4,'string');
    settings.label5 = get(handles.edit_label5,'string');
    settings.label6 = get(handles.edit_label6,'string');
    settings.label7 = get(handles.edit_label7,'string');
    settings.label8 = get(handles.edit_label8,'string');
    delete(gcf);
    return;
end