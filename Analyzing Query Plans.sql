CREATE DATABASE Project_Part2
GO

USE Project_Part2
GO

-- Creating 3 tables T1, T2, T3
CREATE TABLE T1
(
	a int not null primary key,
	b int,
	c int
)

CREATE TABLE T2
(
	a int not null primary key,
	b int,
	c int
)

CREATE TABLE T3
(
	a int not null,
	b int,
	c int
)
GO

--Set non-clustered index for T1, T2, T3
create index T1_NCI on T1(b)
create index T2_NCI on T2(b)

--Drop table T1, T2, and T3 if needed
drop table T1
drop table T2
drop table T3

--Check Tables
select * from T1
select * from T2
select * from T3

--Delete all contents from T1, T2, and T3
delete from T1
delete from T2
delete from T3

--Query
select count(T1.a) from T1 join T2 on T1.a = T2.a join T3 on T1.a =T3.a
where T2.c> 500
group by T1.b order by T1.b
option
(
use plan N''
)

--Cardinality 1: T1 has 0 row, T2 has 0 row, and T3 has 0 row
--Simply try the query

--Cardinality 2: T1 has 100 row, T2 has 300 row, and T3 has 700 row
DECLARE @i1 int = 0
WHILE @i1 < 100
BEGIN
    SET @i1 = @i1 + 1
    INSERT INTO T1 values(@i1, @i1%100, @i1*7)
END

DECLARE @i2 int = 0
WHILE @i2 < 300
BEGIN
    SET @i2 = @i2 + 1
    INSERT INTO T2 values(@i2, @i2%100, @i2*3)
END

DECLARE @i3 int = 0
WHILE @i3 < 700
BEGIN
    SET @i3 = @i3 + 1
    INSERT INTO T3 values(@i3, @i3%100, @i3*2)
END

--Cardinality 3: T1 has 5000 row, T2 has 300 row, and T3 has 700 row
DECLARE @i1 int = 100
WHILE @i1 < 5000
BEGIN
    SET @i1 = @i1 + 1
    INSERT INTO T1 values(@i1, @i1%100, @i1*7)
END

--Cardinality 4: T1 has 10000 row, T2 has 30000 row, and T3 has 7000 row
DECLARE @i1 int = 5000
WHILE @i1 < 10000
BEGIN
    SET @i1 = @i1 + 1
    INSERT INTO T1 values(@i1, @i1%100, @i1*7)
END

DECLARE @i2 int = 300
WHILE @i2 < 30000
BEGIN
    SET @i2 = @i2 + 1
    INSERT INTO T2 values(@i2, @i2%100, @i2*3)
END

DECLARE @i3 int = 700
WHILE @i3 < 7000
BEGIN
    SET @i3 = @i3 + 1
    INSERT INTO T3 values(@i3, @i3%100, @i3*2)
END

--Cardinality 5: T1 has 10000 row, T2 has 30000 row, and T3 has 70000 row
DECLARE @i3 int = 7000
WHILE @i3 < 70000
BEGIN
    SET @i3 = @i3 + 1
    INSERT INTO T3 values(@i3, @i3%100, @i3*2)
END

