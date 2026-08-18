package prac;
import java.util.*;


//[PCCE 기출문제] 1번 / 문자 출력
//[PCCE 기출문제] 2번 / 각도 합치기

public class Day03 {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int angle1 = sc.nextInt();
		int angle2 = sc.nextInt();
		
		int sum_angle = angle1 + angle2;
		System.out.println(sum_angle % 360);
	}

} 



//[PCCE 기출문제] 3번 / 수 나누기

public class Day03 {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
        int number = sc.nextInt();
        int answer = 0;
        
        for(int i=0; number>0; i++) {
            answer += number % 100;
            number /= 100;
        }
        
        System.out.println(answer);
	}

} 



//[PCCE 기출문제] 4번 / 병과분류

public class Day03 {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String code = sc.next();
		String lastFourWords = 
				code.substring(code.length()-4, code.length());
		//substring( ) 메소드는 주어진 인덱스에서 문자열을 추출
		
		if(lastFourWords.equals("_eye")) {
			System.out.println("Ophthalmologyc");
		}
	}

} 



//[PCCE 기출문제] 1번 / 출력
//[PCCE 기출문제] 5번 / 산책
//[PCCE 기출문제] 8번 / 창고 정리

public class Day03 {

	public static String main(String[] storage, int[] num) {
		int num_item = 0;	//중복 없는 물건의 종류 수를 세는 변수
		String[] clean_storage = new String[storage.length];
        int[] clean_num = new int[num.length];
        
        for(int i=0; i<storage.length; i++) {
        	int clean_idx = -1;	//물건이 clean_storage에 등록되어 있는지
            for(int j=0; j<num_item; j++) {
            	if(storage[i].equals(clean_storage[j])) {
            		//현재 물건 이름이 이미 정리 목록에 존재하는지 비교
            		clean_idx = j;
                    break;	//더 이상 남아있는 반복문을 돌지 않음
            	}
            }
            if(clean_idx == -1) {	//새로운 물건
            	clean_storage[num_item] = storage[i];
                clean_num[num_item] = num[i];
                num_item += 1;
            }
            else {
            	clean_num[clean_idx] += num[i];
            }
        }
        
        int num_max = -1;
        String answer = "";
        for(int i=0; i<num_item; i++) {
            if(clean_num[i] > num_max) {
                num_max = clean_num[i];
                answer = clean_storage[i];
            }
        }
        return answer;
	}

} 



//문자열 출력하기
//코드 처리하기

public class Day03 {

	public static String main(String code) {
		String answer = "";
        int mode = 0;
        
        for(int i=0; i<code.length(); i++) {
        	if(code.charAt(i)=='1') {
        		mode = (mode + 1) % 2;
        		continue;	//즉시 다음 순서(다음 반복)로 넘어간다
        	}
        	if((mode==0 && i%2==0) || (mode==1 && i%2==1))
        		answer += code.charAt(i);
        }
        if(answer.equals(""))
        	answer = "EMPTY";
        return answer;
        //StringBuilder answer = new StringBuilder();
	}

} 



//주사위 게임 3

public class Day03 {

	public static int main(int a, int b, int c, int d) {
		int answer = 0;
		int[] dice = {a, b, c, d};
		Arrays.sort(dice);	//오름차순으로 정렬(알고리즘의 핵심)
		
		if(dice[0]==dice[3]) {
			//네 주사위 숫자가 모두 같은 경우
			answer = 1111 * dice[3];
		}
		else if(dice[0]==dice[2] || dice[1]==dice[3]) {
			//세 주사위가 같고 하나가 다른 경우
			answer = (int)Math.pow(
					dice[1] * 10 + dice[0] + dice[3] - dice[1], 2);
			//Math.pow(밑, 지수) 정수 결과를 얻으려면 형변환이 필요
			//3개가 같은 숫자 배열에서 dice[1]은 무조건 3개짜리 숫자
		}
		else if(dice[0]==dice[1] && dice[2]==dice[3]) {
			//두 개씩 같은 값이 나온 경우
			answer = (dice[3] + dice[0]) * (dice[3] - dice[0]);
		}
		else if(dice[0]==dice[1]) {
			//두 개가 같고, 나머지 두 개는 각각 다른 경우
			answer = dice[2] * dice[3];
		}
		else if(dice[1]==dice[2]) {
			//두 개가 같고, 나머지 두 개는 각각 다른 경우
			answer = dice[0] * dice[3];
		}
		else if(dice[2]==dice[3]) {
			//두 개가 같고, 나머지 두 개는 각각 다른 경우
			answer = dice[0] * dice[1];
		}
		else {
			answer = dice[0];
		}
		
        return answer;
	}

} 
