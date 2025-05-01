
import {execSync} from 'child_process';

export const runAwsClicCommand = (command) =>{
  try {
    const result = execSync(`aws ${command}`, {encoding: 'utf-8'});
    return result.toString();
  } catch (error) {
    console.error('Error executing command:', error);
    throw error;
  }
}

export const runNpmScript = (script) => {
  try {
    const result = execSync(`npm run ${script}`, {encoding: 'utf-8'});
    return result.toString();
  } catch (error) {
    console.error('Error executing command:', error);
    throw error;
  }
}