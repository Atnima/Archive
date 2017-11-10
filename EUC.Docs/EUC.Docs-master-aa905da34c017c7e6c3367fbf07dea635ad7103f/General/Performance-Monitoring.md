
http://blogs.technet.com/b/neiljohn/archive/2012/01/16/performance-monitor-tips-and-tricks-with-john-rodriguez.aspx
https://technet.microsoft.com/en-us/library/bb734903.aspx?f=255&MSPPError=-2147217396

`logman import -xml euc-perfmon.xml -name EUC-PerfCollector`

`logman start EUC-PerfCollector`


~~~~
<DataCollectorSet>
    <Status>1</Status>
    <Duration>28800</Duration>
    <Description>Generate a report detailing the status of local hardware resources, system response times, and processes on the local computer. Use this information to identify possible causes of performance issues. Membership in the local Administrators group, or equivalent, is the minimum required to run this Data Collector Set.</Description>
    <DescriptionUnresolved>Generate a report detailing the status of local hardware resources, system response times, and processes on the local computer. Use this information to identify possible causes of performance issues. Membership in the local Administrators group, or equivalent, is the minimum required to run this Data Collector Set.</DescriptionUnresolved>
    <DisplayName />
    <DisplayNameUnresolved />
    <SchedulesEnabled>-1</SchedulesEnabled>
    <Keyword>CPU</Keyword>
    <Keyword>Memory</Keyword>
    <Keyword>Disk</Keyword>
    <Keyword>Network</Keyword>
    <Keyword>Performance</Keyword>
    <Name>new data collector set</Name>
    <RootPath>%systemdrive%\PerfLogs\EUC\PerfDataCollector</RootPath>
    <Segment>-1</Segment>
    <SegmentMaxDuration>1800</SegmentMaxDuration>
    <SegmentMaxSize>0</SegmentMaxSize>
    <SerialNumber>5</SerialNumber>
    <Server />
    <Subdirectory />
    <SubdirectoryFormat>3</SubdirectoryFormat>
    <SubdirectoryFormatPattern>yyyyMMdd\-NNNNNN</SubdirectoryFormatPattern>
    <Task />
    <TaskRunAsSelf>0</TaskRunAsSelf>
    <TaskArguments />
    <TaskUserTextArguments />
    <UserAccount>SYSTEM</UserAccount>
    <Security>O:BAG:DUD:AI(A;;FA;;;SY)(A;;FA;;;BA)(A;;FR;;;LU)(A;;0x1301ff;;;S-1-5-80-2661322625-712705077-2999183737-3043590567-590698655)(A;ID;FA;;;SY)(A;ID;FA;;;BA)(A;ID;0x1200ab;;;LU)(A;ID;FR;;;AU)(A;ID;FR;;;LS)(A;ID;FR;;;NS)</Security>
    <StopOnCompletion>0</StopOnCompletion>
    <TraceDataCollector>
        <DataCollectorType>1</DataCollectorType>
        <Name>NT Kernel</Name>
        <FileName>NtKernel</FileName>
        <FileNameFormat>0</FileNameFormat>
        <FileNameFormatPattern />
        <LogAppend>0</LogAppend>
        <LogCircular>0</LogCircular>
        <LogOverwrite>0</LogOverwrite>
        <Guid>{00000000-0000-0000-0000-000000000000}</Guid>
        <BufferSize>64</BufferSize>
        <BuffersLost>0</BuffersLost>
        <BuffersWritten>70</BuffersWritten>
        <ClockType>1</ClockType>
        <EventsLost>0</EventsLost>
        <ExtendedModes>0</ExtendedModes>
        <FlushTimer>0</FlushTimer>
        <FreeBuffers>2</FreeBuffers>
        <MaximumBuffers>200</MaximumBuffers>
        <MinimumBuffers>0</MinimumBuffers>
        <NumberOfBuffers>0</NumberOfBuffers>
        <PreallocateFile>0</PreallocateFile>
        <ProcessMode>0</ProcessMode>
        <RealTimeBuffersLost>0</RealTimeBuffersLost>
        <SessionName>NT Kernel Logger</SessionName>
        <SessionThreadId>4732</SessionThreadId>
        <StreamMode>1</StreamMode>
        <TraceDataProvider>
            <DisplayName>{9E814AAD-3204-11D2-9A82-006008A86939}</DisplayName>
            <FilterEnabled>0</FilterEnabled>
            <FilterType>0</FilterType>
            <Level>
                <Description>Events up to this level are enabled</Description>
                <ValueMapType>1</ValueMapType>
                <Value>0</Value>
                <ValueMapItem>
                    <Key />
                    <Description />
                    <Enabled>-1</Enabled>
                    <Value>0x0</Value>
                </ValueMapItem>
            </Level>
            <KeywordsAny>
                <Description>Events with any of these keywords are enabled</Description>
                <ValueMapType>2</ValueMapType>
                <Value>0x10303</Value>
                <ValueMapItem>
                    <Key />
                    <Description />
                    <Enabled>-1</Enabled>
                    <Value>0x1</Value>
                </ValueMapItem>
                <ValueMapItem>
                    <Key />
                    <Description />
                    <Enabled>-1</Enabled>
                    <Value>0x2</Value>
                </ValueMapItem>
                <ValueMapItem>
                    <Key />
                    <Description />
                    <Enabled>-1</Enabled>
                    <Value>0x100</Value>
                </ValueMapItem>
                <ValueMapItem>
                    <Key />
                    <Description />
                    <Enabled>-1</Enabled>
                    <Value>0x200</Value>
                </ValueMapItem>
                <ValueMapItem>
                    <Key />
                    <Description />
                    <Enabled>-1</Enabled>
                    <Value>0x10000</Value>
                </ValueMapItem>
            </KeywordsAny>
            <KeywordsAll>
                <Description>Events with all of these keywords are enabled</Description>
                <ValueMapType>2</ValueMapType>
                <Value>0x0</Value>
            </KeywordsAll>
            <Properties>
                <Description>These additional data fields will be collected with each event</Description>
                <ValueMapType>2</ValueMapType>
                <Value>0</Value>
            </Properties>
            <Guid>{9E814AAD-3204-11D2-9A82-006008A86939}</Guid>
        </TraceDataProvider>
    </TraceDataCollector>
    <PerformanceCounterDataCollector>
        <DataCollectorType>0</DataCollectorType>
        <Name>Performance Counter</Name>
        <FileName>Performance Counter</FileName>
        <FileNameFormat>0</FileNameFormat>
        <FileNameFormatPattern />
        <LogAppend>0</LogAppend>
        <LogCircular>0</LogCircular>
        <LogOverwrite>0</LogOverwrite>
        <DataSourceName />
        <SampleInterval>1</SampleInterval>
        <SegmentMaxRecords>0</SegmentMaxRecords>
        <LogFileFormat>3</LogFileFormat>
        <Counter>\Process(*)\*</Counter>
        <Counter>\PhysicalDisk(*)\*</Counter>
        <Counter>\Processor(*)\*</Counter>
        <Counter>\Processor Performance(*)\*</Counter>
        <Counter>\Memory\*</Counter>
        <Counter>\System\*</Counter>
        <Counter>\Server\*</Counter>
        <Counter>\Network Interface(*)\*</Counter>
        <Counter>\UDPv4\*</Counter>
        <Counter>\TCPv4\*</Counter>
        <Counter>\IPv4\*</Counter>
        <Counter>\UDPv6\*</Counter>
        <Counter>\TCPv6\*</Counter>
        <Counter>\IPv6\*</Counter>
        <CounterDisplayName>\Process(*)\*</CounterDisplayName>
        <CounterDisplayName>\PhysicalDisk(*)\*</CounterDisplayName>
        <CounterDisplayName>\Processor(*)\*</CounterDisplayName>
        <CounterDisplayName>\Processor Performance(*)\*</CounterDisplayName>
        <CounterDisplayName>\Memory\*</CounterDisplayName>
        <CounterDisplayName>\System\*</CounterDisplayName>
        <CounterDisplayName>\Server\*</CounterDisplayName>
        <CounterDisplayName>\Network Interface(*)\*</CounterDisplayName>
        <CounterDisplayName>\UDPv4\*</CounterDisplayName>
        <CounterDisplayName>\TCPv4\*</CounterDisplayName>
        <CounterDisplayName>\IPv4\*</CounterDisplayName>
        <CounterDisplayName>\UDPv6\*</CounterDisplayName>
        <CounterDisplayName>\TCPv6\*</CounterDisplayName>
        <CounterDisplayName>\IPv6\*</CounterDisplayName>
    </PerformanceCounterDataCollector>
    <DataManager>
        <Enabled>-1</Enabled>
        <CheckBeforeRunning>-1</CheckBeforeRunning>
        <MinFreeDisk>200</MinFreeDisk>
        <MaxSize>1024</MaxSize>
        <MaxFolderCount>100</MaxFolderCount>
        <ResourcePolicy>0</ResourcePolicy>
        <ReportFileName>report.html</ReportFileName>
        <RuleTargetFileName>report.xml</RuleTargetFileName>
        <EventsFileName />
        <Rules>
            <Logging level="15" file="rules.log" />
            <Import file="%systemroot%\pla\rules\Rules.System.Common.xml" />
            <Import file="%systemroot%\pla\rules\Rules.System.Summary.xml" />
            <Import file="%systemroot%\pla\rules\Rules.System.Performance.xml" />
            <Import file="%systemroot%\pla\rules\Rules.System.CPU.xml" />
            <Import file="%systemroot%\pla\rules\Rules.System.Network.xml" />
            <Import file="%systemroot%\pla\rules\Rules.System.Disk.xml" />
            <Import file="%systemroot%\pla\rules\Rules.System.Memory.xml" />
        </Rules>
        <ReportSchema>
            <Report name="systemPerformance" version="1" threshold="100">
                <Import file="%systemroot%\pla\reports\Report.System.Common.xml" />
                <Import file="%systemroot%\pla\reports\Report.System.Summary.xml" />
                <Import file="%systemroot%\pla\reports\Report.System.Performance.xml" />
                <Import file="%systemroot%\pla\reports\Report.System.CPU.xml" />
                <Import file="%systemroot%\pla\reports\Report.System.Network.xml" />
                <Import file="%systemroot%\pla\reports\Report.System.Disk.xml" />
                <Import file="%systemroot%\pla\reports\Report.System.Memory.xml" />
            </Report>
        </ReportSchema>
        <FolderAction>
            <Size>0</Size>
            <Age>1</Age>
            <Actions>3</Actions>
            <SendCabTo />
        </FolderAction>
        <FolderAction>
            <Size>0</Size>
            <Age>56</Age>
            <Actions>8</Actions>
            <SendCabTo />
        </FolderAction>
        <FolderAction>
            <Size>0</Size>
            <Age>168</Age>
            <Actions>26</Actions>
            <SendCabTo />
        </FolderAction>
    </DataManager>
    <Value name="PerformanceMonitorView" type="document">
        <OBJECT ID="DISystemMonitor" CLASSID="CLSID:C4D2D8E0-D1DD-11CE-940F-008029004347">
            <PARAM NAME="CounterCount" VALUE="4" />
            <PARAM NAME="Counter00001.Path" VALUE="\Processor(_Total)\% Processor Time" />
            <PARAM NAME="Counter00001.Color" VALUE="255" />
            <PARAM NAME="Counter00001.Width" VALUE="2" />
            <PARAM NAME="Counter00001.LineStyle" VALUE="0" />
            <PARAM NAME="Counter00001.ScaleFactor" VALUE="0" />
            <PARAM NAME="Counter00001.Show" VALUE="1" />
            <PARAM NAME="Counter00001.Selected" VALUE="1" />
            <PARAM NAME="Counter00002.Path" VALUE="\Memory\Pages/sec" />
            <PARAM NAME="Counter00002.Color" VALUE="65280" />
            <PARAM NAME="Counter00002.Width" VALUE="1" />
            <PARAM NAME="Counter00003.Path" VALUE="\PhysicalDisk(_Total)\Avg. Disk sec/Read" />
            <PARAM NAME="Counter00003.Color" VALUE="16711680" />
            <PARAM NAME="Counter00003.Width" VALUE="1" />
            <PARAM NAME="Counter00004.Path" VALUE="\PhysicalDisk(_Total)\Avg. Disk sec/Write" />
            <PARAM NAME="Counter00004.Color" VALUE="55295" />
            <PARAM NAME="Counter00004.Width" VALUE="1" />
        </OBJECT>
    </Value>
</DataCollectorSet>
~~~~
