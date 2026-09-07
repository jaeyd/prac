package prac;
import java.util.*;
import java.math.*;
import java.lang.*;


//==========코딩테스트 입문 Lv. 0==========

//Lv. 0 두 수의 나눗셈

public class Day02 {

	public int main(int num1, int num2) {
		int answer = 0;
		double cal = ((double)num1 / num2) * 1000;
		//정수 나눗셈 시 소수점이 버려지는 것을 방지
		answer = (int)cal;
		return answer;
	}

} 



//Lv. 0 숫자 비교하기

public class Day02 {

	public int main(int num1, int num2) {
		//삼항 연산자(? :)는 문장(Statement)이 아니라 값을 반환
		//삼항 연산자를 answer 변수에 대입하거나, return문에 직접 사용
		int answer = (num1 == num2) ? 1 : -1;
		return answer;
	}

} 



//Lv. 0 분수의 덧셈

public class Day02 {

	//유클리드 호제법을 이용한 최대공약수(GCD) 구하기 메서드
	public int gcd(int a, int b) {
		while(b != 0) {
			int r = a % b;
			a = b;
			b = r;
		}
		return a;
	}
	public int[] main(int numer1, int denom1, 
			int numer2, int denom2) {
		int num = numer1 * denom2 + numer2 * denom1;
		int den = denom1 * denom2;
		
		int gcdVal = gcd(num, den);
		num = num / gcdVal;
		den = den / gcdVal;
		
		int[] answer = {num, den};
		return answer;
	}

} 



//Lv. 0 중앙값 구하기

public class Day02 {

	public int main(int[] array) {
		Arrays.sort(array);
		return array[array.length / 2];
	}

} 



//Lv. 0 최빈값 구하기

public class Day02 {

	public int main(int[] array) {
		//원소의 범위가 0 ~ 999일 때 각 숫자의 등장 횟수를 카운트
		int[] count = new int[1000];
		
		//각 숫자의 빈도수 세기
		for(int i=0; i<array.length; i++) {			
			int num = array[i];
			count[num]++;
		}
		int max = 0;
		int val = 0;
		
		for(int i=0; i<count.length; i++) {
			if(count[i] > max) {
				max = count[i];
				val = i;
			}
			else if(count[i]==max && max>0) {
				val = -1;
			}
		}
		return val;
	}

} 



//Lv. 0 짝수는 싫어요

public class Day02 {

	public int[] main(int n) {
		//n이 5면 (5+1)/2 = 3개, n이 6이면 (6+1)/2 = 3개
		int[] answer = new int[(n + 1) / 2];
		int idx = 0;	//answer 배열에 값을 넣을 인덱스
		
		for(int i=1; i<=n; i+=2) {
			answer[idx] = i;
			idx++;
		}
		return answer;
	}

} 



//Lv. 0 특정 문자 제거하기

public class Day02 {

	public String main(String my_string, String letter) {
		String answer = my_string.replace(letter, "");
		return answer;
	}

} 



//Lv. 0 진료 순서 정하기

public class Day02 {

	public int[] main(int[] emergency) {
		int[] answer = new int[emergency.length];
		int[] srt = emergency.clone();
		Arrays.sort(srt);
		
		for(int i=0; i<emergency.length; i++) {
			for(int j=0; j<srt.length; j++) {
				if(emergency[i] == srt[j]) {
					answer[i] = srt.length - j;
					break;
				}
			}
		}
		return answer;
	}

} 



//Lv. 0 구슬을 나누는 경우의 수

public class Day02 {

	public int main(int balls, int share) {
		BigInteger num1 = BigInteger.ONE;
		BigInteger num2 = BigInteger.ONE;
		BigInteger num3 = BigInteger.ONE;
		
		for(int i=balls; i>=1; i--)
			num1 = num1.multiply(BigInteger.valueOf(i));
		for(int i=(balls-share); i>=1; i--)
			num2 = num2.multiply(BigInteger.valueOf(i));
		for(int i=share; i>=1; i--)
			num3 = num3.multiply(BigInteger.valueOf(i));
		BigInteger answer = num1.divide(num2.multiply(num3));
		return answer.intValue();
	}

} 



//Lv. 0 배열 회전시키기

public class Day02 {

	public int[] main(int[] numbers, String direction) {
		int len = numbers.length;
		int[] answer = new int[len];
		
		for(int i=0; i<len; i++) {
			if(direction.equals("right"))
				answer[(i+1) % len] = numbers[i];
			else
				answer[i] = numbers[(i+1) % len];
		}
		return answer;
	}

} 



//Lv. 0 숨어있는 숫자의 덧셈 (1)

public class Day02 {

	public int main(String my_string) {
		int answer = 0;
		String str = my_string.replaceAll("[^0-9]", "");
		for (int i=0; i<str.length(); i++) {
			char res = str.charAt(i);
			answer += res - '0';
		}
		return answer;
	}

} 