--Cardinality 1 XML:
<?xml version="1.0" encoding="utf-16"?>
<ShowPlanXML xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" Version="1.5" Build="13.0.4001.0" xmlns="http://schemas.microsoft.com/sqlserver/2004/07/showplan">
  <BatchSequence>
    <Batch>
      <Statements>
        <StmtSimple StatementCompId="1" StatementEstRows="1" StatementId="1" StatementOptmLevel="FULL" StatementOptmEarlyAbortReason="GoodEnoughPlanFound" CardinalityEstimationModelVersion="130" StatementSubTreeCost="0.0382575" StatementText="select count(T1.a) from T1 join T2 on T1.a = T2.a join T3 on T1.a =T3.a&#xD;&#xA;where T2.c&gt; 500&#xD;&#xA;group by T1.b order by T1.b" StatementType="SELECT" QueryHash="0xD64741D348AF8189" QueryPlanHash="0x881A87FE20AD51A6" RetrievedFromCache="false" SecurityPolicyApplied="false">
          <StatementSetOptions ANSI_NULLS="true" ANSI_PADDING="true" ANSI_WARNINGS="true" ARITHABORT="true" CONCAT_NULL_YIELDS_NULL="true" NUMERIC_ROUNDABORT="false" QUOTED_IDENTIFIER="true" />
          <QueryPlan NonParallelPlanReason="NoParallelPlansInDesktopOrExpressEdition" CachedPlanSize="32" CompileTime="3" CompileCPU="3" CompileMemory="320">
            <MemoryGrantInfo SerialRequiredMemory="512" SerialDesiredMemory="544" />
            <OptimizerHardwareDependentProperties EstimatedAvailableMemoryGrant="207707" EstimatedPagesCached="51926" EstimatedAvailableDegreeOfParallelism="2" MaxCompileMemory="706640" />
            <TraceFlags IsCompileTime="true">
              <TraceFlag Value="8017" Scope="Global" />
            </TraceFlags>
            <RelOp AvgRowSize="15" EstimateCPU="0" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" LogicalOp="Compute Scalar" NodeId="0" Parallel="false" PhysicalOp="Compute Scalar" EstimatedTotalSubtreeCost="0.0382575">
              <OutputList>
                <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                <ColumnReference Column="Expr1007" />
              </OutputList>
              <ComputeScalar>
                <DefinedValues>
                  <DefinedValue>
                    <ColumnReference Column="Expr1007" />
                    <ScalarOperator ScalarString="CONVERT_IMPLICIT(int,[Expr1008],0)">
                      <Convert DataType="int" Style="0" Implicit="true">
                        <ScalarOperator>
                          <Identifier>
                            <ColumnReference Column="Expr1008" />
                          </Identifier>
                        </ScalarOperator>
                      </Convert>
                    </ScalarOperator>
                  </DefinedValue>
                </DefinedValues>
                <RelOp AvgRowSize="15" EstimateCPU="1.1E-06" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" LogicalOp="Aggregate" NodeId="1" Parallel="false" PhysicalOp="Stream Aggregate" EstimatedTotalSubtreeCost="0.0382575">
                  <OutputList>
                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                    <ColumnReference Column="Expr1008" />
                  </OutputList>
                  <StreamAggregate>
                    <DefinedValues>
                      <DefinedValue>
                        <ColumnReference Column="Expr1008" />
                        <ScalarOperator ScalarString="Count(*)">
                          <Aggregate AggType="countstar" Distinct="false" />
                        </ScalarOperator>
                      </DefinedValue>
                    </DefinedValues>
                    <GroupBy>
                      <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                    </GroupBy>
                    <RelOp AvgRowSize="11" EstimateCPU="0.000100011" EstimateIO="0.0112613" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" LogicalOp="Sort" NodeId="2" Parallel="false" PhysicalOp="Sort" EstimatedTotalSubtreeCost="0.0382564">
                      <OutputList>
                        <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                      </OutputList>
                      <MemoryFractions Input="1" Output="1" />
                      <Sort Distinct="false">
                        <OrderBy>
                          <OrderByColumn Ascending="true">
                            <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                          </OrderByColumn>
                        </OrderBy>
                        <RelOp AvgRowSize="11" EstimateCPU="4.18E-06" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" LogicalOp="Inner Join" NodeId="3" Parallel="false" PhysicalOp="Nested Loops" EstimatedTotalSubtreeCost="0.0268952">
                          <OutputList>
                            <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                          </OutputList>
                          <NestedLoops Optimized="false">
                            <OuterReferences>
                              <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                            </OuterReferences>
                            <RelOp AvgRowSize="15" EstimateCPU="4.18E-06" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" LogicalOp="Inner Join" NodeId="4" Parallel="false" PhysicalOp="Nested Loops" EstimatedTotalSubtreeCost="0.0236074">
                              <OutputList>
                                <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                                <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                              </OutputList>
                              <NestedLoops Optimized="false">
                                <OuterReferences>
                                  <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                                </OuterReferences>
                                <RelOp AvgRowSize="11" EstimateCPU="0.0001581" EstimateIO="0.020162" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" EstimatedRowsRead="1" LogicalOp="Table Scan" NodeId="5" Parallel="false" PhysicalOp="Table Scan" EstimatedTotalSubtreeCost="0.0203201" TableCardinality="0">
                                  <OutputList>
                                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                                  </OutputList>
                                  <TableScan Ordered="false" ForcedIndex="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                                    <DefinedValues>
                                      <DefinedValue>
                                        <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                                      </DefinedValue>
                                    </DefinedValues>
                                    <Object Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" IndexKind="Heap" Storage="RowStore" />
                                  </TableScan>
                                </RelOp>
                                <RelOp AvgRowSize="11" EstimateCPU="0.0001581" EstimateIO="0.003125" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" EstimatedRowsRead="1" LogicalOp="Clustered Index Seek" NodeId="6" Parallel="false" PhysicalOp="Clustered Index Seek" EstimatedTotalSubtreeCost="0.0032831" TableCardinality="0">
                                  <OutputList>
                                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                                  </OutputList>
                                  <IndexScan Ordered="true" ScanDirection="FORWARD" ForcedIndex="false" ForceSeek="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                                    <DefinedValues>
                                      <DefinedValue>
                                        <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                                      </DefinedValue>
                                    </DefinedValues>
                                    <Object Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Index="[PK__T1__3BD0198E1B81B621]" IndexKind="Clustered" Storage="RowStore" />
                                    <SeekPredicates>
                                      <SeekPredicateNew>
                                        <SeekKeys>
                                          <Prefix ScanType="EQ">
                                            <RangeColumns>
                                              <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="a" />
                                            </RangeColumns>
                                            <RangeExpressions>
                                              <ScalarOperator ScalarString="[Project_Part2].[dbo].[T3].[a]">
                                                <Identifier>
                                                  <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                                                </Identifier>
                                              </ScalarOperator>
                                            </RangeExpressions>
                                          </Prefix>
                                        </SeekKeys>
                                      </SeekPredicateNew>
                                    </SeekPredicates>
                                  </IndexScan>
                                </RelOp>
                              </NestedLoops>
                            </RelOp>
                            <RelOp AvgRowSize="11" EstimateCPU="0.0001581" EstimateIO="0.003125" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" EstimatedRowsRead="1" LogicalOp="Clustered Index Seek" NodeId="7" Parallel="false" PhysicalOp="Clustered Index Seek" EstimatedTotalSubtreeCost="0.0032831" TableCardinality="0">
                              <OutputList />
                              <IndexScan Ordered="true" ScanDirection="FORWARD" ForcedIndex="false" ForceSeek="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                                <DefinedValues />
                                <Object Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Index="[PK__T2__3BD0198EB53F5045]" IndexKind="Clustered" Storage="RowStore" />
                                <SeekPredicates>
                                  <SeekPredicateNew>
                                    <SeekKeys>
                                      <Prefix ScanType="EQ">
                                        <RangeColumns>
                                          <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="a" />
                                        </RangeColumns>
                                        <RangeExpressions>
                                          <ScalarOperator ScalarString="[Project_Part2].[dbo].[T3].[a]">
                                            <Identifier>
                                              <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                                            </Identifier>
                                          </ScalarOperator>
                                        </RangeExpressions>
                                      </Prefix>
                                    </SeekKeys>
                                  </SeekPredicateNew>
                                </SeekPredicates>
                                <Predicate>
                                  <ScalarOperator ScalarString="[Project_Part2].[dbo].[T2].[c]&gt;(500)">
                                    <Compare CompareOp="GT">
                                      <ScalarOperator>
                                        <Identifier>
                                          <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="c" />
                                        </Identifier>
                                      </ScalarOperator>
                                      <ScalarOperator>
                                        <Const ConstValue="(500)" />
                                      </ScalarOperator>
                                    </Compare>
                                  </ScalarOperator>
                                </Predicate>
                              </IndexScan>
                            </RelOp>
                          </NestedLoops>
                        </RelOp>
                      </Sort>
                    </RelOp>
                  </StreamAggregate>
                </RelOp>
              </ComputeScalar>
            </RelOp>
          </QueryPlan>
        </StmtSimple>
      </Statements>
    </Batch>
  </BatchSequence>
</ShowPlanXML>

