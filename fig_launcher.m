function fig_launcher
%FIG_LAUNCHER Window to launch the other windows
% License: https://darma.codeplex.com/license

    % Create and center main window
    defaultBackground = get(0,'defaultUicontrolBackgroundColor');
    handles.figure_launcher = figure( ...
        'Units','pixels', ...
        'Position',[0 0 600 350], ...
        'Name','DARMA: Dual Axis Rating and Media Annotation', ...
        'MenuBar','none', ...
        'ToolBar','none', ...
        'NumberTitle','off', ...
        'Visible','off', ...
        'Color',defaultBackground);
    movegui(handles.figure_launcher,'center');
    % Create UI elements
    handles.axis_title = axes(...
        'Parent',handles.figure_launcher,...
        'Units','normalized', ...
        'Position',[0.05 0.60 0.90 0.30], ...
        'Color',[0.2 0.2 0.2],...
        'Box','on','XTick',[],'YTick',[],...
        'ButtonDownFcn',@website);
    xlim([-1 1]); ylim([-1 1]);
    text(0,0,'DARMA v5.03','Color',[1 1 1],'FontSize',42,...
        'FontName','cambria','HorizontalAlignment','center',...
        'ButtonDownFcn',@website);
    handles.push_collect = uicontrol('Style','pushbutton', ...
        'Parent',handles.figure_launcher, ...
        'Units','Normalized', ...
        'Position',[0.05 0.10 0.25 0.40], ...
        'String','Collect', ...
        'FontSize',18, ...
        'Callback',@push_collect_Callback);
    handles.push_review = uicontrol('Style','pushbutton', ...
        'Parent',handles.figure_launcher, ...
        'Units','Normalized', ...
        'Position',[0.05 0.10 0.25 0.40], ...
        'String','Review', ...
        'FontSize',18, ...
        'Callback',@push_review_Callback);
    handles.push_configure = uicontrol('Style','pushbutton', ...
        'Parent',handles.figure_launcher, ...
        'Units','Normalized', ...
        'Position',[0.70 0.10 0.25 0.40], ...
        'String','Configure', ...
        'FontSize',18, ...
        'Callback',@push_configure_Callback);
    align([handles.push_collect,handles.push_review,handles.push_configure],'distribute','bottom');
    set(handles.figure_launcher,'Visible','on');
    guidata(handles.figure_launcher,handles);
    % Configure default settings
    global settings;
    if isdeployed
        settings = importdata(fullfile(ctfroot,'DARMA','default.mat'));
    else
        settings = importdata('default.mat');
    end
    % Check that VLC is installed
    axctl = actxcontrollist;
    index = strcmp(axctl(:,2),'VideoLAN.VLCPlugin.2');
    if sum(index)==0
        choice = questdlg(sprintf('DARMA requires the free, open source VLC Media Player.\nPlease be sure to download the 64-bit Windows version.\nPlease be sure to enable the "ActiveX plugin" option.\nOpen download page?'),...
            'DARMA','Yes','No','Yes');
        switch choice
            case 'Yes'
                web('http://www.videolan.org/vlc/download-windows.html','-browser');
        end
    end
    % Check for updates
    try
        rss = urlread('https://darma.codeplex.com/project/feeds/rss?ProjectRSSFeed=codeplex%3a%2f%2frelease%2fdarma');
        index = strfind(rss,'DARMA v');
        newest = str2double(rss(index(1)+7:index(1)+11));
        current = 5.03;
        if current < newest
            choice = questdlg(sprintf('DARMA has detected that an update is available.\nOpen download page?'),...
                'DARMA','Yes','No','Yes');
            switch choice
                case 'Yes'
                    web('http://darma.codeplex.com/releases/','-browser');
                    delete(handles.figure_launcher);
            end
        end
    catch
    end
end

function push_collect_Callback(~,~)
    fig_collect;
end

function push_review_Callback(~,~)
    fig_review;
end

function push_configure_Callback(~,~)
    fig_configure();
    uiwait(findobj('Name','DARMA: Configure'));
end

function website(~,~)
    choice = questdlg('Open DARMA website in browser?','DARMA','Yes','No','Yes');
    switch choice
        case 'Yes'
            web('http://darma.codeplex.com/','-browser');
        otherwise
            return;
    end
end