//Lv. 0 소인수분해

public class Day02 {

	public int[] main(int n) {
		List<Integer> list = new ArrayList<>();
		int m = n;
		
		for(int i=2; i<=n; i++) {
			if(m%i == 0) {
				list.add(i);
				while(m%i == 0)
					m = m/i;
			}
		}
		int[] answer = new int[list.size()];
		for(int i=0; i<list.size(); i++)
			answer[i] = list.get(i);
		return answer;
	}

} 



//Lv. 0 대문자와 소문자

public class Day02 {

	public String main(String my_string) {
		StringBuilder sb = new StringBuilder();
		String answer = "";
		
		for(int i=0; i<my_string.length(); i++) {
			char ch = my_string.charAt(i);
			if(Character.isUpperCase(ch)) {
				sb.append(Character.toLowerCase(ch));
			}
			else {
				sb.append(Character.toUpperCase(ch));
			}
		}
		answer = sb.toString();
        return answer;
	}

} 



//Lv. 0 인덱스 바꾸기

public class Day02 {

	public String main(String my_string, int num1, int num2) {
		char[] arr = my_string.toCharArray();
		
		char tmp = arr[num1];
		arr[num1] = arr[num2];
		arr[num2] = tmp;
		
		return String.valueOf(arr);
	}

}

public class Day02 {

	public String main(String my_string, int num1, int num2) {
		StringBuilder sb = new StringBuilder(my_string);
		
		char ch1 = sb.charAt(num1);
		char ch2 = sb.charAt(num2);
		sb.setCharAt(num1, ch2);
		sb.setCharAt(num2, ch1);
		
		return sb.toString();
	}

} 



//Lv. 0 한 번만 등장한 문자

public class Day02 {

	public String main(String s) {
		StringBuilder answer = new StringBuilder();
		int arr[] = new int[26];
		
		for(int i=0; i<s.length(); i++) {
			arr[s.charAt(i) - 'a']++;
		}
		
		for(int i=0; i<26; i++) {
			if(arr[i]==1)
				answer.append((char)(i + 'a'));
		}
		return answer.toString();
	}

} 



//Lv. 0 약수 구하기

public class Day02 {

	public int[] main(int n) {
		List<Integer> list = new ArrayList<>();
		
		for(int i=1; i<=n; i++) {
			if(n%i == 0)
				list.add(i);
		}
		int[] answer = new int[list.size()];
		for(int i=0; i<list.size(); i++) {
			answer[i] = list.get(i);
		}
		return answer;
	}

} 



//Lv. 0 자릿수 더하기

public class Day02 {
	
	public static int cal(int n) {
		int answer = 0;
		
		while(n>0) {
			answer += n%10;
			n = n/10;
		}
		return answer;
	}

	public static void main(String[] args) {
		int n1 = 1234;
		int n2 = 930211;
		
		System.out.println(cal(n1));
		System.out.println(cal(n2));
	}

} 



//Lv. 0 문자열안에 문자열

public class Day02 {

	public int main(String str1, String str2) {
		return str1.contains(str2) ? 1 : 2;
	}

}

public class Day02 {

	public int main(String str1, String str2) {
		int len1 = str1.length();
		int len2 = str2.length();
		int answer = 2;
		
		if(len1 < len2) answer = 2;
		
		for(int i=0; i<=len1-len2; i++) {
			if(str1.substring(i, i+len2).equals(str2))
				answer = 1;
		}
		return answer;
	}

} 



//Lv. 0 제곱수 판별하기

public class Day02 {

	public int main(int n) {
		double sqrt = Math.sqrt(n);
		int answer = 0;
		
		if(n%sqrt == 0)
			answer = 1;
		else
			answer = 2;
		
		return answer;
	}

} 



//Lv. 0 직사각형 넓이 구하기

public class Day02 {

	public int main(int[][] dots) {
		int minX = dots[0][0];
		int maxX = dots[0][0];
		int minY = dots[0][1];
		int maxY = dots[0][1];
		
		for(int i=0; i<dots.length; i++) {
			minX = Math.min(minX, dots[i][0]);
			maxX = Math.max(maxX, dots[i][0]);
			minY = Math.min(minY, dots[i][1]);
			maxY = Math.max(maxY, dots[i][1]);
		}
		int answer = (maxX-minX) * (maxY-minY);
		return answer;
	}

} 



//Lv. 0 캐릭터의 좌표

public class Day02 {

	public int[] main(String[] keyinput, int[] board) {
		int mx = board[0] / 2;
		int my = board[1] / 2;
		int x = 0;
		int y = 0;
		
		for(String key : keyinput) {
			//keyinput 배열에서 값을 하나씩 꺼내 할당하며 반복 실행
			if(key.equals("up") && y<my) {
				y++;
			}
			else if(key.equals("down") && y>-my) {
				y--;
			}
			else if(key.equals("left") && x>-mx) {
				x--;
			}
			else if(key.equals("right") && x<mx) {
				x++;
			}
		}
		int[] answer = {x, y};
		return answer;
	}

} 