--Cardinality 2 XML:
<ShowPlanXML xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" Version="1.5" Build="13.0.4001.0" xmlns="http://schemas.microsoft.com/sqlserver/2004/07/showplan">
  <BatchSequence>
    <Batch>
      <Statements>
        <StmtSimple StatementCompId="1" StatementEstRows="44.3333" StatementId="1" StatementOptmLevel="FULL" StatementOptmEarlyAbortReason="GoodEnoughPlanFound" CardinalityEstimationModelVersion="130" StatementSubTreeCost="0.0771755" StatementText="select count(T1.a) from T1 join T2 on T1.a = T2.a join T3 on T1.a =T3.a&#xD;&#xA;where T2.c&gt; 500&#xD;&#xA;group by T1.b order by T1.b" StatementType="SELECT" QueryHash="0xD64741D348AF8189" QueryPlanHash="0x9B00D7017E14544D" RetrievedFromCache="false" SecurityPolicyApplied="false">
          <StatementSetOptions ANSI_NULLS="true" ANSI_PADDING="true" ANSI_WARNINGS="true" ARITHABORT="true" CONCAT_NULL_YIELDS_NULL="true" NUMERIC_ROUNDABORT="false" QUOTED_IDENTIFIER="true" />
          <QueryPlan NonParallelPlanReason="NoParallelPlansInDesktopOrExpressEdition" CachedPlanSize="48" CompileTime="36" CompileCPU="9" CompileMemory="480">
            <MemoryGrantInfo SerialRequiredMemory="1536" SerialDesiredMemory="1600" />
            <OptimizerHardwareDependentProperties EstimatedAvailableMemoryGrant="207707" EstimatedPagesCached="51926" EstimatedAvailableDegreeOfParallelism="2" MaxCompileMemory="684928" />
            <TraceFlags IsCompileTime="true">
              <TraceFlag Value="8017" Scope="Global" />
            </TraceFlags>
            <RelOp AvgRowSize="15" EstimateCPU="0" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="44.3333" LogicalOp="Compute Scalar" NodeId="0" Parallel="false" PhysicalOp="Compute Scalar" EstimatedTotalSubtreeCost="0.0771755">
              <OutputList>
                <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                <ColumnReference Column="Expr1007" />
              </OutputList>
              <ComputeScalar>
                <DefinedValues>
                  <DefinedValue>
                    <ColumnReference Column="Expr1007" />
                    <ScalarOperator ScalarString="CONVERT_IMPLICIT(int,[Expr1008],0)">
                      <Convert DataType="int" Style="0" Implicit="true">
                        <ScalarOperator>
                          <Identifier>
                            <ColumnReference Column="Expr1008" />
                          </Identifier>
                        </ScalarOperator>
                      </Convert>
                    </ScalarOperator>
                  </DefinedValue>
                </DefinedValues>
                <RelOp AvgRowSize="15" EstimateCPU="4.87667E-05" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="44.3333" LogicalOp="Aggregate" NodeId="1" Parallel="false" PhysicalOp="Stream Aggregate" EstimatedTotalSubtreeCost="0.0771755">
                  <OutputList>
                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                    <ColumnReference Column="Expr1008" />
                  </OutputList>
                  <StreamAggregate>
                    <DefinedValues>
                      <DefinedValue>
                        <ColumnReference Column="Expr1008" />
                        <ScalarOperator ScalarString="Count(*)">
                          <Aggregate AggType="countstar" Distinct="false" />
                        </ScalarOperator>
                      </DefinedValue>
                    </DefinedValues>
                    <GroupBy>
                      <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                    </GroupBy>
                    <RelOp AvgRowSize="11" EstimateCPU="0.000478338" EstimateIO="0.0112613" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="44.3333" LogicalOp="Sort" NodeId="2" Parallel="false" PhysicalOp="Sort" EstimatedTotalSubtreeCost="0.0771267">
                      <OutputList>
                        <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                      </OutputList>
                      <MemoryFractions Input="0.5" Output="1" />
                      <Sort Distinct="false">
                        <OrderBy>
                          <OrderByColumn Ascending="true">
                            <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                          </OrderByColumn>
                        </OrderBy>
                        <RelOp AvgRowSize="11" EstimateCPU="0.0215021" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="44.3333" LogicalOp="Inner Join" NodeId="3" Parallel="false" PhysicalOp="Hash Match" EstimatedTotalSubtreeCost="0.0653871">
                          <OutputList>
                            <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                          </OutputList>
                          <MemoryFractions Input="1" Output="0.5" />
                          <Hash>
                            <DefinedValues />
                            <HashKeysBuild>
                              <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="a" />
                            </HashKeysBuild>
                            <HashKeysProbe>
                              <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                            </HashKeysProbe>
                            <RelOp AvgRowSize="15" EstimateCPU="0.000418" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="44.3333" LogicalOp="Inner Join" NodeId="4" Parallel="false" PhysicalOp="Nested Loops" EstimatedTotalSubtreeCost="0.022793">
                              <OutputList>
                                <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                                <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="a" />
                              </OutputList>
                              <NestedLoops Optimized="false">
                                <OuterReferences>
                                  <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="a" />
                                </OuterReferences>
                                <RelOp AvgRowSize="15" EstimateCPU="0.000267" EstimateIO="0.003125" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="100" EstimatedRowsRead="100" LogicalOp="Clustered Index Scan" NodeId="5" Parallel="false" PhysicalOp="Clustered Index Scan" EstimatedTotalSubtreeCost="0.003392" TableCardinality="100">
                                  <OutputList>
                                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="a" />
                                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                                  </OutputList>
                                  <IndexScan Ordered="false" ForcedIndex="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                                    <DefinedValues>
                                      <DefinedValue>
                                        <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="a" />
                                      </DefinedValue>
                                      <DefinedValue>
                                        <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                                      </DefinedValue>
                                    </DefinedValues>
                                    <Object Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Index="[PK__T1__3BD0198E1B81B621]" IndexKind="Clustered" Storage="RowStore" />
                                  </IndexScan>
                                </RelOp>
                                <RelOp AvgRowSize="15" EstimateCPU="0.0001581" EstimateIO="0.003125" EstimateRebinds="99" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="1" EstimatedRowsRead="1" LogicalOp="Clustered Index Seek" NodeId="6" Parallel="false" PhysicalOp="Clustered Index Seek" EstimatedTotalSubtreeCost="0.018935" TableCardinality="300">
                                  <OutputList>
                                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="a" />
                                  </OutputList>
                                  <IndexScan Ordered="true" ScanDirection="FORWARD" ForcedIndex="false" ForceSeek="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                                    <DefinedValues>
                                      <DefinedValue>
                                        <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="a" />
                                      </DefinedValue>
                                    </DefinedValues>
                                    <Object Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Index="[PK__T2__3BD0198EB53F5045]" IndexKind="Clustered" Storage="RowStore" />
                                    <SeekPredicates>
                                      <SeekPredicateNew>
                                        <SeekKeys>
                                          <Prefix ScanType="EQ">
                                            <RangeColumns>
                                              <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="a" />
                                            </RangeColumns>
                                            <RangeExpressions>
                                              <ScalarOperator ScalarString="[Project_Part2].[dbo].[T1].[a]">
                                                <Identifier>
                                                  <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="a" />
                                                </Identifier>
                                              </ScalarOperator>
                                            </RangeExpressions>
                                          </Prefix>
                                        </SeekKeys>
                                      </SeekPredicateNew>
                                    </SeekPredicates>
                                    <Predicate>
                                      <ScalarOperator ScalarString="[Project_Part2].[dbo].[T2].[c]&gt;(500)">
                                        <Compare CompareOp="GT">
                                          <ScalarOperator>
                                            <Identifier>
                                              <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="c" />
                                            </Identifier>
                                          </ScalarOperator>
                                          <ScalarOperator>
                                            <Const ConstValue="(500)" />
                                          </ScalarOperator>
                                        </Compare>
                                      </ScalarOperator>
                                    </Predicate>
                                  </IndexScan>
                                </RelOp>
                              </NestedLoops>
                            </RelOp>
                            <RelOp AvgRowSize="11" EstimateCPU="0.000927" EstimateIO="0.020162" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="700" EstimatedRowsRead="700" LogicalOp="Table Scan" NodeId="7" Parallel="false" PhysicalOp="Table Scan" EstimatedTotalSubtreeCost="0.021089" TableCardinality="700">
                              <OutputList>
                                <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                              </OutputList>
                              <TableScan Ordered="false" ForcedIndex="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                                <DefinedValues>
                                  <DefinedValue>
                                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                                  </DefinedValue>
                                </DefinedValues>
                                <Object Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" IndexKind="Heap" Storage="RowStore" />
                              </TableScan>
                            </RelOp>
                          </Hash>
                        </RelOp>
                      </Sort>
                    </RelOp>
                  </StreamAggregate>
                </RelOp>
              </ComputeScalar>
            </RelOp>
          </QueryPlan>
        </StmtSimple>
      </Statements>
    </Batch>
  </BatchSequence>
