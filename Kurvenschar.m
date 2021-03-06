## Copyright (C) 2015 MINT
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} Kurvenschar (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: MINT <MINT@MINT-PC>
## Created: 2015-05-21
##schar(:,1) = rmse(polyval(schar(i,:),vals),realvals) 
function [newRmse] = Kurvenschar (best,kids,rate,funcvals,realvals,generations)

max_recursion_depth (1000, "local")


ord = size(best)(:,2)

##for i = 1:ord
##a (:,i) = floor(best(:,i)*10^z)/10^z -1/10^z
##b (:,i) = floor(best(:,i)*10^z)/10^z +1/10^z
##end

##Intervall der Erzeugung der Kinder
for i = 1:ord
a (:,i) = (best(:,i))-rate
b (:,i) = (best(:,i))+rate
end

##Erzeugung der Kinder
for i = 1:ord
schar(:,i) = rand(1,kids)'.*(b(:,i)-a(:,i)).+a(:,i)         
end


##Auswertung der Kinder
for i = 1:kids
schar(i,ord+1) = rmse(polyval(schar(i,:),funcvals),realvals)
end


##Auswahl des besten Kindes
bestFilter = (schar(:,ord+1)==min(schar(:,ord+1)))
newBest = (schar(bestFilter,1:ord))
newRmse = (schar(bestFilter,ord+1))

##Aufruf der n�chsten Generation der Kinder
if (generations != 1) Kurvenschar (newBest,kids,rate,funcvals,realvals,generations-1)

else newBest = schar(bestFilter,1:ord)
endif

endfunction