//Lv. 0 숨어있는 숫자의 덧셈 (2)

public class Day02 {

	public int main(String my_string) {
		int answer = 0;
		String arr[] = my_string.split("[^0-9]+");
		
		for(String s : arr) {
			if(!s.isEmpty())
				answer += Integer.parseInt(s);
				//문자열 형태의 숫자를 정수형 데이터로 변환
		}
		return answer;
	}

} 



//Lv. 0 안전지대

public class Day02 {

	public int main(int[][] board) {
		int n = board.length;
		int[][] danger = new int[n][n];
		//8방향(상, 하, 좌, 우, 대각선 4곳)을 탐색하기 위한 방향 벡터
		int[] dx = {-1, -1, -1, 0, 0, 1, 1, 1};
		int[] dy = {-1, 0, 1, -1, 1, -1, 0, 1};
		
		for(int i=0; i<n; i++) {
			for(int j=0; j<n; j++) {
				if(board[i][j]==1) {
					danger[i][j]=1;	//지뢰 자리 위험 지역 처리
					
					//8방향 탐색
					for(int d=0; d<8; d++) {
						int ni = i + dx[d];
						int nj = j + dy[d];
						
						//배열을 벗어나지 않는 경우에만 위험 지역으로 표시
						if(ni>=0 && ni <n && nj>=0 && nj<n)
							danger[ni][nj] = 1;
					}
				}
			}
		}
		
		int answer = 0;
		for(int i=0; i<n; i++) {
			for(int j=0; j<n; j++) {
				if(danger[i][j]==0)
					answer++;
			}
		}
		return answer;
	}

} 



//Lv. 0 삼각형의 완성조건 (2)

public class Day02 {

	public int main(int[] sides) {
		Arrays.sort(sides);
		int a = sides[0];
		int b = sides[1];
		List<Integer> list = new ArrayList<>();
		
		//b가 가장 긴 변인 경우: b<a+x, x>b-a, x<=b
		for(int i=b-a+1; i<=b; i++) {
			if(!list.contains(i))
				list.add(i);
		}
		//새로운 변(x)이 가장 긴 변인 경우: x<a+b, x>b
		for(int i=b+1; i<a+b; i++) {
			if(!list.contains(i))
				list.add(i);
		}
		int answer = list.size();
		return answer;
	}

} 



//Lv. 0 외계어 사전

public class Day02 {

	public int main(String[] spell, String[] dic) {
		int answer = 2;
		
		for(int i=0; i<dic.length; i++) {
			String str = dic[i];
			for(int j=0; j<spell.length; j++)
				str = str.replaceFirst(spell[j], "");
			if(str.isEmpty() && dic[i].length()==spell.length)
				answer = 1;
		}
		return answer;
	}

} 



//Lv. 0 저주의 숫자 3

public class Day02 {

	public int main(int n) {
		int answer = 0;
		
		for(int i=1; i<=n; i++) {
			answer++;
			while(answer%3==0 || 
					String.valueOf(answer).contains("3"))
				answer++;
			//if문이었다면 검사를 한 번만 하고 넘어가기 때문에 잘못된 결과
		}
		return answer;
	}

} 



//Lv. 0 평행

public class Day02 {

	public int main(int[][] dots) {
		int answer = 0;
		if(isParallel(dots[0], dots[1], dots[2], dots[3]))
			answer = 1;
		if(isParallel(dots[0], dots[2], dots[1], dots[3]))
			answer = 1;
		if(isParallel(dots[0], dots[3], dots[1], dots[2]))
			answer = 1;
		return answer;
	}
	
	//두 직선이 평행한지(기울기가 같은지) 판별하는 메서드
	private boolean isParallel(int[] p1, int[] p2, 
			int[] p3, int[] p4) {
		int dx1 = p2[0] - p1[0];
		int dy1 = p2[1] - p1[1];
		int dx2 = p4[0] - p3[0];
		int dy2 = p4[1] - p3[1];
		
		//소수점 오차 및 분모가 0인 경우를 방지하기 위해 교차 곱
		return dy1*dx2 == dy2*dx1;
	}

} 



//Lv. 0 겹치는 선분의 길이

public class Day02 {

	public int main(int[][] lines) {
		int[] cnt = new int[200];	//범위가 -100부터 100까지
		for(int i=0; i<3; i++) {
			int start = lines[i][0];
			int end = lines[i][1];
			
			//각 선분이 차지하는 구간을 순회하며 카운트 증가
			for(int j=start; j<end; j++)
				cnt[j+100]++;
		}
		int answer = 0;
		for(int c: cnt) {
			if(c>1)
				answer++;
		}
		return answer;
	}

} 