</ShowPlanXML>

--Cardinality 3 XML:
<ShowPlanXML xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" Version="1.5" Build="13.0.4001.0" xmlns="http://schemas.microsoft.com/sqlserver/2004/07/showplan">
  <BatchSequence>
    <Batch>
      <Statements>
        <StmtSimple StatementCompId="1" StatementEstRows="74.1988" StatementId="1" StatementOptmLevel="FULL" StatementOptmEarlyAbortReason="GoodEnoughPlanFound" CardinalityEstimationModelVersion="130" StatementSubTreeCost="0.0848494" StatementText="select count(T1.a) from T1 join T2 on T1.a = T2.a join T3 on T1.a =T3.a&#xD;&#xA;where T2.c&gt; 500&#xD;&#xA;group by T1.b order by T1.b" StatementType="SELECT" QueryHash="0xD64741D348AF8189" QueryPlanHash="0xF06D50910C987FFE" RetrievedFromCache="false" SecurityPolicyApplied="false">
          <StatementSetOptions ANSI_NULLS="true" ANSI_PADDING="true" ANSI_WARNINGS="true" ARITHABORT="true" CONCAT_NULL_YIELDS_NULL="true" NUMERIC_ROUNDABORT="false" QUOTED_IDENTIFIER="true" />
          <QueryPlan NonParallelPlanReason="NoParallelPlansInDesktopOrExpressEdition" CachedPlanSize="48" CompileTime="13" CompileCPU="12" CompileMemory="464">
            <MemoryGrantInfo SerialRequiredMemory="1536" SerialDesiredMemory="1632" />
            <OptimizerHardwareDependentProperties EstimatedAvailableMemoryGrant="207707" EstimatedPagesCached="51926" EstimatedAvailableDegreeOfParallelism="2" MaxCompileMemory="623496" />
            <TraceFlags IsCompileTime="true">
              <TraceFlag Value="8017" Scope="Global" />
            </TraceFlags>
            <RelOp AvgRowSize="15" EstimateCPU="0" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="74.1988" LogicalOp="Compute Scalar" NodeId="0" Parallel="false" PhysicalOp="Compute Scalar" EstimatedTotalSubtreeCost="0.0848494">
              <OutputList>
                <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                <ColumnReference Column="Expr1007" />
              </OutputList>
              <ComputeScalar>
                <DefinedValues>
                  <DefinedValue>
                    <ColumnReference Column="Expr1007" />
                    <ScalarOperator ScalarString="CONVERT_IMPLICIT(int,[Expr1008],0)">
                      <Convert DataType="int" Style="0" Implicit="true">
                        <ScalarOperator>
                          <Identifier>
                            <ColumnReference Column="Expr1008" />
                          </Identifier>
                        </ScalarOperator>
                      </Convert>
                    </ScalarOperator>
                  </DefinedValue>
                </DefinedValues>
                <RelOp AvgRowSize="15" EstimateCPU="0.000116899" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="74.1988" LogicalOp="Aggregate" NodeId="1" Parallel="false" PhysicalOp="Stream Aggregate" EstimatedTotalSubtreeCost="0.0848494">
                  <OutputList>
                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                    <ColumnReference Column="Expr1008" />
                  </OutputList>
                  <StreamAggregate>
                    <DefinedValues>
                      <DefinedValue>
                        <ColumnReference Column="Expr1008" />
                        <ScalarOperator ScalarString="Count(*)">
                          <Aggregate AggType="countstar" Distinct="false" />
                        </ScalarOperator>
                      </DefinedValue>
                    </DefinedValues>
                    <GroupBy>
                      <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                    </GroupBy>
                    <RelOp AvgRowSize="11" EstimateCPU="0.00156384" EstimateIO="0.0112613" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="133" LogicalOp="Sort" NodeId="2" Parallel="false" PhysicalOp="Sort" EstimatedTotalSubtreeCost="0.0847325">
                      <OutputList>
                        <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                      </OutputList>
                      <MemoryFractions Input="0.333333" Output="1" />
                      <Sort Distinct="false">
                        <OrderBy>
                          <OrderByColumn Ascending="true">
                            <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                          </OrderByColumn>
                        </OrderBy>
                        <RelOp AvgRowSize="11" EstimateCPU="0.00055594" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="133" LogicalOp="Inner Join" NodeId="3" Parallel="false" PhysicalOp="Nested Loops" EstimatedTotalSubtreeCost="0.0719074">
                          <OutputList>
                            <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                          </OutputList>
                          <NestedLoops Optimized="false">
                            <OuterReferences>
                              <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                            </OuterReferences>
                            <RelOp AvgRowSize="11" EstimateCPU="0.0223511" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="133" LogicalOp="Inner Join" NodeId="4" Parallel="false" PhysicalOp="Hash Match" EstimatedTotalSubtreeCost="0.0471992">
                              <OutputList>
                                <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                              </OutputList>
                              <MemoryFractions Input="1" Output="0.666667" />
                              <Hash>
                                <DefinedValues />
                                <HashKeysBuild>
                                  <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="a" />
                                </HashKeysBuild>
                                <HashKeysProbe>
                                  <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                                </HashKeysProbe>
                                <RelOp AvgRowSize="15" EstimateCPU="0.000487" EstimateIO="0.003125" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="133" EstimatedRowsRead="300" LogicalOp="Clustered Index Scan" NodeId="5" Parallel="false" PhysicalOp="Clustered Index Scan" EstimatedTotalSubtreeCost="0.003612" TableCardinality="300">
                                  <OutputList>
                                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="a" />
                                  </OutputList>
                                  <IndexScan Ordered="false" ForcedIndex="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                                    <DefinedValues>
                                      <DefinedValue>
                                        <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="a" />
                                      </DefinedValue>
                                    </DefinedValues>
                                    <Object Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Index="[PK__T2__3BD0198EB53F5045]" IndexKind="Clustered" Storage="RowStore" />
                                    <Predicate>
                                      <ScalarOperator ScalarString="[Project_Part2].[dbo].[T2].[c]&gt;(500)">
                                        <Compare CompareOp="GT">
                                          <ScalarOperator>
                                            <Identifier>
                                              <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="c" />
                                            </Identifier>
                                          </ScalarOperator>
                                          <ScalarOperator>
                                            <Const ConstValue="(500)" />
                                          </ScalarOperator>
                                        </Compare>
                                      </ScalarOperator>
                                    </Predicate>
                                  </IndexScan>
                                </RelOp>
                                <RelOp AvgRowSize="11" EstimateCPU="0.000927" EstimateIO="0.020162" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="700" EstimatedRowsRead="700" LogicalOp="Table Scan" NodeId="6" Parallel="false" PhysicalOp="Table Scan" EstimatedTotalSubtreeCost="0.021089" TableCardinality="700">
                                  <OutputList>
                                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                                  </OutputList>
                                  <TableScan Ordered="false" ForcedIndex="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                                    <DefinedValues>
                                      <DefinedValue>
                                        <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                                      </DefinedValue>
                                    </DefinedValues>
                                    <Object Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" IndexKind="Heap" Storage="RowStore" />
                                  </TableScan>
                                </RelOp>
                              </Hash>
                            </RelOp>
                            <RelOp AvgRowSize="11" EstimateCPU="0.0001581" EstimateIO="0.003125" EstimateRebinds="132" EstimateRewinds="4.66294E-15" EstimatedExecutionMode="Row" EstimateRows="1" EstimatedRowsRead="1" LogicalOp="Clustered Index Seek" NodeId="7" Parallel="false" PhysicalOp="Clustered Index Seek" EstimatedTotalSubtreeCost="0.0241523" TableCardinality="5000">
                              <OutputList>
                                <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                              </OutputList>
                              <IndexScan Ordered="true" ScanDirection="FORWARD" ForcedIndex="false" ForceSeek="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                                <DefinedValues>
                                  <DefinedValue>
                                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                                  </DefinedValue>
                                </DefinedValues>
                                <Object Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Index="[PK__T1__3BD0198E1B81B621]" IndexKind="Clustered" Storage="RowStore" />
                                <SeekPredicates>
                                  <SeekPredicateNew>
                                    <SeekKeys>
                                      <Prefix ScanType="EQ">
                                        <RangeColumns>
                                          <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="a" />
                                        </RangeColumns>
                                        <RangeExpressions>
                                          <ScalarOperator ScalarString="[Project_Part2].[dbo].[T3].[a]">
                                            <Identifier>
                                              <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                                            </Identifier>
                                          </ScalarOperator>
                                        </RangeExpressions>
                                      </Prefix>
                                    </SeekKeys>
                                  </SeekPredicateNew>
                                </SeekPredicates>
                              </IndexScan>
                            </RelOp>
                          </NestedLoops>
                        </RelOp>
                      </Sort>
                    </RelOp>
                  </StreamAggregate>
                </RelOp>
              </ComputeScalar>
            </RelOp>
          </QueryPlan>
        </StmtSimple>
      </Statements>
    </Batch>
  </BatchSequence>
