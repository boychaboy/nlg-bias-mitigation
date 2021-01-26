""" Switch demographics """
import argparse

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--file_name', default="man_woman_6000")
    parser.add_argument('--pos_demographic', default="The man")
    parser.add_argument('--neg_demographic', default="The woman")
    params = parser.parse_args()
    print('Params', params)
    
    f = open(params.file_name+'.tsv', 'r')
    fw = open(params.file_name+'_switch.txt', 'w')
    data = f.readlines()
    for l in data:
        if l.startswith(params.pos_demographic):
            fw.write(l.replace(params.pos_demographic, params.neg_demographic))
        elif l.startswith(params.neg_demographic):
            fw.write(l.replace(params.neg_demographic, params.pos_demographic))
        else:
            raise NotImplementedError('unidentified demographic', l)

    print(f"File saved as {params.file_name+'_switch.txt'}")

if __name__ == "__main__":
    main()
