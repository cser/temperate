package temperate.layouts.helpers;
import temperate.core.CMath;

class CLayoutAlgoritms 
{
	/**
	 * Works better than HBox/VBox layout in Flex 2.0
	
	<!-- Damage flex HBox layout -->
	<mx:HBox width="100%" horizontalGap="0">
		<mx:Button label="0" width="100%" maxWidth="100" />
		<mx:Button label="1" width="10%" minWidth="100" />
		<mx:Button label="2" width="100%" />
		<mx:Button label="3" width="10%" />
	</mx:HBox>
	
	*/
	public static function distributeProportionally(
		sumSize:Float, sumPortion:Float, infos:Array<CSizeInfo>)
	{
		if (infos.length == 0)
		{
			return CMath.max(sumSize, 0);
		}
		while (true)
		{
			var portionK = sumSize / sumPortion;
			
			var sumMax = 0.;
			var sumMin = 0.;
			
			var minimizedInfo = null;
			var maximizedInfo = null;
			var intermediateInfo = null;
			
			var sumIntermediate = 0.;
			var sumMinimized = 0.;
			var sumMaximized = 0.;
			
			var sumMinimizedPortion = 0.;
			var sumMaximizedPortion = 0.;
			var sumIntermediatePortion = 0.;
			
			for (info in infos)
			{	
				var prefSize = info.portion * portionK;
				if (prefSize < info.min)
				{
					sumMinimized += info.min;
					sumMinimizedPortion += info.portion;
					
					info.size = info.min;
					if (minimizedInfo == null)
					{
						minimizedInfo = [info];
					}
					else
					{
						minimizedInfo.push(info);
					}
				}
				else if (prefSize > info.max)
				{
					sumMaximized += info.max;
					sumMaximizedPortion += info.portion;
					
					info.size = info.max;
					if (maximizedInfo == null)
					{
						maximizedInfo = [info];
					}
					else
					{
						maximizedInfo.push(info);
					}
				}
				else
				{
					sumIntermediate += prefSize;
					sumIntermediatePortion += info.portion;
					
					info.size = prefSize;
					if (intermediateInfo == null)
					{
						intermediateInfo = [info];
					}
					else
					{
						intermediateInfo.push(info);
					}
				}
				sumMax += info.max;
				sumMin += info.min;
			}
			
			if (minimizedInfo == null && maximizedInfo == null)
			{
				break;
			}
			
			if (sumSize > sumMax)
			{
				if (intermediateInfo != null)
				{
					for (info in intermediateInfo)
					{
						info.size = info.max;
					}
				}
				if (minimizedInfo != null)
				{
					for (info in minimizedInfo)
					{
						info.size = info.max;
					}
				}
				return sumSize - sumMax;
			}
			else if (sumSize < sumMin)
			{
				if (intermediateInfo != null)
				{
					for (info in intermediateInfo)
					{
						info.size = info.min;
					}
				}
				if (maximizedInfo != null)
				{
					for (info in maximizedInfo)
					{
						info.size = info.min;
					}
				}
				return 0.;
			}
			
			if (sumMinimized + sumMaximized + sumIntermediate < sumSize)
			{
				var subInfos = if (intermediateInfo == null)
				{
					minimizedInfo;
				}
				else if (minimizedInfo == null)
				{
					intermediateInfo;
				}
				else
				{
					intermediateInfo.concat(minimizedInfo);
				}
				
				if (subInfos == null)
				{
					break;
				}
				
				if (subInfos.length > 1)
				{
					if (maximizedInfo == null)
					{
						// protection for fluctuations
						break;
					}
					sumSize -= sumMaximized;
					sumPortion = sumIntermediatePortion + sumMinimizedPortion;
					infos = subInfos;
					continue;
				}
				else if (subInfos.length == 1)
				{
					subInfos[0].size = sumSize - sumMaximized;
				}
			}
			else
			{
				var subInfos = if (intermediateInfo == null)
				{
					maximizedInfo;
				}
				else if (maximizedInfo == null)
				{
					intermediateInfo;
				}
				else
				{
					intermediateInfo.concat(maximizedInfo);
				}
				
				if (subInfos == null)
				{
					break;
				}
				
				if (subInfos.length > 1)
				{
					if (minimizedInfo == null)
					{
						// protection for fluctuations
						break;
					}
					sumSize -= sumMinimized;
					sumPortion = sumIntermediatePortion + sumMaximizedPortion;
					infos = subInfos;
					continue;
				}
				else if (subInfos.length == 1)
				{
					subInfos[0].size = sumSize - sumMinimized;
				}
			}
			break;
		}
		return 0.;
	}
}