</ShowPlanXML>


--Cardinality 4 XML:
<?xml version="1.0" encoding="utf-16"?>
<ShowPlanXML xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" Version="1.5" Build="13.0.4001.0" xmlns="http://schemas.microsoft.com/sqlserver/2004/07/showplan">
  <BatchSequence>
    <Batch>
      <Statements>
        <StmtSimple StatementCompId="1" StatementEstRows="100" StatementId="1" StatementOptmLevel="FULL" StatementOptmEarlyAbortReason="TimeOut" CardinalityEstimationModelVersion="130" StatementSubTreeCost="0.627735" StatementText="select count(T1.a) from T1 join T2 on T1.a = T2.a join T3 on T1.a =T3.a&#xD;&#xA;where T2.c&gt; 500&#xD;&#xA;group by T1.b order by T1.b" StatementType="SELECT" QueryHash="0xD64741D348AF8189" QueryPlanHash="0x7CAB12FFDB4C8D25" RetrievedFromCache="false" SecurityPolicyApplied="false">
          <StatementSetOptions ANSI_NULLS="true" ANSI_PADDING="true" ANSI_WARNINGS="true" ARITHABORT="true" CONCAT_NULL_YIELDS_NULL="true" NUMERIC_ROUNDABORT="false" QUOTED_IDENTIFIER="true" />
          <QueryPlan NonParallelPlanReason="NoParallelPlansInDesktopOrExpressEdition" CachedPlanSize="72" CompileTime="89" CompileCPU="87" CompileMemory="416">
            <MissingIndexes>
              <MissingIndexGroup Impact="14.0661">
                <MissingIndex Database="[Project_Part2]" Schema="[dbo]" Table="[T2]">
                  <ColumnGroup Usage="INEQUALITY">
                    <Column Name="[c]" ColumnId="3" />
                  </ColumnGroup>
                  <ColumnGroup Usage="INCLUDE">
                    <Column Name="[a]" ColumnId="1" />
                  </ColumnGroup>
                </MissingIndex>
              </MissingIndexGroup>
            </MissingIndexes>
            <MemoryGrantInfo SerialRequiredMemory="2048" SerialDesiredMemory="4192" />
            <OptimizerHardwareDependentProperties EstimatedAvailableMemoryGrant="207707" EstimatedPagesCached="51926" EstimatedAvailableDegreeOfParallelism="2" MaxCompileMemory="719480" />
            <TraceFlags IsCompileTime="true">
              <TraceFlag Value="8017" Scope="Global" />
            </TraceFlags>
            <RelOp AvgRowSize="15" EstimateCPU="0.00113646" EstimateIO="0.0112613" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="100" LogicalOp="Sort" NodeId="0" Parallel="false" PhysicalOp="Sort" EstimatedTotalSubtreeCost="0.627735">
              <OutputList>
                <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                <ColumnReference Column="Expr1007" />
              </OutputList>
              <MemoryFractions Input="0.666667" Output="1" />
              <Sort Distinct="false">
                <OrderBy>
                  <OrderByColumn Ascending="true">
                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                  </OrderByColumn>
                </OrderBy>
                <RelOp AvgRowSize="15" EstimateCPU="0" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="100" LogicalOp="Compute Scalar" NodeId="1" Parallel="false" PhysicalOp="Compute Scalar" EstimatedTotalSubtreeCost="0.615338">
                  <OutputList>
                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                    <ColumnReference Column="Expr1007" />
                  </OutputList>
                  <ComputeScalar>
                    <DefinedValues>
                      <DefinedValue>
                        <ColumnReference Column="Expr1007" />
                        <ScalarOperator ScalarString="CONVERT_IMPLICIT(int,[Expr1010],0)">
                          <Convert DataType="int" Style="0" Implicit="true">
                            <ScalarOperator>
                              <Identifier>
                                <ColumnReference Column="Expr1010" />
                              </Identifier>
                            </ScalarOperator>
                          </Convert>
                        </ScalarOperator>
                      </DefinedValue>
                    </DefinedValues>
                    <RelOp AvgRowSize="15" EstimateCPU="0.0657415" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="100" LogicalOp="Aggregate" NodeId="2" Parallel="false" PhysicalOp="Hash Match" EstimatedTotalSubtreeCost="0.615338">
                      <OutputList>
                        <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                        <ColumnReference Column="Expr1010" />
                      </OutputList>
                      <MemoryFractions Input="0.00746269" Output="0.333333" />
                      <Hash>
                        <DefinedValues>
                          <DefinedValue>
                            <ColumnReference Column="Expr1010" />
                            <ScalarOperator ScalarString="COUNT(*)">
                              <Aggregate AggType="COUNT*" Distinct="false" />
                            </ScalarOperator>
                          </DefinedValue>
                        </DefinedValues>
                        <HashKeysBuild>
                          <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                        </HashKeysBuild>
                        <BuildResidual>
                          <ScalarOperator ScalarString="[Project_Part2].[dbo].[T1].[b] = [Project_Part2].[dbo].[T1].[b]">
                            <Compare CompareOp="IS">
                              <ScalarOperator>
                                <Identifier>
                                  <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                                </Identifier>
                              </ScalarOperator>
                              <ScalarOperator>
                                <Identifier>
                                  <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                                </Identifier>
                              </ScalarOperator>
                            </Compare>
                          </ScalarOperator>
                        </BuildResidual>
                        <RelOp AvgRowSize="11" EstimateCPU="0.240977" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="6960.96" LogicalOp="Inner Join" NodeId="3" Parallel="false" PhysicalOp="Hash Match" EstimatedTotalSubtreeCost="0.549596">
                          <OutputList>
                            <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                          </OutputList>
                          <MemoryFractions Input="0.522388" Output="0.992537" />
                          <Hash>
                            <DefinedValues />
                            <HashKeysBuild>
                              <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                            </HashKeysBuild>
                            <HashKeysProbe>
                              <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="a" />
                            </HashKeysProbe>
                            <RelOp AvgRowSize="15" EstimateCPU="0.137112" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="7000" LogicalOp="Inner Join" NodeId="4" Parallel="false" PhysicalOp="Hash Match" EstimatedTotalSubtreeCost="0.200898">
                              <OutputList>
                                <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                                <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                              </OutputList>
                              <MemoryFractions Input="1" Output="0.477612" />
                              <Hash>
                                <DefinedValues />
                                <HashKeysBuild>
                                  <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                                </HashKeysBuild>
                                <HashKeysProbe>
                                  <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="a" />
                                </HashKeysProbe>
                                <RelOp AvgRowSize="11" EstimateCPU="0.007857" EstimateIO="0.023125" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="7000" EstimatedRowsRead="7000" LogicalOp="Table Scan" NodeId="5" Parallel="false" PhysicalOp="Table Scan" EstimatedTotalSubtreeCost="0.030982" TableCardinality="7000">
                                  <OutputList>
                                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                                  </OutputList>
                                  <TableScan Ordered="false" ForcedIndex="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                                    <DefinedValues>
                                      <DefinedValue>
                                        <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                                      </DefinedValue>
                                    </DefinedValues>
                                    <Object Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" IndexKind="Heap" Storage="RowStore" />
                                  </TableScan>
                                </RelOp>
                                <RelOp AvgRowSize="15" EstimateCPU="0.011157" EstimateIO="0.0216435" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="10000" EstimatedRowsRead="10000" LogicalOp="Clustered Index Scan" NodeId="6" Parallel="false" PhysicalOp="Clustered Index Scan" EstimatedTotalSubtreeCost="0.0328005" TableCardinality="10000">
                                  <OutputList>
                                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="a" />
                                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                                  </OutputList>
                                  <IndexScan Ordered="false" ForcedIndex="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                                    <DefinedValues>
                                      <DefinedValue>
                                        <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="a" />
                                      </DefinedValue>
                                      <DefinedValue>
                                        <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                                      </DefinedValue>
                                    </DefinedValues>
                                    <Object Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Index="[PK__T1__3BD0198E1B81B621]" IndexKind="Clustered" Storage="RowStore" />
                                  </IndexScan>
                                </RelOp>
                              </Hash>
                            </RelOp>
                            <RelOp AvgRowSize="15" EstimateCPU="0.033157" EstimateIO="0.060162" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="29832.7" EstimatedRowsRead="30000" LogicalOp="Clustered Index Scan" NodeId="7" Parallel="false" PhysicalOp="Clustered Index Scan" EstimatedTotalSubtreeCost="0.093319" TableCardinality="30000">
                              <OutputList>
                                <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="a" />
                              </OutputList>
                              <IndexScan Ordered="false" ForcedIndex="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                                <DefinedValues>
                                  <DefinedValue>
                                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="a" />
                                  </DefinedValue>
                                </DefinedValues>
                                <Object Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Index="[PK__T2__3BD0198EB53F5045]" IndexKind="Clustered" Storage="RowStore" />
                                <Predicate>
                                  <ScalarOperator ScalarString="[Project_Part2].[dbo].[T2].[c]&gt;(500)">
                                    <Compare CompareOp="GT">
                                      <ScalarOperator>
                                        <Identifier>
                                          <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="c" />
                                        </Identifier>
                                      </ScalarOperator>
                                      <ScalarOperator>
                                        <Const ConstValue="(500)" />
                                      </ScalarOperator>
                                    </Compare>
                                  </ScalarOperator>
                                </Predicate>
                              </IndexScan>
                            </RelOp>
                          </Hash>
                        </RelOp>
                      </Hash>
                    </RelOp>
                  </ComputeScalar>
                </RelOp>
              </Sort>
            </RelOp>
          </QueryPlan>
        </StmtSimple>
      </Statements>
    </Batch>
  </BatchSequence>