//Lv. 0 유한소수 판별하기

public class Day02 {

	public int main(int a, int b) {
		//분모를 기약분수의 분모로 만들기 위해 최대공약수로 나눔
		int gcd = getGcd(a, b);
		b = b/gcd;
		
		//소인수가 2와 5만 남도록 나누기
		while(b%2==0)
			b = b/2;
		while(b%5==0)
			b = b/5;
		//b가 1이 되면 유한소수(1), 아니면 무한소수(2)
		return b==1 ? 1 : 2;
	}
	
	//최대공약수를 구하는 유클리드 호제법 메서드
	private int getGcd(int x, int y) {
		if(y==0)
			return x;
		return getGcd(y, x%y);
		//A를 B로 나눈 나머지가 R이면, A와 B의 최대공약수 = B와 R의 최대공약수
	}

} 



//Lv. 0 특이한 정렬

public class Day02 {

	public int[] main(int[] numlist, int n) {
		//원시 타입 배열은 커스텀 정렬이 어려우므로 Integer 객체 배열로 변환
		Integer[] tmp = new Integer[numlist.length];
		for(int i=0; i<numlist.length; i++) {
			tmp[i] = numlist[i];
		}
		
		//배열을 정렬하기 위해 람다식 기반의 비교 함수(Comparator)를 시작
		Arrays.sort(tmp, (a, b) ->{
			int disA = Math.abs(a-n);
			int disB = Math.abs(b-n);
			//거리가 같다면 더 큰 숫자가 앞으로 오도록 정렬 (내림차순)
			if(disA==disB)
				return b - a;
			//거리가 가까운 순서대로 정렬 (오름차순)
			return disA - disB;
		});
		
		int[] answer = new int[numlist.length];
		for(int i=0; i<numlist.length; i++)
			answer[i] = tmp[i];
		return answer;
	}

} 



//Lv. 0 등수 매기기

public class Day02 {

	public int[] main(int[][] score) {
		int n = score.length;
		int[] answer = new int[n];
		double[] avg = new double[n];
		
		for(int i=0; i<n; i++)
			avg[i] = (score[i][0]+score[i][1]) / 2.0;
		
		for(int i=0; i<n; i++) {
			int rank = 1;
			for(int j=0; j<n; j++) {
				//자신보다 높은 점수를 가진 사람의 수만큼 1을 더하는 방식
				if(avg[i] < avg[j])
					rank++;
			}
			answer[i] = rank;
		}
		return answer;
	}

} 



//Lv. 0 치킨 쿠폰

public class Day02 {

	public int main(int chicken) {
		int answer = 0;
		
		while(chicken>=10) {
			int service = chicken/10;	//서비스 치킨 계산
			int remain = chicken%10;	//잔여 쿠폰 계산
			answer += service;
			chicken = service + remain;
			//새로 발급받은 쿠폰과 이전의 잔여 쿠폰을 합쳐
		}
		return answer;
	}

} 



//Lv. 0 이진수 더하기

public class Day02 {

	public String main(String bin1, String bin2) {
		int num1 = Integer.parseInt(bin1, 2);
		int num2 = Integer.parseInt(bin2, 2);
		int sum = num1 + num2;
		
		String answer = Integer.toBinaryString(sum);
		return answer;
	}

} 



//Lv. 0 k의 개수

public class Day02 {

	public int main(int i, int j, int k) {
		char val = (char)(k + '0');
		String str = "";
		int answer = 0;
		
		for(int n=i; n<=j; n++)
			str += n;
		for(int n=0; n<str.length(); n++) {
			if(val == str.charAt(n))
				answer++;
		}
		return answer;
	}

} 



//Lv. 0 문자열 밀기

public class Day02 {

	public int main(String A, String B) {
		if(A.equals(B))
			return 0;
		
		int len = A.length();
		String cur = A;
		int answer = 0;
		
		for(int i=1; i<=len; i++) {
			//문자열을 오른쪽으로 한 칸씩 밀어보는 for 루프
			char arr[] = new char[len];
			for(int j=0; j<len; j++) {
				//문자열을 순회하며 위치를 옮겨 담기 위한 루프
				arr[(j+1)%len] = cur.charAt(j);
			}
			cur = String.valueOf(arr);
			if(cur.equals(B)) {
				answer = i;
				return answer;
			}
		}
		return -1;
	}

} 



//Lv. 0 연속된 수의 합

public class Day02 {

	public int[] main(int num, int total) {
		int[] answer = new int[num];
		//연속된 수의 시작 값을 구하는 공식
		int start = (total/num) - (num-1)/2;
		
		for(int i=0; i<num; i++)
			answer[i] = start + i;
		return answer;
	}

} 
