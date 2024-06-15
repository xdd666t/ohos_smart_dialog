import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';
import { OhosSmartDialog } from 'ohos_smart_dialog';

export default class EntryAbility extends UIAbility {
  static tag = "EntryAbility.Tag"

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    console.info(`${EntryAbility.tag}: onCreate`)
  }

  onDestroy(): void {
    console.info(`${EntryAbility.tag}: onDestroy`)
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    console.info(`${EntryAbility.tag}: onWindowStageCreate`)

    windowStage.loadContent('Index', (err) => {
      if (err.code) {
        console.info(`${EntryAbility.tag}: error: ${JSON.stringify(err) ?? ''}}`)
        return;
      }
      console.info(`${EntryAbility.tag}: onWindowStageCreate: success`)
    });
  }

  onWindowStageDestroy(): void {
    console.info(`${EntryAbility.tag}: onWindowStageDestroy`)
  }

  onForeground(): void {
    console.info(`${EntryAbility.tag}: onForeground`)
  }

  onBackground(): void {
    console.info(`${EntryAbility.tag}: onBackground`)
  }
}