</ShowPlanXML>

--Cardinality 5 XML:

<?xml version="1.0" encoding="utf-16"?>
<ShowPlanXML xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" Version="1.5" Build="13.0.4001.0" xmlns="http://schemas.microsoft.com/sqlserver/2004/07/showplan">
  <BatchSequence>
    <Batch>
      <Statements>
        <StmtSimple StatementCompId="1" StatementEstRows="100" StatementId="1" StatementOptmLevel="FULL" CardinalityEstimationModelVersion="130" StatementSubTreeCost="1.01705" StatementText="select count(T1.a) from T1 join T2 on T1.a = T2.a join T3 on T1.a =T3.a&#xD;&#xA;where T2.c&gt; 500&#xD;&#xA;group by T1.b order by T1.b" StatementType="SELECT" QueryHash="0xD64741D348AF8189" QueryPlanHash="0x294717A1BA3A8B17" RetrievedFromCache="false" SecurityPolicyApplied="false">
          <StatementSetOptions ANSI_NULLS="true" ANSI_PADDING="true" ANSI_WARNINGS="true" ARITHABORT="true" CONCAT_NULL_YIELDS_NULL="true" NUMERIC_ROUNDABORT="false" QUOTED_IDENTIFIER="true" />
          <QueryPlan NonParallelPlanReason="NoParallelPlansInDesktopOrExpressEdition" CachedPlanSize="56" CompileTime="1000" CompileCPU="78" CompileMemory="456">
            <MissingIndexes>
              <MissingIndexGroup Impact="8.68176">
                <MissingIndex Database="[Project_Part2]" Schema="[dbo]" Table="[T2]">
                  <ColumnGroup Usage="INEQUALITY">
                    <Column Name="[c]" ColumnId="3" />
                  </ColumnGroup>
                  <ColumnGroup Usage="INCLUDE">
                    <Column Name="[a]" ColumnId="1" />
                  </ColumnGroup>
                </MissingIndex>
              </MissingIndexGroup>
              <MissingIndexGroup Impact="67.2883">
                <MissingIndex Database="[Project_Part2]" Schema="[dbo]" Table="[T3]">
                  <ColumnGroup Usage="EQUALITY">
                    <Column Name="[a]" ColumnId="1" />
                  </ColumnGroup>
                </MissingIndex>
              </MissingIndexGroup>
            </MissingIndexes>
            <MemoryGrantInfo SerialRequiredMemory="2048" SerialDesiredMemory="4080" />
            <OptimizerHardwareDependentProperties EstimatedAvailableMemoryGrant="207707" EstimatedPagesCached="51926" EstimatedAvailableDegreeOfParallelism="2" MaxCompileMemory="49824" />
            <TraceFlags IsCompileTime="true">
              <TraceFlag Value="8017" Scope="Global" />
            </TraceFlags>
            <RelOp AvgRowSize="15" EstimateCPU="0.00113646" EstimateIO="0.0112613" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="100" LogicalOp="Sort" NodeId="0" Parallel="false" PhysicalOp="Sort" EstimatedTotalSubtreeCost="1.01705">
              <OutputList>
                <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                <ColumnReference Column="Expr1007" />
              </OutputList>
              <MemoryFractions Input="0.666667" Output="1" />
              <Sort Distinct="false">
                <OrderBy>
                  <OrderByColumn Ascending="true">
                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                  </OrderByColumn>
                </OrderBy>
                <RelOp AvgRowSize="15" EstimateCPU="0" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="100" LogicalOp="Compute Scalar" NodeId="1" Parallel="false" PhysicalOp="Compute Scalar" EstimatedTotalSubtreeCost="1.00465">
                  <OutputList>
                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                    <ColumnReference Column="Expr1007" />
                  </OutputList>
                  <ComputeScalar>
                    <DefinedValues>
                      <DefinedValue>
                        <ColumnReference Column="Expr1007" />
                        <ScalarOperator ScalarString="CONVERT_IMPLICIT(int,[Expr1010],0)">
                          <Convert DataType="int" Style="0" Implicit="true">
                            <ScalarOperator>
                              <Identifier>
                                <ColumnReference Column="Expr1010" />
                              </Identifier>
                            </ScalarOperator>
                          </Convert>
                        </ScalarOperator>
                      </DefinedValue>
                    </DefinedValues>
                    <RelOp AvgRowSize="15" EstimateCPU="0.0856655" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="100" LogicalOp="Aggregate" NodeId="2" Parallel="false" PhysicalOp="Hash Match" EstimatedTotalSubtreeCost="1.00465">
                      <OutputList>
                        <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                        <ColumnReference Column="Expr1010" />
                      </OutputList>
                      <MemoryFractions Input="0.00787402" Output="0.333333" />
                      <Hash>
                        <DefinedValues>
                          <DefinedValue>
                            <ColumnReference Column="Expr1010" />
                            <ScalarOperator ScalarString="COUNT(*)">
                              <Aggregate AggType="COUNT*" Distinct="false" />
                            </ScalarOperator>
                          </DefinedValue>
                        </DefinedValues>
                        <HashKeysBuild>
                          <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                        </HashKeysBuild>
                        <BuildResidual>
                          <ScalarOperator ScalarString="[Project_Part2].[dbo].[T1].[b] = [Project_Part2].[dbo].[T1].[b]">
                            <Compare CompareOp="IS">
                              <ScalarOperator>
                                <Identifier>
                                  <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                                </Identifier>
                              </ScalarOperator>
                              <ScalarOperator>
                                <Identifier>
                                  <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                                </Identifier>
                              </ScalarOperator>
                            </Compare>
                          </ScalarOperator>
                        </BuildResidual>
                        <RelOp AvgRowSize="11" EstimateCPU="0.461269" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="9944.22" LogicalOp="Inner Join" NodeId="3" Parallel="false" PhysicalOp="Hash Match" EstimatedTotalSubtreeCost="0.918986">
                          <OutputList>
                            <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                          </OutputList>
                          <MemoryFractions Input="1" Output="0.992126" />
                          <Hash>
                            <DefinedValues />
                            <HashKeysBuild>
                              <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="a" />
                            </HashKeysBuild>
                            <HashKeysProbe>
                              <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                            </HashKeysProbe>
                            <RelOp AvgRowSize="15" EstimateCPU="0.090243" EstimateIO="0" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="9944.22" LogicalOp="Inner Join" NodeId="4" Parallel="false" PhysicalOp="Merge Join" EstimatedTotalSubtreeCost="0.230766">
                              <OutputList>
                                <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                                <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="a" />
                              </OutputList>
                              <Merge ManyToMany="false">
                                <InnerSideJoinColumns>
                                  <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="a" />
                                </InnerSideJoinColumns>
                                <OuterSideJoinColumns>
                                  <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="a" />
                                </OuterSideJoinColumns>
                                <Residual>
                                  <ScalarOperator ScalarString="[Project_Part2].[dbo].[T2].[a]=[Project_Part2].[dbo].[T1].[a]">
                                    <Compare CompareOp="EQ">
                                      <ScalarOperator>
                                        <Identifier>
                                          <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="a" />
                                        </Identifier>
                                      </ScalarOperator>
                                      <ScalarOperator>
                                        <Identifier>
                                          <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="a" />
                                        </Identifier>
                                      </ScalarOperator>
                                    </Compare>
                                  </ScalarOperator>
                                </Residual>
                                <RelOp AvgRowSize="15" EstimateCPU="0.033157" EstimateIO="0.060162" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="29832.7" EstimatedRowsRead="30000" LogicalOp="Clustered Index Scan" NodeId="5" Parallel="false" PhysicalOp="Clustered Index Scan" EstimatedTotalSubtreeCost="0.093319" TableCardinality="30000">
                                  <OutputList>
                                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="a" />
                                  </OutputList>
                                  <IndexScan Ordered="true" ScanDirection="FORWARD" ForcedIndex="false" ForceSeek="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                                    <DefinedValues>
                                      <DefinedValue>
                                        <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="a" />
                                      </DefinedValue>
                                    </DefinedValues>
                                    <Object Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Index="[PK__T2__3BD0198EB53F5045]" IndexKind="Clustered" Storage="RowStore" />
                                    <Predicate>
                                      <ScalarOperator ScalarString="[Project_Part2].[dbo].[T2].[c]&gt;(500)">
                                        <Compare CompareOp="GT">
                                          <ScalarOperator>
                                            <Identifier>
                                              <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T2]" Column="c" />
                                            </Identifier>
                                          </ScalarOperator>
                                          <ScalarOperator>
                                            <Const ConstValue="(500)" />
                                          </ScalarOperator>
                                        </Compare>
                                      </ScalarOperator>
                                    </Predicate>
                                  </IndexScan>
                                </RelOp>
                                <RelOp AvgRowSize="15" EstimateCPU="0.011157" EstimateIO="0.0216435" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="10000" EstimatedRowsRead="10000" LogicalOp="Clustered Index Scan" NodeId="6" Parallel="false" PhysicalOp="Clustered Index Scan" EstimatedTotalSubtreeCost="0.0328005" TableCardinality="10000">
                                  <OutputList>
                                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="a" />
                                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                                  </OutputList>
                                  <IndexScan Ordered="true" ScanDirection="FORWARD" ForcedIndex="false" ForceSeek="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                                    <DefinedValues>
                                      <DefinedValue>
                                        <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="a" />
                                      </DefinedValue>
                                      <DefinedValue>
                                        <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Column="b" />
                                      </DefinedValue>
                                    </DefinedValues>
                                    <Object Database="[Project_Part2]" Schema="[dbo]" Table="[T1]" Index="[PK__T1__3BD0198E1B81B621]" IndexKind="Clustered" Storage="RowStore" />
                                  </IndexScan>
                                </RelOp>
                              </Merge>
                            </RelOp>
                            <RelOp AvgRowSize="11" EstimateCPU="0.077157" EstimateIO="0.149792" EstimateRebinds="0" EstimateRewinds="0" EstimatedExecutionMode="Row" EstimateRows="70000" EstimatedRowsRead="70000" LogicalOp="Table Scan" NodeId="7" Parallel="false" PhysicalOp="Table Scan" EstimatedTotalSubtreeCost="0.226949" TableCardinality="70000">
                              <OutputList>
                                <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                              </OutputList>
                              <TableScan Ordered="false" ForcedIndex="false" ForceScan="false" NoExpandHint="false" Storage="RowStore">
                                <DefinedValues>
                                  <DefinedValue>
                                    <ColumnReference Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" Column="a" />
                                  </DefinedValue>
                                </DefinedValues>
                                <Object Database="[Project_Part2]" Schema="[dbo]" Table="[T3]" IndexKind="Heap" Storage="RowStore" />
                              </TableScan>
                            </RelOp>
                          </Hash>
                        </RelOp>
                      </Hash>
                    </RelOp>
                  </ComputeScalar>
                </RelOp>
              </Sort>
            </RelOp>
          </QueryPlan>
        </StmtSimple>
      </Statements>
    </Batch>
  </BatchSequence>
</ShowPlanXML>